import 'package:flutter/material.dart';
import '../../constants/cities.dart';

class WeatherSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final VoidCallback onLocationPressed;

  const WeatherSearchBar({
    Key? key,
    required this.controller,
    required this.onSubmitted,
    required this.onLocationPressed,
  }) : super(key: key);

  @override
  State<WeatherSearchBar> createState() => _WeatherSearchBarState();
}

class _WeatherSearchBarState extends State<WeatherSearchBar> {
  List<String> _suggestions = [];
  bool _showSuggestions = false;

  void _updateSuggestions(String query) {
    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
      return;
    }

    final filteredCities =
        Cities.commonCities
            .where((city) => city.toLowerCase().contains(query.toLowerCase()))
            .toList();

    setState(() {
      _suggestions = filteredCities;
      _showSuggestions = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: widget.controller,
            onChanged: _updateSuggestions,
            onSubmitted: (value) {
              setState(() => _showSuggestions = false);
              widget.onSubmitted(value);
            },
            decoration: InputDecoration(
              hintText: 'Search city...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.my_location),
                onPressed: () {
                  setState(() => _showSuggestions = false);
                  widget.onLocationPressed();
                },
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        if (_showSuggestions && _suggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_suggestions[index]),
                  onTap: () {
                    widget.controller.text = _suggestions[index];
                    setState(() => _showSuggestions = false);
                    widget.onSubmitted(_suggestions[index]);
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}

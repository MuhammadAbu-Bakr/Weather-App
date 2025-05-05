import 'package:flutter/material.dart';
import '../../constants/cities.dart';

class WeatherSearchBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }
          return Cities.commonCities.where((String city) =>
              city.toLowerCase().contains(textEditingValue.text.toLowerCase()));
        },
        onSelected: (String selection) {
          controller.text = selection;
          onSubmitted(selection);
        },
        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
          return TextField(
            controller: controller,
            focusNode: focusNode,
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              hintText: 'Search city...',
              hintStyle: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.my_location,
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
                onPressed: onLocationPressed,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: isDarkMode ? Colors.white24 : Colors.black12,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: isDarkMode ? Colors.white24 : Colors.black12,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: isDarkMode ? Colors.white : Colors.black54,
                ),
              ),
              filled: true,
              fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
            ),
            onSubmitted: onSubmitted,
          );
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              color: isDarkMode ? Colors.grey[800] : Colors.white,
              elevation: 4.0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return ListTile(
                      title: Text(
                        option,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      onTap: () {
                        onSelected(option);
                      },
                      hoverColor: isDarkMode ? Colors.grey[700] : Colors.grey[100],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

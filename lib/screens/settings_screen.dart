import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _unitSystem = 'metric';
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('darkMode') ?? false;
      _unitSystem = prefs.getString('unitSystem') ?? 'metric';
      _notificationsEnabled = prefs.getBool('notifications') ?? true;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode);
    await prefs.setString('unitSystem', _unitSystem);
    await prefs.setBool('notifications', _notificationsEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _saveSettings();
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _isDarkMode,
            onChanged: (value) => setState(() => _isDarkMode = value),
          ),
          const Divider(),
          const Text('Temperature Unit', style: TextStyle(fontWeight: FontWeight.bold)),
          RadioListTile<String>(
            title: const Text('Celsius (°C)'),
            value: 'metric',
            groupValue: _unitSystem,
            onChanged: (value) => setState(() => _unitSystem = value!),
          ),
          RadioListTile<String>(
            title: const Text('Fahrenheit (°F)'),
            value: 'imperial',
            groupValue: _unitSystem,
            onChanged: (value) => setState(() => _unitSystem = value!),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Weather Notifications'),
            value: _notificationsEnabled,
            onChanged: (value) => setState(() => _notificationsEnabled = value),
          ),
        ],
      ),
    );
  }
}
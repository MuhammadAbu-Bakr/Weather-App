import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: settings.isDarkMode,
                onChanged: (value) => settings.setDarkMode(value),
              ),
              const Divider(),
              const Text(
                'Temperature Unit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              RadioListTile<String>(
                title: const Text('Celsius (°C)'),
                value: 'metric',
                groupValue: settings.unitSystem,
                onChanged: (value) => settings.setUnitSystem(value!),
              ),
              RadioListTile<String>(
                title: const Text('Fahrenheit (°F)'),
                value: 'imperial',
                groupValue: settings.unitSystem,
                onChanged: (value) => settings.setUnitSystem(value!),
              ),
              const Divider(),
              SwitchListTile(
                title: const Text('Weather Notifications'),
                value: settings.notificationsEnabled,
                onChanged: (value) => settings.setNotificationsEnabled(value),
              ),
            ],
          );
        },
      ),
    );
  }
}

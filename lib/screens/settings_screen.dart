import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paramètres")),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profil"),
            onTap: () {
              // TODO: Naviguer vers une page profil
            },
          ),
          SwitchListTile(
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (val) {
              // TODO: gérer le changement de thème (via Provider/BLoC/SettingsService)
            },
            title: const Text("Mode sombre"),
          ),
          ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Déconnexion"),
              onTap: () {} // => _logout(context),
              ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ListTileExample extends StatefulWidget {
  const ListTileExample({super.key});

  @override
  State<ListTileExample> createState() => _ListTileExampleState();
}

class _ListTileExampleState extends State<ListTileExample> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: const Text("User Profil"),
              subtitle: const Text("View or Edit User Profil"),
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1682686579688-c2ba945eda0e?q=80&w=2370&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              ),
              trailing: const Icon(Icons.forward),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ExampleTextField extends StatefulWidget {
  const ExampleTextField({super.key});

  @override
  State<ExampleTextField> createState() => _ExampleTextFieldState();
}

class _ExampleTextFieldState extends State<ExampleTextField> {
  TextEditingController user = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: user,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: "Enter your name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

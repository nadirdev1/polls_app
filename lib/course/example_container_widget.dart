import 'package:flutter/material.dart';

class ExampleContainerWidget extends StatefulWidget {
  const ExampleContainerWidget({super.key});

  @override
  State<ExampleContainerWidget> createState() => _ExampleContainerWidgetState();
}

class _ExampleContainerWidgetState extends State<ExampleContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(top: 20, left: 50),
              //color: Colors.red, //Cannot provide both a color and decoration
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    const BoxShadow(color: Colors.black, blurRadius: 10)
                  ]),
              child: const Center(
                child: Text(
                  "Hello Flutter Team",
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 200,
                height: 30,
                margin: const EdgeInsets.all(10),
                //padding: const EdgeInsets.only(top: 20, left: 50),
                //color: Colors.red, //Cannot provide both a color and decoration
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 1),
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      const BoxShadow(color: Colors.black26, blurRadius: 10)
                    ]),
                child: const Center(
                  child: Text(
                    "Login Button",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ExampleExpandedWidget extends StatefulWidget {
  const ExampleExpandedWidget({super.key});

  @override
  State<ExampleExpandedWidget> createState() => __ExampleExpandedWidgetState();
}

class __ExampleExpandedWidgetState extends State<ExampleExpandedWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      // height: 200,
                      //transform: Matrix4.rotationY(.2),
                      //margin: const EdgeInsets.all(10),
                      //padding: const EdgeInsets.only(top: 20, left: 50),
                      //color: Colors.red, //Cannot provide both a color and decoration
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 1),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            const BoxShadow(
                                color: Colors.black26, blurRadius: 10)
                          ]),
                      child: const Center(
                        child: Text(
                          "Login Button",
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      //height: 200,
                      //transform: Matrix4.rotationY(.2),
                      //margin: const EdgeInsets.all(10),
                      //padding: const EdgeInsets.only(top: 20, left: 50),
                      //color: Colors.red, //Cannot provide both a color and decoration
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 1),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            const BoxShadow(
                                color: Colors.black26, blurRadius: 10)
                          ]),
                      child: const Center(
                        child: Text(
                          "Login Button",
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      // height: 200,
                      //transform: Matrix4.rotationY(.2),
                      //margin: const EdgeInsets.all(10),
                      //padding: const EdgeInsets.only(top: 20, left: 50),
                      //color: Colors.red, //Cannot provide both a color and decoration
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 1),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            const BoxShadow(
                                color: Colors.black26, blurRadius: 10)
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
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      //height: 200,
                      //transform: Matrix4.rotationY(.2),
                      //margin: const EdgeInsets.all(10),
                      //padding: const EdgeInsets.only(top: 20, left: 50),
                      //color: Colors.red, //Cannot provide both a color and decoration
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 1),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            const BoxShadow(
                                color: Colors.black26, blurRadius: 10)
                          ]),
                      child: const Center(
                        child: Text(
                          "Login Button",
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 200,
                      //transform: Matrix4.rotationY(.2),
                      //margin: const EdgeInsets.all(10),
                      //padding: const EdgeInsets.only(top: 20, left: 50),
                      //color: Colors.red, //Cannot provide both a color and decoration
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 1),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            const BoxShadow(
                                color: Colors.black26, blurRadius: 10)
                          ]),
                      child: const Center(
                        child: Text(
                          "Login Button",
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 200,
                      //transform: Matrix4.rotationY(.2),
                      //margin: const EdgeInsets.all(10),
                      //padding: const EdgeInsets.only(top: 20, left: 50),
                      //color: Colors.red, //Cannot provide both a color and decoration
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 1),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            const BoxShadow(
                                color: Colors.black26, blurRadius: 10)
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
          ],
        ),
      ),
    );
  }
}

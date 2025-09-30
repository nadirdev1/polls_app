import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularAvatar extends StatefulWidget {
  const CircularAvatar({super.key});

  @override
  State<CircularAvatar> createState() => _CircularAvatarState();
}

class _CircularAvatarState extends State<CircularAvatar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*  Container(
              height: 100,
              width: 100,
              color: Colors.amber,
            ),
            Divider(
              color: Colors.grey,
              indent: 50,
              endIndent: 50,
              thickness: 0.5,
              height: 2,
            ),
            SizedBox(height: 50),
            CircleAvatar(
              minRadius: 50,
              maxRadius: 100,
              backgroundColor: Colors.orange,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1682686579688-c2ba945eda0e?q=80&w=2370&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            ), */
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1682686579688-c2ba945eda0e?q=80&w=2370&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                  ),
                  Transform.translate(
                    offset: Offset(
                      80 * math.cos(math.pi / 3),
                      80 * math.sin(math.pi / 3),
                    ),
                    child: const Icon(
                      Icons.add_a_photo_outlined,
                      size: 40,
                      color: Colors.black,
                      fill: 0.4,
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

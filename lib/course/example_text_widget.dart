import 'package:flutter/material.dart';

class ExampleTextWidget extends StatefulWidget {
  const ExampleTextWidget({super.key});

  @override
  State<ExampleTextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<ExampleTextWidget> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Text(
          "Styled Text trèèèè trèèèèè rttrtr rtgdxhjx gshs zshs susus susjs susjsu ssus susus. ",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 20,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.underline,
            letterSpacing: 2.0,
            wordSpacing: 4.0,
          ),
        ),
      ),
    );
  }
}

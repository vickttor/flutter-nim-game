import 'package:flutter/material.dart';
import 'package:flutter_nim_game/constants.dart';

class StartTitle extends StatelessWidget {
  const StartTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          "NIM\nGAME",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Goldman",
            fontWeight: FontWeight.bold,
            height: 0.8,
            fontSize: 190,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 32
              ..color = Colors.black,
          ),
        ),
        const Text(
          "NIM\nGAME",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(white),
            fontFamily: "Goldman",
            fontWeight: FontWeight.bold,
            height: 0.8,
            fontSize: 190,
          ),
        ),
      ],
    );
  }
}

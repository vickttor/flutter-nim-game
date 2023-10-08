import 'package:flutter/material.dart';
import 'package:flutter_nim_game/constants.dart';

class TotalStickTitle extends StatelessWidget {
  const TotalStickTitle({super.key, required this.totalStick});

  final int totalStick;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          totalStick.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Goldman",
            fontWeight: FontWeight.bold,
            height: 0.8,
            fontSize: 120,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 32
              ..color = Colors.black,
          ),
        ),
        Text(
          totalStick.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(white),
            fontFamily: "Goldman",
            fontWeight: FontWeight.bold,
            height: 0.8,
            fontSize: 120,
          ),
        ),
      ],
    );
  }
}

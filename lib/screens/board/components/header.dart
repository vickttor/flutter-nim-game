import 'package:flutter/material.dart';
import 'package:flutter_nim_game/constants.dart';
import 'package:flutter_nim_game/screens/board/components/total_sticks_title.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({
    super.key,
    required this.turnAmount,
    required this.totalSticks,
  });

  final int turnAmount;
  final int totalSticks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "$turnAmount° Turno".toUpperCase(),
            style: const TextStyle(
              color: Color(white),
              fontSize: 40.0,
              fontFamily: "Goldman",
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TotalStickTitle(totalStick: totalSticks),
                const SizedBox(width: 16.0),
                Image.asset(
                  "assets/stick.png",
                  width: 50,
                  height: 100,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

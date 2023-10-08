import 'package:flutter/material.dart';
import 'package:flutter_nim_game/enums/turn.dart';
import 'package:flutter_nim_game/models/stick.dart';

typedef OnSelectStickCallBack = void Function(Stick stick);

class Phosphor extends StatelessWidget {
  const Phosphor({
    super.key,
    required this.stick,
    required this.turn,
    required this.onSelectStick,
  });

  final Stick stick;
  final Turn turn;
  final OnSelectStickCallBack onSelectStick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelectStick(stick);
      },
      child: Container(
          decoration: BoxDecoration(
            color: stick.isRendering() && stick.selectedBy == turn
                ? const Color.fromARGB(255, 17, 21, 29).withOpacity(0.75)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 32.0,
          ),
          child: Opacity(
            opacity: stick.isRendering() ? 1 : 0.15,
            child: Image.asset(
              "assets/stick.png",
              width: 50,
              height: 100,
            ),
          )),
    );
  }
}

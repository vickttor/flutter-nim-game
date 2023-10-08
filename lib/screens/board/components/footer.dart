import 'package:flutter/material.dart';
import 'package:flutter_nim_game/constants.dart';
import 'package:flutter_nim_game/enums/turn.dart';
import 'package:flutter_nim_game/screens/board/board.dart';

class GameFooter extends StatelessWidget {
  const GameFooter({
    super.key,
    required this.turn,
    required this.playerRound,
  });

  final Turn turn;
  final PlayerRoundCallback playerRound;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "RODADA:",
                  style: TextStyle(
                    color: Color(white),
                    fontSize: 40.0,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16.0),
                Text(
                  (turn == Turn.machine ? "COMPUTADOR" : "SUA VEZ")
                      .toUpperCase(),
                  style: TextStyle(
                    color: Color(turn == Turn.machine ? primary : secondary),
                    fontSize: 40.0,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color(secondary)),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
              padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 42.0, vertical: 16.0)),
            ),
            onPressed: () {
              playerRound(context);
            },
            child: Text(
              "PRONTO".toUpperCase(),
              style: const TextStyle(
                fontSize: 44,
                fontFamily: "ChangaOne",
                color: Color(white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

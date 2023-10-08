import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_nim_game/constants.dart';
import 'package:flutter_nim_game/enums/turn.dart';
import 'package:flutter_nim_game/models/stick.dart';
import 'package:flutter_nim_game/screens/board/board.dart';
import 'package:flutter_nim_game/screens/start/start.dart';

var rng = Random();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Nimgame();
  }
}

class Nimgame extends StatefulWidget {
  const Nimgame({super.key});

  @override
  State<Nimgame> createState() => _NimgameState();
}

class _NimgameState extends State<Nimgame> {
  late int stickAmount;
  late int stickAmountRemovableByRound;
  late int rounds;
  late Turn turn;
  late List<Stick> sticks;

  @override
  void initState() {
    super.initState();

    stickAmount = 0;
    stickAmountRemovableByRound = 0;
    rounds = 1;
    turn = Turn.stopped;
    sticks = [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setStickAmount(int stickAmount) {
    setState(() {
      this.stickAmount = stickAmount;
    });
  }

  void setStickAmountRemovableByRound(int stickAmountRemovableByRound) {
    setState(() {
      this.stickAmountRemovableByRound = stickAmountRemovableByRound;
    });
  }

  /// Ponto de entrada para execução do jogo NIM.
  start(BuildContext context) {
    final bool multiple = stickAmount % (stickAmountRemovableByRound + 1) == 0;

    List<Stick> temp = [];

    for (int i = 0; i < stickAmount; i++) {
      temp.add(Stick(selectedBy: Turn.stopped, pickedUp: false));
    }

    setState(() {
      if (multiple) {
        turn = Turn.player;
      } else {
        turn = Turn.machine;
      }

      sticks = temp;
    });

    if (turn == Turn.machine) {
      _machineRound(stickAmount, stickAmountRemovableByRound, context);
    }
  }

  void _machineRound(int n, int m, BuildContext context) {
    int amountToBeRemoved = 0;
    List<int> choosenSticksIndexes = [];

    List<int> avaiableToBeRemoved = sticks
        .where((s) => s.isRendering())
        .where((s) => s.getSelectedBy() == Turn.stopped)
        .map((e) => sticks.indexOf(e))
        .toList();

    int guess = n % (m + 1);

    if (guess == 0 || guess == 1) {
      amountToBeRemoved = max(1, m);
    } else {
      amountToBeRemoved = guess - 1;
    }

    if (n - amountToBeRemoved == 0) {
      _announceWinner(context);
    }

    // Escolhendo palitos aleatórios para serem removidos
    for (int i = 0; i < amountToBeRemoved; i++) {
      int choosenStickIndex =
          avaiableToBeRemoved[rng.nextInt(avaiableToBeRemoved.length)];

      if (!choosenSticksIndexes.contains(choosenStickIndex)) {
        choosenSticksIndexes.add(choosenStickIndex);
      } else {
        i--;
      }
    }

    setState(() {
      for (int index in choosenSticksIndexes) {
        Stick selectedStick = sticks.elementAt(index);
        selectedStick.setPickedUp(true);
        selectedStick.setSelectedBy(turn);
      }

      turn = Turn.player;
      rounds++;
      stickAmount -= amountToBeRemoved;
    });
  }

  void _playerRound(int n, int m, BuildContext context) {
    List<Stick> selectedSticks = sticks
        .where((s) => s.isRendering())
        .where((s) => s.getSelectedBy() == Turn.player)
        .toList();

    int selectedSticksAmount = selectedSticks.length;

    if (selectedSticksAmount > 0 && selectedSticksAmount <= m) {
      setState(() {
        for (var s in selectedSticks) {
          s.setPickedUp(true);
        }

        turn = Turn.machine;
        rounds++;
        stickAmount -= selectedSticksAmount;
      });

      if (n - selectedSticksAmount == 0) {
        _announceWinner(context);
      } else {
        _machineRound(n - selectedSticksAmount, m, context);
      }
    }
  }

  void selectStick(
    Stick stick,
  ) {
    List<Stick> selectedSticks = sticks
        .where((s) => s.isRendering())
        .where((s) => s.getSelectedBy() == Turn.player)
        .toList();

    int selectedSticksAmount = selectedSticks.length;

    setState(() {
      sticks = sticks.map((s) {
        if (s.id == stick.id) {
          if (stick.getSelectedBy() == turn) {
            stick.setSelectedBy(Turn.stopped);
          } else {
            if (selectedSticksAmount < stickAmountRemovableByRound) {
              stick.setSelectedBy(turn);
            }
            return stick;
          }
        }
        return s;
      }).toList();
    });
  }

  void reset() {
    Navigator.pushNamed(context, "/");

    setState(() {
      stickAmount = 0;
      stickAmountRemovableByRound = 0;
      rounds = 1;
      sticks = [];
      turn = Turn.stopped;
    });
  }

  void _announceWinner(BuildContext context) {
    // Open Popup here to show the winner

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Color(background),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(105, 0, 0, 0),
                blurRadius: 8.0,
                spreadRadius: 1,
              )
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0)),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Vencedor'.toUpperCase(),
                  style: const TextStyle(
                    color: Color(white),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w900,
                    fontSize: 64.0,
                  ),
                ),
                const SizedBox(height: 64.0),
                Text(
                  (turn == Turn.machine ? 'Computador' : 'Você').toUpperCase(),
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w900,
                    fontSize: 78.0,
                    color: turn == Turn.machine
                        ? const Color(primary)
                        : const Color(secondary),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Jogadas: $rounds
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Nim Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color(primary),
          secondary: Color(secondary),
        ),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => Start(
            setStickAmount: setStickAmount,
            setStickAmountRemovableByRound: setStickAmountRemovableByRound),
        "/game": (context) => NimBoard(
            handleStart: start,
            onSelectStick: selectStick,
            stickList: sticks,
            stickAmount: stickAmount,
            stickAmountRemovableByRound: stickAmountRemovableByRound,
            playerRound: (context) =>
                _playerRound(stickAmount, stickAmountRemovableByRound, context),
            totalRounds: rounds,
            turn: turn),
      },
    );
  }
}

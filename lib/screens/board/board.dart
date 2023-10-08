import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_nim_game/constants.dart';
import 'package:flutter_nim_game/enums/turn.dart';
import 'package:flutter_nim_game/models/stick.dart';
import 'package:flutter_nim_game/screens/board/components/footer.dart';
import 'package:flutter_nim_game/screens/board/components/header.dart';
import 'package:flutter_nim_game/screens/board/components/stick.dart';

typedef OnSelectStickCallBack = void Function(Stick stick);
typedef PlayerRoundCallback = void Function(BuildContext context);
typedef StartHandleCallback = void Function(BuildContext context);

class NimBoard extends StatefulHookWidget {
  const NimBoard({
    super.key,
    required this.stickAmount,
    required this.stickAmountRemovableByRound,
    required this.playerRound,
    required this.turn,
    required this.totalRounds,
    required this.handleStart,
    required this.stickList,
    required this.onSelectStick,
  });

  final List<Stick> stickList;
  final StartHandleCallback handleStart;
  final int stickAmount;
  final int stickAmountRemovableByRound;
  final PlayerRoundCallback playerRound;
  final Turn turn;
  final int totalRounds;
  final OnSelectStickCallBack onSelectStick;

  @override
  State<NimBoard> createState() => _NimBoardState();
}

class _NimBoardState extends State<NimBoard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.handleStart(context);
      });
      return null;
    }, []);

    return Scaffold(body: LayoutBuilder(builder: (buildContext, constraints) {
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        color: const Color(background),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              width: constraints.maxWidth,
              left: 0,
              bottom: 0,
              child: Image.asset(
                "assets/wave_light.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GameHeader(
                      turnAmount: widget.totalRounds,
                      totalSticks: widget.stickAmount,
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 120.0),
                          child: GridView.builder(
                            itemCount: widget.stickList.length,
                            itemBuilder: ((context, index) {
                              return Phosphor(
                                key: Key(widget.stickList.elementAt(index).id),
                                stick: widget.stickList.elementAt(index),
                                turn: widget.turn,
                                onSelectStick: widget.onSelectStick,
                              );
                            }),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 10,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GameFooter(
                      turn: widget.turn,
                      playerRound: widget.playerRound,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }));
  }
}

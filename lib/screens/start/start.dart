import 'package:flutter/material.dart';
import 'package:flutter_nim_game/constants.dart';
import 'package:flutter_nim_game/screens/start/components/rules_form.dart';
import 'package:flutter_nim_game/screens/start/components/start_title.dart';

typedef SettersCallback = void Function(int number);

class Start extends StatefulWidget {
  const Start({
    super.key,
    required this.setStickAmount,
    required this.setStickAmountRemovableByRound,
  });

  final SettersCallback setStickAmount;
  final SettersCallback setStickAmountRemovableByRound;

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  int currentIndex = 0;
  final PageController pageController = PageController();

  void gotToNextPage() {
    currentIndex++;
    pageController.nextPage(
      duration: const Duration(milliseconds: 800),
      curve: Curves.ease,
    );
  }

  void goToPreviousPage() {
    currentIndex++;
    pageController.previousPage(
      duration: const Duration(milliseconds: 800),
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                "assets/wave_dark.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: PageView(
                  controller: pageController,
                  children: [
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const StartTitle(),
                          const SizedBox(height: 150),
                          TextButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(primary)),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                              ),
                              padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 24.0, horizontal: 120),
                              ),
                            ),
                            onPressed: gotToNextPage,
                            child: Text(
                              "Jogar".toUpperCase(),
                              style: const TextStyle(
                                fontSize: 88,
                                fontFamily: "ChangaOne",
                                color: Color(white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 120,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Feito Por: ",
                                style: TextStyle(
                                  color: Color(gray),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.0,
                                ),
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                "Victor Hugo da Silva",
                                style: TextStyle(
                                  color: Color(secondary),
                                  fontFamily: "Inter",
                                  fontSize: 24.0,
                                ),
                              ),
                              SizedBox(
                                width: 32.0,
                              ),
                              Text(
                                "RA:",
                                style: TextStyle(
                                  color: Color(gray),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.0,
                                ),
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                "1431432312001",
                                style: TextStyle(
                                  color: Color(secondary),
                                  fontSize: 24.0,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    StartRulesForm(
                        setStickAmount: widget.setStickAmount,
                        setStickAmountRemovableByRound:
                            widget.setStickAmountRemovableByRound,
                        goToPreviousPage: goToPreviousPage),
                  ],
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }));
  }
}

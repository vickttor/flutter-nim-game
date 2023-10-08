import 'package:flutter/material.dart';
import 'package:flutter_nim_game/components/text_field.dart';
import 'package:flutter_nim_game/constants.dart';

typedef SettersCallback = void Function(int number);

class StartRulesForm extends StatefulWidget {
  const StartRulesForm({
    super.key,
    required this.setStickAmount,
    required this.setStickAmountRemovableByRound,
    required this.goToPreviousPage,
  });

  final SettersCallback setStickAmount;
  final SettersCallback setStickAmountRemovableByRound;
  final VoidCallback goToPreviousPage;

  @override
  State<StartRulesForm> createState() => _StartFormSRulestate();
}

class _StartFormSRulestate extends State<StartRulesForm> {
  final _formKey = GlobalKey<FormState>();
  final stickAmountTextController = TextEditingController();
  final stickAmountRemovableByRoundController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    stickAmountTextController.dispose();
    stickAmountRemovableByRoundController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (buildContext, constraints) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                ),
                onPressed: () {
                  widget.goToPreviousPage();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 32.0,
                ),
                label: Text(
                  "Voltar".toUpperCase(),
                  style:
                      const TextStyle(fontSize: 24.0, fontFamily: "ChangaOne"),
                ),
              )
            ],
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                  width: constraints.maxWidth > 500 ? 500 : double.infinity,
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: const Color(background),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(105, 0, 0, 0),
                        blurRadius: 8.0,
                        spreadRadius: 1,
                      )
                    ],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TTextField(
                          controller: stickAmountTextController,
                          title: "Total de Palitos",
                          placeholder:
                              "Inisira o número de palitos para o jogo",
                          validator: (value) {
                            if (value != null) {
                              int? parsedValue = int.tryParse(value);

                              if (parsedValue != null) {
                                if (parsedValue < 2) {
                                  return "Insira um valor acima de 2";
                                } else {
                                  return null;
                                }
                              } else {
                                return "Insira apenas valores numéricos";
                              }
                            } else {
                              return "Insira a quantidade de palitos";
                            }
                          },
                        ),
                        const SizedBox(height: 24.0),
                        TTextField(
                          controller: stickAmountRemovableByRoundController,
                          title: "Total de Remoções",
                          placeholder: "Quantidade de remoções por rodada",
                          validator: (value) {
                            if (value != null) {
                              int? parsedValue = int.tryParse(value);
                              int? parsedStickAmount =
                                  int.tryParse(stickAmountTextController.text);

                              if (parsedValue != null) {
                                if (parsedValue < 1 ||
                                    parsedValue >= (parsedStickAmount ?? 0)) {
                                  return 'Insira um valor maior ou igual a 1 e menor que o total de palitos';
                                } else {
                                  return null;
                                }
                              } else {
                                return "Insira apenas valores numéricos";
                              }
                            } else {
                              return "Insira a quantidade de palitos";
                            }
                          },
                        ),
                        const SizedBox(height: 32.0),
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.setStickAmount(
                                  int.parse(stickAmountTextController.text));
                              widget.setStickAmountRemovableByRound(int.parse(
                                  stickAmountRemovableByRoundController.text));

                              Navigator.pushNamed(context, "/game");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(primary),
                            padding: const EdgeInsets.all(24.0),
                            fixedSize: const Size.fromWidth(500),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                          ),
                          child: Text(
                            "Iniciar".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 32,
                              fontFamily: "ChangaOne",
                              color: Color(white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          )
        ],
      );
    });
  }
}

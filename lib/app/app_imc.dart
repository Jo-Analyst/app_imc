import 'package:app_imc/app/template/input_text.dart';
import 'package:flutter/material.dart';

class AppIMC extends StatefulWidget {
  const AppIMC({super.key});

  @override
  State<AppIMC> createState() => _AppIMCState();
}

class _AppIMCState extends State<AppIMC> {
  double weight = 0, height = 0, imc = 0;
  String observation = "";

  void calculateIMC() {
    if (!validateFields()) return;

    setState(() {
      imc = weight / (height * height);
      showObservation();
    });
  }

  bool validateFields() {
    bool isValid = false;
    if (weight == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Informe seu peso."),
          duration: Duration(seconds: 5),
        ),
      );
    } else if (height == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Informe sua altura."),
          duration: Duration(seconds: 5),
        ),
      );
    } else {
      isValid = true;
    }

    return isValid;
  }

  void showObservation() {
    setState(() {
      if (imc < 18) {
        observation = "Você está abaixo do peso.";
      } else if (imc < 24) {
        observation = "Você está no peso normal.";
      } else if (imc < 30) {
        observation = "Você está acima do peso.";
      } else if (imc > 30) {
        observation = "Opa!  Você está em um ponto crítico.";
      }
    });
  }

  void resetIMC() {
    setState(() {
      if (weight == 0 && height == 0) {
        imc = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IMC"),
        toolbarHeight: 80,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Column(
          children: [
            InputText(
              label: "Seu peso",
              getValueInput: (value) {
                weight = value;
                resetIMC();
              },
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 40,
              ),
              child: InputText(
                label: "Sua altura",
                getValueInput: (value) {
                  height = value;
                  resetIMC();
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => calculateIMC(),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calculate_outlined,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Calcular",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "IMC:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    imc.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "OBS:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    observation,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

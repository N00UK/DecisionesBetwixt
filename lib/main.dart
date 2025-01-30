// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Betwixt',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        home: const MyHomePage(title: 'Betwixt'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController opcionUn = TextEditingController();
  TextEditingController opcionDo = TextEditingController();

  String decision = '';
  bool isLoading = false;

  void elegirOpcion() async {
    final opcionUno = opcionUn.text;
    final opcionDos = opcionDo.text;

    if (opcionUno.isEmpty || opcionDos.isEmpty) {
      decision = 'Ingresa las dos opciones';
    } else {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      final opciones = [opcionUno, opcionDos];
      final random = Random();
      decision = opciones[random.nextInt(opciones.length)];
      setState(() {
        isLoading = false;
      });
    }
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 11, 54, 63),
        body: Center(
            child: SizedBox(
                width: 400,
                height: 400,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.psychology_alt,
                          color: Color.fromARGB(255, 110, 217, 161), size: 80),
                      campoText(opcionUn, 'Opcion 1'),
                      campoText(opcionDo, 'Opcion 2'),
                      SizedBox(
                          width: 600,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                boton(() {
                                  setState(() {
                                    elegirOpcion();
                                  });
                                }, 'Decidir'),
                                boton(() {
                                  setState(() {
                                    decision = '';
                                    opcionUn.clear();
                                    opcionDo.clear();
                                    FocusScope.of(context).unfocus();
                                  });
                                }, 'Limpiar')
                              ])),
                      isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 110, 217, 161)))
                          : Text(decision,
                              style: const TextStyle(color: Colors.white))
                    ]))));
  }
}

campoText(TextEditingController controlador, String text) {
  return SizedBox(
      width: 250,
      child: TextField(
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
          controller: controlador,
          decoration: InputDecoration(
              hintText: text,
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 216, 216, 216)),
              border: const OutlineInputBorder())));
}

boton(VoidCallback funcion, String text) {
  return InkWell(
      onTap: funcion,
      child: SizedBox(
          width: 100,
          height: 50,
          child: ColoredBox(
              color: Colors.white, child: Center(child: Text(text)))));
}

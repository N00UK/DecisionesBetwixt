// ignore_for_file: avoid_print, use_build_context_synchronously

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

  String decision = "";
  bool isLoading = false;
  String ultimasOpciones = "";

  void elegirOpcion() async {
    final opcionesTexto = opcionUn.text;

    if (opcionesTexto.isEmpty) {
      decision = "Ingresa las opciones separadas por comas";
    } else {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      final opciones = opcionesTexto.split(',').map((e) => e.trim()).toList();

      final random = Random();
      decision = opciones[random.nextInt(opciones.length)];
      setState(() {
        isLoading = false;
      });
    }
    FocusScope.of(context).unfocus();
  }

  void lista() async {
    final opcionesTexto = opcionUn.text;
    if (opcionesTexto.isEmpty) {
      decision = "Ingresa las opciones separadas por comas";
    } else {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      final opciones = opcionesTexto.split(',').map((e) => e.trim()).toList();

      opciones.shuffle();
      decision = opciones.join(', ');
      setState(() {
        isLoading = false;
      });
    }
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  void guardar() {
    ultimasOpciones = opcionUn.text;
  }

  void recuperar() {
    opcionUn.text = ultimasOpciones;
  }

  void limpiar() {
    setState(() {
      decision = "";
      opcionUn.clear();
      FocusScope.of(context).unfocus();
    });
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
                      campoText(opcionUn, 'Separa las opciones con una coma'),
                      SizedBox(
                          width: 600,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                boton(() {
                                  guardar();
                                  elegirOpcion();
                                }, Icons.done),
                                boton(() {
                                  guardar();
                                  lista();
                                }, Icons.format_list_numbered_rtl),
                                boton(() => recuperar(), Icons.replay),
                                boton(() => limpiar(), Icons.clear)
                              ])),
                      isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 110, 217, 161)))
                          : SizedBox(
                              width: 340,
                              child: Text(decision,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white)))
                    ]))));
  }
}

campoText(TextEditingController controlador, String text) {
  return SizedBox(
      width: 330,
      height: 200,
      child: TextField(
          maxLines: null,
          expands: true,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
          controller: controlador,
          decoration: InputDecoration(
              hintText: text,
              contentPadding: const EdgeInsets.all(10),
              border: const OutlineInputBorder(),
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 216, 216, 216)))));
}

boton(VoidCallback funcion, IconData icono) {
  return SizedBox(
      width: 40,
      child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          onPressed: funcion,
          child: Icon(icono, color: const Color.fromARGB(255, 110, 217, 161))));
}

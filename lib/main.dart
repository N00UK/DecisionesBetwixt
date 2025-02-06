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

      final opciones = opcionesTexto
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      if (opciones.isEmpty) {
        decision = "No hay opciones válidas";
      } else {
        final random = Random();
        decision = opciones[random.nextInt(opciones.length)];
      }

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

      final opciones = opcionesTexto
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      if (opciones.isEmpty) {
        decision = "No hay opciones válidas";
      } else {
        opciones.shuffle();
        decision = opciones.asMap().entries.map((entry) {
          return '${entry.key + 1}. ${entry.value}';
        }).join('\n');
      }

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

  void info() {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
              insetPadding: EdgeInsets.symmetric(vertical: 50),
              content: SizedBox(
                  width: 100,
                  height: 300,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("DecideMe",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20)),
                        Text(
                            "Para que la aplicación funcione de una manera adecuada, separa cada idea con una coma (,) para que el sistema las reconozca como elementos distintos.",
                            textAlign: TextAlign.justify),
                        SizedBox(
                            width: 400,
                            child: Row(children: [
                              Icon(Icons.check_circle),
                              Text(
                                  "Este botón elige una idea al azar\nentre las que ingresaste.")
                            ])),
                        SizedBox(
                            width: 400,
                            child: Row(children: [
                              Icon(Icons.playlist_add_check_circle),
                              Text("Mezcla y ordena tus ideas al azar.")
                            ])),
                        SizedBox(
                            width: 400,
                            child: Row(children: [
                              Icon(Icons.replay_circle_filled),
                              Text(
                                  "Restaura las opciones que ingresaste\npor última vez.")
                            ])),
                        SizedBox(
                            width: 400,
                            child: Row(children: [
                              Icon(Icons.cancel),
                              Text("Limpia todas las ideas ingresadas.")
                            ]))
                      ])));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 11, 54, 63),
        body: Center(
            child: SizedBox(
                width: 400,
                height: 750,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [boton(() => info(), Icons.help)]),
                      SizedBox(
                          height: 600,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                    child: Icon(Icons.psychology_alt,
                                        color:
                                            Color.fromARGB(255, 110, 217, 161),
                                        size: 80)),
                                campoText(opcionUn,
                                    'Separa las opciones con una coma'),
                                SizedBox(
                                    width: 600,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          boton(() {
                                            guardar();
                                            elegirOpcion();
                                          }, Icons.check_circle),
                                          boton(() {
                                            guardar();
                                            lista();
                                          }, Icons.playlist_add_check_circle),
                                          boton(() => recuperar(),
                                              Icons.replay_circle_filled),
                                          boton(() => limpiar(), Icons.cancel)
                                        ])),
                                isLoading
                                    ? const CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<
                                                Color>(
                                            Color.fromARGB(255, 110, 217, 161)))
                                    : SizedBox(
                                        width: 340,
                                        height: 150,
                                        child: Center(
                                            child: Scrollbar(
                                                child: SingleChildScrollView(
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    child: Text(decision,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .white))))))
                              ])),
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: funcion,
          child: Icon(icono,
              color: const Color.fromARGB(255, 110, 217, 161), size: 35)));
}

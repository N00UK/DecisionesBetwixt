
  // void elegirOpcion() async {
  //   final opcionUno = opcionUn.text;
  //   final opcionDos = opcionDo.text;

  //   if (opcionUno.isEmpty || opcionDos.isEmpty) {
  //     decision = 'Ingresa las dos opciones';
  //   } else {
  //     setState(() {
  //       isLoading = true;
  //     });

  //     await Future.delayed(const Duration(seconds: 2));
  //     final opciones = [opcionUno, opcionDos];
  //     final random = Random();
  //     decision = opciones[random.nextInt(opciones.length)];

  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  //   FocusScope.of(context).unfocus();
  //   setState(() {});
  // }


                      // isLoading
                      //     ? const CircularProgressIndicator(
                      //         valueColor: AlwaysStoppedAnimation<Color>(
                      //             Color.fromARGB(255, 110, 217, 161)),
                      //       )
                      //     : Text(decision,
                      //         style: const TextStyle(color: Colors.white))



// ---------------------------------------- codigo main
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pagina',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Pagina'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center());
//   }
// }

// ---------------------------------------- primer boton
// boton(VoidCallback funcion, String text) {
//   return InkWell(
//       onTap: funcion,
//       child: SizedBox(
//           width: 100,
//           height: 50,
//           child: ColoredBox(
//               color: Colors.white, child: Center(child: Text(text)))));
// }
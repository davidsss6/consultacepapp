import 'package:consultacepapp/pages/consulta_cep.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.teal),
      home: const ConsultaCepPagState()
      //home: const ImcPagState(),
    );
  }
}
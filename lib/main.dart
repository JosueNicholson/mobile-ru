import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ru/views/app_view.dart';
import 'package:mobile_ru/views/matricula.dart';
import 'package:mobile_ru/bloc/votacao_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  VotacaoBloc _votacaoBloc = Get.put(VotacaoBloc());
  bool hasMatricula = false;

  @override
  void initState() {
    _votacaoBloc.getMatricula().then((matricula){
      setState(() {
        hasMatricula = matricula != null;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            backgroundColor: Color(0xFFE5E5E5)
        ),
        home: hasMatricula ? AppView() : Matricula(),
    );
  }
}



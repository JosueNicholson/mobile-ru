import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ru/bloc/votacao_bloc.dart';
import 'package:mobile_ru/views/app_view.dart';
import 'package:mobile_ru/widgets/action_button.dart';

class Matricula extends StatefulWidget {

  @override
  _MatriculaState createState() => _MatriculaState();
}

class _MatriculaState extends State<Matricula> {
  TextEditingController _inputMatricula = TextEditingController();
  bool _validateMatricula = false;

  @override
  Widget build(BuildContext context) {
    VotacaoBloc _votacaoBloc = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliacão Objetiva'),
        backgroundColor: Color(0xFFBA2B2B),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            tooltip: 'Informações',
            onPressed: () {
              showDialog(context: context, builder: (BuildContext context) {
                return new AlertDialog(
                  title: new Text("Informações", textAlign: TextAlign.center),
                  content: new RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 15, color: Colors.black),
                        children: [
                          TextSpan(text: "É importante você saber que sua matrícula "),
                          TextSpan(text: "não ", style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: "será usada para identificar seu voto, nem para "),
                          TextSpan(text: "qualquer outro fim que não seja garantir que não haja repetição de voto."),
                          TextSpan(text: " Sua matrícula será salva somente no seu celular. No nosso banco de dados "),
                          TextSpan(text: "será gravado somente uma representação criptografada dela.")
                        ]
                      )
                  )
                );
              });
            }
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Container(
                  child: Text(
                    'Para continuar digite sua matrícula.',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(0xff333333)),
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _inputMatricula,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Matrícula',
                    errorText: _validateMatricula ? 'A matrícula não pode ser vazia' : null,
                  ),
                )
              ],
            ),
            Column(
              children: [
                ActionButton('Salvar', (){
                  setState((){
                    _validateMatricula = _inputMatricula.text.isEmpty;
                  });
                  if(_inputMatricula.text.isNotEmpty) {
                    _votacaoBloc.saveMatricula(_inputMatricula.text);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AppView()));
                  }
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}


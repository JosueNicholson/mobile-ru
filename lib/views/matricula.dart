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
  TextEditingController _inputConfirmacaoMatricula = TextEditingController();
  bool _validateEmptyMatricula = false;
  bool _validateEmptyConfirmacaoMatricula = false;
  bool _validateEquality = false;
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    VotacaoBloc _votacaoBloc = Get.find();
    return Scaffold(

      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text('Identificação'),
        ),
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
                          TextSpan(text: "É importante você estar ciente de que sua matrícula "),
                          TextSpan(text: "não ", style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: "será usada para identificar seu voto, nem para qualquer"
                              " outro fim que não seja garantir que não haja repetição de voto."
                              " Sua matrícula será salva somente no seu celular. No nosso banco de"
                              " dados será gravada somente uma representação criptografada dela."),
                        ]
                      )
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
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
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.warning_amber_rounded, size: 30),
                      ),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(fontSize: 13, color: Colors.black),
                              children: [
                                TextSpan(
                                  text: "Atenção: Você",
                                ),
                                TextSpan(
                                    text: " não ",
                                    style: TextStyle(fontWeight: FontWeight.w600)
                                ),
                                TextSpan(
                                    text: "poderá editar sua matrícula após o primeiro voto. Certifique-se de que está correta."
                                )
                              ]
                          ),
                        )
                      )

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(4)
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
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
                    errorText: _validateEmptyMatricula ? 'A matrícula não pode ser vazia' : null,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Por favor, digite sua matrícula novamente.',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(0xff333333)),
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _inputConfirmacaoMatricula,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirmação de matrícula',
                    errorText: () {
                      if(_validateEmptyConfirmacaoMatricula) return 'A matrícula não pode ser vazia';
                      else if(_validateEquality) return 'As matrículas não são iguais';
                    }(),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ActionButton('Salvar', (){
                  setState((){
                    _validateEmptyMatricula = _inputMatricula.text.isEmpty;
                    _validateEmptyConfirmacaoMatricula = _inputConfirmacaoMatricula.text.isEmpty;
                    _validateEquality = _inputMatricula.text != _inputConfirmacaoMatricula.text;
                  });
                  if(!_validateEmptyMatricula && !_validateEmptyConfirmacaoMatricula && !_validateEquality) {
                    _votacaoBloc.saveMatricula(_inputMatricula.text);
                    FocusScope.of(context).requestFocus(focusNode);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AppView()));
                    showDialog(context: context, builder: (BuildContext context) {
                      return new AlertDialog(
                        title: new Text("Informações", textAlign: TextAlign.center),
                        content: new RichText(
                            text: TextSpan(
                                style: TextStyle(fontSize: 15, color: Colors.black),
                                children: [
                                  TextSpan(text: "É importante você estar ciente de que sua matrícula "),
                                  TextSpan(text: "não ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: "será usada para identificar seu voto, nem para qualquer"
                                      " outro fim que não seja garantir que não haja repetição de voto."
                                      " Sua matrícula será salva somente no seu celular. No nosso banco de"
                                      " dados será gravada somente uma representação criptografada dela."),
                                ]
                            )
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
                  }
                })
              ],
            )
          ],
        ),
      )
    );
  }
}


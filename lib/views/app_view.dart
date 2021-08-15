import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ru/bloc/votacao_bloc.dart';
import 'package:mobile_ru/views/tipo_proteina.dart';
import 'package:mobile_ru/widgets/action_button.dart';

class AppView extends StatefulWidget {
  const AppView({Key key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  VotacaoBloc _votacaoBloc = Get.find();
  bool _canVote = false;
  String _errorMessage = "Aguarde...";
  @override
  void initState() {

    _votacaoBloc.auth().then((value) {
      if(value.result == true) {
        _votacaoBloc.canRate().then((res) {
          setState(() {
            _canVote = res.result;
            _errorMessage = res.message;
          });
        });
      } else setState(() {_errorMessage = value.message;});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton("Remover matricula", (){_votacaoBloc.removeMatricula();}),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(fontSize: 40, color: Color(0xffBA2B2B)),
                      children: [
                        TextSpan(text: 'Mobile', style: TextStyle(fontWeight: FontWeight.w300)),
                        TextSpan(text: 'RU', style: TextStyle(fontWeight: FontWeight.w600))
                      ]
                  )
              ),
            ),
            if(_canVote) ActionButton('Iniciar Avaliação', (){
              Navigator.push(
               context, MaterialPageRoute(builder: (context) => TipoProteina())
             );
            }, width: MediaQuery.of(context).size.width * 0.5)
            else Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xffEEEEEE),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Text(
                  _errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFBA2B2B))
              ),
            )
          ],
        ),
      )
    );
  }
}

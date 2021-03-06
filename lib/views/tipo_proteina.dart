import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ru/bloc/votacao_bloc.dart';
import 'package:mobile_ru/models/TipoProteinaEnum.dart';
import 'package:mobile_ru/views/avaliacao_objetiva.dart';
import 'package:mobile_ru/widgets/select_button.dart';
import 'package:mobile_ru/widgets/action_button.dart';

class TipoProteina extends StatefulWidget {

  @override
  _TipoProteinaState createState() => _TipoProteinaState();
}

class _TipoProteinaState extends State<TipoProteina> {
  VotacaoBloc _votacaoBloc = Get.find();
  int _active = 0;

  @override
  Widget build(BuildContext context) {
    TipoProteinaEnum tipoProteina = _votacaoBloc.avaliacao.tipoProteina;

    switch (tipoProteina.nameProteina){
      case 'carneVermelha':
        _active = 1;
        break;
      case 'carneBranca':
        _active = 2;
        break;
      case 'vegetariano':
        _active = 3;
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliação - Escolha da proteína'),
        backgroundColor: Color(0xFFBA2B2B),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Qual foi a proteína da sua refeição?',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xff333333)),
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                ),
                SelectButton(_active, 1, 'Carne Vermelha', (v){
                  setState(() {
                    _active = 1;
                  });
                  _votacaoBloc.avaliacao.tipoProteina = TipoProteinaEnum.carneVermelha;
                }),
                SelectButton(_active, 2, 'Carne Branca', (v){
                  setState(() { _active = 2; });
                  _votacaoBloc.avaliacao.tipoProteina = TipoProteinaEnum.carneBranca;
                }),
                SelectButton(_active, 3, 'Vegetariano', (v){
                  setState(() { _active = 3; });
                  _votacaoBloc.avaliacao.tipoProteina = TipoProteinaEnum.vegetariano;
                }),
              ],
            ),
            if(_active != 0) ActionButton('Próximo', (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AvaliacaoObjetiva()));
            })
          ],
        ),
      ),
    );
  }

}

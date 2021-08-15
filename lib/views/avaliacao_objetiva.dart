import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ru/bloc/votacao_bloc.dart';
import 'package:mobile_ru/models/ClassificacaoEnum.dart';
import 'package:mobile_ru/views/agradecimento.dart';
import 'package:mobile_ru/views/avaliacao_subjetiva.dart';
import 'package:mobile_ru/widgets/select_button.dart';
import 'package:mobile_ru/widgets/action_button.dart';

class AvaliacaoObjetiva extends StatefulWidget {

  @override
  _AvaliacaoObjetivaState createState() => _AvaliacaoObjetivaState();
}

class _AvaliacaoObjetivaState extends State<AvaliacaoObjetiva> {
  VotacaoBloc _votacaoBloc = Get.find();
  int _active = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliacao Objetiva'),
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
                  child: Text(
                    'Como você avalia sua satisfação em relação a proteína da sua refeição?',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xff333333)),
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                ),
                SelectButton(_active, 1, '😋 Satisfeito', (){
                  setState(() { _active = 1; });
                  _votacaoBloc.avaliacao.classificacao = Classificacao.BOM;
                }),
                SelectButton(_active, 2, '😐 Indiferente', (){
                  setState(() { _active = 2; });
                  _votacaoBloc.avaliacao.classificacao = Classificacao.REGULAR;
                }),
                SelectButton(_active, 3, '☹ Insatisfeito', (){
                  setState(() { _active = 3; });
                  _votacaoBloc.avaliacao.classificacao = Classificacao.RUIM;
                }),
              ],
            ),
            Column(
              children: [
                if(_active != 0)
                  ActionButton('Finalizar', (){
                    _votacaoBloc.rate().then((res) {
                      if (res.result == true) Navigator.push(context, MaterialPageRoute(builder: (context) => Agradecimento()));
                      else {
                        final snackBar = SnackBar(content: Text(res.message), duration: Duration(seconds: 6));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  }, backgroundColor: Color(0xffBADA55)),

                Container(
                  margin: EdgeInsets.only(top: 15),
                  child:ActionButton('Fazer um comentário', (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AvaliacaoSubjetiva()));
                  })
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}

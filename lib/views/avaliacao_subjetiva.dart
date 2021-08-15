import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ru/bloc/votacao_bloc.dart';
import 'package:mobile_ru/views/agradecimento.dart';
import 'package:mobile_ru/widgets/action_button.dart';

class AvaliacaoSubjetiva extends StatefulWidget {
  const AvaliacaoSubjetiva({Key key}) : super(key: key);

  @override
  _AvaliacaoSubjetivaState createState() => _AvaliacaoSubjetivaState();
}

class _AvaliacaoSubjetivaState extends State<AvaliacaoSubjetiva> {
  VotacaoBloc _votacaoBloc = Get.find();
  bool _validateComentario = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliacao Subjetiva'),
        backgroundColor: Color(0xFFBA2B2B),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  child: Text(
                    'Este espaço é reservado para sugestões de melhorias ou elogios.',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xff333333)),
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                ),
                TextField(
                  maxLength: 100,
                  onChanged: (value){
                      _votacaoBloc.comentario = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Seu comentário',
                    errorText: _validateComentario ? "Faça um comentário" : null
                  ),
                )
              ],
            ),
            Column(
              children: [
                ActionButton('Finalizar', (){
                  _votacaoBloc.rate().then((res) {
                    if (res.result == true) Navigator.push(context, MaterialPageRoute(builder: (context) => Agradecimento()));
                    else {
                      final snackBar = SnackBar(content: Text(res.message), duration: Duration(seconds: 6));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                }, backgroundColor: Color(0xffBADA55)),
              ],
            )
          ],
        ),
      )
    );
  }
}

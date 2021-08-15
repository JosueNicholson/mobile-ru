import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ru/bloc/votacao_bloc.dart';
import 'package:mobile_ru/models/ClassificacaoEnum.dart';
import 'package:mobile_ru/models/TipoProteinaEnum.dart';
import 'package:mobile_ru/views/agradecimento.dart';
import 'package:mobile_ru/views/tipo_proteina.dart';
import 'package:mobile_ru/widgets/select_button.dart';
import 'package:mobile_ru/widgets/action_button.dart';

class AvaliacaoObjetiva extends StatefulWidget {

  @override
  _AvaliacaoObjetivaState createState() => _AvaliacaoObjetivaState();
}

class _AvaliacaoObjetivaState extends State<AvaliacaoObjetiva> {
  VotacaoBloc _votacaoBloc = Get.find();
  int _active = 0;
  TextEditingController _inputComentario = TextEditingController();
  ScrollController _sc = ScrollController();

  @override
  Widget build(BuildContext context) {
    bool _validateComentario = false;
    _inputComentario.text = _votacaoBloc.comentario;
    Classificacao classificacao = _votacaoBloc.avaliacao.classificacao;

    switch(classificacao.nameClassificacao){
      case 'BOM':
        _active = 1;
        break;
      case 'REGULAR':
        _active = 2;
        break;
      case 'RUIM':
        _active = 3;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliação - Sua satisfação'),
        backgroundColor: Color(0xFFBA2B2B),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _sc,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text(
                          'Como você avalia sua satisfação em relação a proteína da sua refeição?',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xff333333)),
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                      ),
                      SelectButton(_active, 1, '😋 Satisfeito: achei a proteína boa', (v){
                        setState(() { _active = 1; });
                        _votacaoBloc.avaliacao.classificacao = Classificacao.BOM;
                      }),
                      SelectButton(_active, 2, '😐 Indiferente: achei a proteína regular', (v){
                        setState(() { _active = 2; });
                        _votacaoBloc.avaliacao.classificacao = Classificacao.REGULAR;
                      }),
                      SelectButton(_active, 3, '☹ Insatisfeito: achei a proteína ruim', (v){
                        setState(() { _active = 3; });
                        _votacaoBloc.avaliacao.classificacao = Classificacao.RUIM;
                      }),
                      Container(
                        child: Text(
                          'Este espaço é reservado para sugestões de melhorias ou elogios (opcional)',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xff333333)),
                        ),
                        margin: EdgeInsets.only(bottom: 20, top: 10),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 56),
                        child: TextField(
                          onTap: () async {
                            await Future.delayed(Duration(milliseconds: 500));
                            _sc.animateTo(
                              _sc.position.maxScrollExtent,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn,
                            );
                          },

                          controller: _inputComentario,
                          maxLines: 3,
                          maxLength: 100,
                          onChanged: (value){
                            _votacaoBloc.comentario = value;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: 'Seu comentário',
                              errorText: _validateComentario ? "Faça um comentário" : null
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if(_active != 0)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: ActionButton('Finalizar', (){
                  showDialog(context: context, builder: (BuildContext context) {
                    return new AlertDialog(
                      title: new Text("Resumo da avaliação", textAlign: TextAlign.center),
                      content: new RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 15, color: Colors.black),
                          children: [
                            TextSpan(text: "Proteína: ${_votacaoBloc.avaliacao.tipoProteina.nameProteina}\n" ),
                            TextSpan(text: "Classificação: ${_votacaoBloc.avaliacao.classificacao.nameClassificacao.toLowerCase()}\n"),
                            TextSpan(text: "Comentario: ${_inputComentario.text}"),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('Cancelar', style: TextStyle(color: Colors.red),),
                        ),
                        TextButton(
                          onPressed: () {
                            _votacaoBloc.rate().then((res) {
                              if (res.result == true) Navigator.push(context, MaterialPageRoute(builder: (context) => Agradecimento()));
                              else {
                                final snackBar = SnackBar(content: Text(res.message), duration: Duration(seconds: 6));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            });
                          },
                          child: const Text('Confirmar voto'),
                        ),
                      ],
                    );
                  });

                }, backgroundColor: Color(0xffBADA55)),
              ),
            ),
        ]
      )
    );
  }

}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_ru/widgets/action_button.dart';

class Agradecimento extends StatelessWidget {
  const Agradecimento();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Color(0xffBADA55),
          body: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text('Obrigado!', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w600)),
                    ),
                    Text('Sua avaliação é importante para nós!', style: TextStyle(color: Colors.white, fontSize: 16))
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
                    alignment: Alignment.bottomCenter,
                    child: ActionButton(
                        'Sair',
                            (){
                          exit(0);
                        },
                        width: MediaQuery.of(context).size.width * 0.3,
                        backgroundColor: Colors.white,
                        textColor: Colors.black
                    )
                )
              ],
            ),
          )
      ),
    );
  }
}

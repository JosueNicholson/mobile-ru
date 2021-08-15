import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {
  final int active;
  final int activeNumber;
  final String buttonText;
  final Function action;
  final double width;


  const SelectButton(this.active, this.activeNumber, this.buttonText, this.action,
  {this.width = double.infinity});

  ButtonStyle buttonStyle(int activeNumber){
    return TextButton.styleFrom(
        backgroundColor: this.active == activeNumber? Color(0xffE8F6FF) : Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20)
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: width,
        child: TextButton(
          style: buttonStyle(this.activeNumber),
          onPressed: this.action,
          child: Text(this.buttonText, style: TextStyle(color: Color(0xFF666666), fontSize: 22, fontWeight: FontWeight.w300)),
        ),
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: -2,
                  offset: Offset(0,2)
              )
            ]
        ),
      );
  }
}

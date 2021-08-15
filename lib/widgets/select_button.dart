import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {
  final int active;
  final int activeNumber;
  final String buttonText;
  final Function action;
  final double width;


  const SelectButton(this.active, this.activeNumber, this.buttonText, this.action,
  {this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: width,
        child: Container(
          child: Container(
            child: Row(
              children: [
                Radio(
                  value: this.activeNumber,
                  groupValue: this.active,
                  onChanged: this.action,
                ),
                Text(this.buttonText, style: TextStyle(fontSize: 18),)
              ],
            ),

          ),
        ),
      );
  }
}

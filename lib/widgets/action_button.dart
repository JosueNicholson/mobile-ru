import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String buttonText;
  final Function action;
  final double width;
  final Color backgroundColor;
  final Color textColor;

  const ActionButton(this.buttonText, this.action, {
    this.width = double.infinity,
    this.backgroundColor = const Color(0xffBA2B2B),
    this.textColor = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: EdgeInsets.symmetric(vertical: 15),

          ),
          onPressed: action,
          child: Text(
            buttonText,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w400,
                fontSize: 18
            ),
          ),
        ),
      ),
    );
  }
}

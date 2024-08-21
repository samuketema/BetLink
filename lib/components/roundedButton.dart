import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({super.key, this.color,required this.onPressed,this.title});
  Color? color;
  VoidCallback? onPressed;
  String? title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(title as String, style: TextStyle(
            color: Colors.white
          ),
          )
        ),
      ),
    );
  }
}

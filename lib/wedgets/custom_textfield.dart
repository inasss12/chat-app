import 'package:flutter/material.dart';

class custom_formtextfield extends StatelessWidget{
  custom_formtextfield({this.onchanged,this.hint_text,this.obsecureText=false});
  String? hint_text;
  bool obsecureText;
  Function(String)? onchanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){if(data!.isEmpty)return "field cant be empty";},
      onChanged: onchanged,
      obscureText: obsecureText,
      decoration: InputDecoration(
          hintText: hint_text,
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }
}
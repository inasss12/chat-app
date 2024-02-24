import 'package:flutter/material.dart';
class custom_button extends StatelessWidget{
  custom_button({this.ontap,required this.text});
  String text;
  VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 40,
        child: Center(child: Text(text,style: TextStyle(color: Color(0xff2d3b63),
            fontSize: 18),)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(color: Colors.white)),),
    );
  }
}
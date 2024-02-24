import 'package:chat_app_14_1_24/models/message.dart';
import 'package:chat_app_14_1_24/wedgets/constants.dart';
import 'package:flutter/material.dart';
class chatBubble extends StatelessWidget {
  const chatBubble({required this.message,
    Key? key,
  }) : super(key: key);
final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        padding: EdgeInsets.only(left: 10,top: 16,bottom: 16,right: 10),
       // height: 70,
       // width: 150,
      //  alignment: Alignment.centerLeft,
        child: Text(message.message,style: TextStyle(color: Colors.white),),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),),
    );
  }
}

class chatBubbleforfriend extends StatelessWidget {
  const chatBubbleforfriend({required this.message,
    Key? key,
  }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        padding: EdgeInsets.only(left: 10,top: 16,bottom: 16,right: 10),
        // height: 70,
        // width: 150,
        //  alignment: Alignment.centerLeft,
        child: Text(message.message,style: TextStyle(color: Colors.white),),
        decoration: BoxDecoration(
            color: Color(0xff006D84),
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30))),),
    );
  }
}
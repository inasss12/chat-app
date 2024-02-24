import 'package:chat_app_14_1_24/wedgets/constants.dart';

class Message{
  final String message;
  final String id;

  Message(this.message,this.id);
  factory Message.fromJson(jsonData){
    return Message(jsonData[kmessage],jsonData["id"]);
  }
}
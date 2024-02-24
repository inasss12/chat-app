import 'package:chat_app_14_1_24/pages/chatPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_14_1_24/pages/login_page.dart';
import 'package:chat_app_14_1_24/pages/registerPage.dart';
//import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( );
  runApp(scholar_chat_app());
}
class scholar_chat_app extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return scholar_chat_app_state();
  }
}

class scholar_chat_app_state extends State<scholar_chat_app>{
@override
  void initState() {
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      print('============== User is currently signed out!');
    } else {
      print('===========  User is signed in!');
    }
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null ? login_page():chatPage(),
      routes: {
        login_page.id:(context)=> login_page(),
        registerPage.id:(context)=> registerPage(),
        chatPageState.id:(context)=>chatPage(),
      },);
  }
}
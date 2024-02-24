import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_14_1_24/wedgets/constants.dart';
import 'package:chat_app_14_1_24/wedgets/custom_button.dart';
import 'package:chat_app_14_1_24/wedgets/custom_textfield.dart';
import 'package:chat_app_14_1_24/pages/registerPage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:chat_app_14_1_24/helper/show_snack_bar.dart';
import 'package:chat_app_14_1_24/pages/chatPage.dart';

class login_page extends StatefulWidget{
 static String id="login_page";
  @override
  State<StatefulWidget> createState() {
    return login_pageState();
  }
}
class login_pageState extends State<login_page> {
  String? email, password;
  bool isloading=false;
  GlobalKey<FormState> formkey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                SizedBox(height: 20,),
                Container(height: 100,
                    child: Image.asset(klogo)),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Scholar Chat',
                        style: TextStyle(color: Colors.white, fontSize: 23,fontFamily:'pacifico') ),
                  ],
                ),
                SizedBox(height: 20,),

                Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                custom_formtextfield(hint_text: 'Email',onchanged: (data){email=data;},),
                SizedBox(height: 10),
                custom_formtextfield(hint_text: 'Password',onchanged: (data){password=data;},obsecureText: true,),
                SizedBox(height: 20,),
              custom_button(
                ontap: ()async{

                  if(formkey.currentState!.validate()){
                    isloading=true;
                    setState(() {

                    });
                    try{
                      await loginUser();
                     // showSnakbar(context, 'sucess');
                      Navigator.pushNamed(context, chatPageState.id,arguments: email);
                    }
                    on FirebaseAuthException catch(e){
                      if (e.code == 'user-not-found') {
                        showSnakbar(context,'user not found');
                        print('=========wwwwwwwwwww=========');
                        print('===== $e =====');
                      } else if  (e.code == 'wrong-password') {
                        print('=========wwwwwwwwwww=========');
                        showSnakbar(context," wrong password");
                      }}
                     catch(e){
                     showSnakbar(context, 'there was an error ');

                    }
                    isloading=false;
                    setState(() {

                    });}
                },
                text: 'login',
              ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('don\'t have an account ? ',style: TextStyle(color: Colors.white),),
                    GestureDetector(
                        onTap: ()
                        {Navigator.pushNamed(context, registerPage.id);},
                        child: Text('Sign Up',style: TextStyle(color: Color(0xffccefee)),))
                  ],),
              ],
            ),
          ),
        ),

      ),
    );
  }

  Future<void> loginUser() async {
     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!
    );
     print('==================== sssss ===========');

  }
}

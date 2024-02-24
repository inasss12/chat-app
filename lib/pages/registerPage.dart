import 'package:chat_app_14_1_24/pages/chatPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_14_1_24/wedgets/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/show_snack_bar.dart';
import '../wedgets/custom_button.dart';
import '../wedgets/custom_textfield.dart';
class registerPage extends StatefulWidget{
  static String id='register_page';
  @override
  State<registerPage> createState() {
    return registerPageState();
  }
}
class registerPageState extends State<registerPage> {
  String? email;
  String? password;
  bool isloading=false;
  GlobalKey<FormState> formkey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: //isloading ==true ? CircularProgressIndicator():
        Padding(
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
                    Text('Scholar Chat',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontFamily: 'pacifico')),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text(
                      'REGISTER',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                custom_formtextfield(
                  onchanged: (data){email=data;},
                  hint_text: 'Email',
                ),
                SizedBox(height: 10),
                custom_formtextfield(
                  onchanged: (data){password=data;},
                  hint_text: 'Password',obsecureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                custom_button(
                  ontap: ()async{

                    if(formkey.currentState!.validate()){
                      isloading=true;
                      setState(() {

                      });
                      try{
                      await registerUser();
                    //  showSnakbar(context, 'sucess');
                      Navigator.pushNamed(context, chatPageState.id,arguments: email);

                      }
                    on FirebaseAuthException catch(e){
                      if (e.code == 'weak-password') {
                        showSnakbar(context,'weak password');
                        print('=========wwwwwwwwwww=========');
                        print('===== $e =====');
                      } else if (e.code == 'email-already-in-use') {
                        showSnakbar(context," email already exist");
                      }}
                    catch(e){showSnakbar(context, 'there was an error');}
                    isloading=false;
                    setState(() {

                    });}
               },
                  text: 'Register',
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Allready have an account ? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Color(0xffccefee)),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Future<void> registerUser() async {

    UserCredential user=
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
    print('========== ${user.user!.email} =====');
  }
}

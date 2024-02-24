import 'package:chat_app_14_1_24/models/message.dart';
import 'package:chat_app_14_1_24/pages/login_page.dart';
import 'package:chat_app_14_1_24/wedgets/chatBubble.dart';
import 'package:chat_app_14_1_24/wedgets/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chatPage extends StatefulWidget {
  @override
  State<chatPage> createState() {
    return chatPageState();
  }
}

class chatPageState extends State<chatPage> {
  static String id = "chatPage";
  String dataMessage = "";
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kmessagecollection);
  TextEditingController controller = TextEditingController();
  ScrollController _controller = ScrollController();
List alphaptic=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s',
't','u','v','w','x','y','z'];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kcreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          // print("======snapshot.data ==== ${snapshot.data!['message']} =======");
          if (snapshot.hasData) {
            // print("=== snapshot=== ${snapshot.data!.docs[3]['message']}");
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 50, height: 50, child: Image.asset(klogo)),
                    Text('Chat')
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            login_page.id, (route) => false);
                      },
                      icon: Icon(Icons.exit_to_app))
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messagesList.length,
                        itemBuilder: (context, i) {
                          return (messagesList[i].id == email)
                              ? chatBubble(
                                  message: messagesList[i],
                                )
                              : chatBubbleforfriend(
                                  message: messagesList[i],
                                );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      /*  onSubmitted: (data) {
                        dataMessage=data;
                        print('5555555555555555555555');
                        print('===== data $data ===== datamessage  $dataMessage =====');

                      },*/
                      decoration: InputDecoration(
                          hintText: 'Send message',
                          suffixIcon: InkWell(
                            onTap: () {
                              if (controller.text != "") {
                                List encodedMessag=[];
                                var messageToList = controller.text.split('');
                                print('====== messageToList : $messageToList');
                               print('====== alphaptic : $alphaptic');int counter=2;

                                for(int i=0;i<messageToList.length;i++){
                                  for(int x=0;x<alphaptic.length;x++){
                                    if(messageToList[i]==" "){
                                      encodedMessag.add("%");
                                      x=alphaptic.length;
                                    }
                                    else if( messageToList[i]==alphaptic[x]){
                                        x= x+counter;
                                       // print('=== x  $x');
                                        if(x>=26){x=x-26;}
                                      encodedMessag.add(alphaptic[x]);
                                      x=alphaptic.length;
                                    }
                                  }
                                }

                               print('====== encoded message : $encodedMessag');

                                var decodeMessage=encodedMessag.join();
                                print('====== decode message111 : $decodeMessage');

                                messages.add({
                                  // encoded or normal message
                                  kmessage:controller.text,// decodeMessage,
                                  kcreatedAt: DateTime.now(),
                                  "id": email
                                });
                                controller.clear();
                                //jump to specific message (replay)
                                //   _controller.jumpTo(_controller.position.maxScrollExtent);
                                _controller.animateTo(
                                  0,
                                  //_controller.position.maxScrollExtent,
                                  duration: Duration(seconds: 5),
                                  curve: Curves.easeIn,
                                );
                                setState(() {});
                              }
                            },
                            child: Icon(
                              Icons.send,
                              color: kPrimaryColor,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 4)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: kPrimaryColor, width: 2))),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Scaffold(body: Center(child:CircularProgressIndicator()));
          }
        });
  }
}

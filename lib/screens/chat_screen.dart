import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/widgets/chat/mesages.dart';
import 'package:learn_flutter/widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (msg) {
      print(msg);
      return;
    }, onLaunch: (msg) {
      print(msg);
      return;
    }, onResume: (msg) {
      print(msg);
      return;
    });
    // we can use
    // fbm.getToken() to send notification by admin
    // or device can subsribe to a specific topic to receive notification.
    // please check functions/lib/index for more detail
    fbm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter chat'),
          actions: [
            DropdownButton(
              underline: Container(),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Log out')
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
              ],
              onChanged: (idenfitier) {
                if (idenfitier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Messages(),
              ),
              NewMessage()
            ],
          ),
        ));
  }
}

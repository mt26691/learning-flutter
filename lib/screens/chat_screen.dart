import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter chat'),
        actions: [
          DropdownButton(
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
      body: StreamBuilder(
        builder: (context, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.documents;
          return ListView.builder(
            itemBuilder: (context, index) {
              final currentDocument = documents[index].data();
              return Container(
                padding: EdgeInsets.all(8),
                child: Text(currentDocument['text']),
              );
            },
            itemCount: streamSnapshot.data.documents.length,
          );
        },
        stream: FirebaseFirestore.instance
            .collection('chats/BWiqVe1VyyOhO7RTKZdL/messages')
            .snapshots(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/BWiqVe1VyyOhO7RTKZdL/messages')
              .add({'text': 'Any text'});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

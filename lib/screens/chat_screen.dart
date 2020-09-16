import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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

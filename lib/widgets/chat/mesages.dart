import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final documents = chatSnapshot.data.documents;
        return ListView.builder(
          reverse: true,
          itemBuilder: (context, index) {
            final currentDocument = documents[index].data();
            return Text(currentDocument['text']);
          },
          itemCount: chatSnapshot.data.documents.length,
        );
      },
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
    );
  }
}

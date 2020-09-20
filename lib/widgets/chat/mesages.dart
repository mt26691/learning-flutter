import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/widgets/chat/message_bubble.dart';

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
            return MessageBubble(
              message: currentDocument['text'],
              isMe: currentDocument['userId'] ==
                  FirebaseAuth.instance.currentUser.uid,
              key: ValueKey(currentDocument['id']),
              userId: FirebaseAuth.instance.currentUser.uid,
              username: currentDocument['username'],
              userImage: currentDocument['userImage'],
            );
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

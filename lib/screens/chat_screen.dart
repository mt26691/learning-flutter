import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(8),
            child: Text('this works'),
          );
        },
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // FirebaseFirestore.instance
          //     .collection('chats/BWiqVe1VyyOhO7RTKZdL/messages')
          //     .snapshots()
          //     .listen((data) {
          //   print(data);
          // });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

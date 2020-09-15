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
    );
  }
}

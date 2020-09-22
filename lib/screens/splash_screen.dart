import 'package:flutter/material.dart';

class SlashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

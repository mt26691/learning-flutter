import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_flutter/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _submitAuthForm(String email, String password, String username,
      bool isLogin, BuildContext currentContext) async {
    UserCredential _authResult;

    try {
      if (isLogin) {
        _authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        _authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
    } on FirebaseAuthException catch (err) {
      var message = 'An error occurd, please check your credentail';

      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(currentContext).errorColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm),
    );
  }
}

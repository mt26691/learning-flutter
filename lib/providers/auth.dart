import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_flutter/model/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuthenticated {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(String email, String password, String url) async {
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseBodyData = json.decode(response.body);
      if (responseBodyData['error'] != null) {
        throw HttpException(responseBodyData['error']['message']);
      }
      _token = responseBodyData['idToken'];
      _userId = responseBodyData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseBodyData['expiresIn'])));
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password,
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBJB6pyV9n10-pdrPwwG3rVJx-P0Lr8VK8');
  }

  Future<void> signin(String email, String password) async {
    return _authenticate(email, password,
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBJB6pyV9n10-pdrPwwG3rVJx-P0Lr8VK8');
  }
}

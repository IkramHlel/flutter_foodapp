import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import './validators.dart';
import '../models/user.dart';
import '../models/auth.dart';

class AuthBloc with Validators {
  User _authenticatedUser;
  AuthMode mode = AuthMode.Login;

  final _email = BehaviorSubject<String>();
  Stream<String> get emailStream => _email.stream.transform(emailValidator);
  StreamSink<String> get emailSink => _email.sink;

  final _password = BehaviorSubject<String>();
  Stream<String> get passwordStream =>
      _password.stream.transform(passwordValidator);
  StreamSink<String> get passwordSink => _password.sink;

  Stream<bool> get submitValid =>
      Observable.combineLatest2(_email, _password, (e, s) => true);

  Future<Map<String, dynamic>> authenticate(
      String email, String password, mode) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDJTs1hXTifQ4Q2BxA-47hfnZguZETMq4s',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDJTs1hXTifQ4Q2BxA-47hfnZguZETMq4s',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong';
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded!';
      _authenticatedUser = User(id: responseData['localId'], email: email);
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This email was not found';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'the password is invalid';
    } else if (responseData['error']['message'] == 'EMAIL-EXISTS') {
      message = 'This email already exists';
    }
    return {'success': !hasError, 'message': message};
  }

  void logout() {
    _authenticatedUser = null;
  }
  

  dispose() {
    _email.close();
    _password.close();
  }
}

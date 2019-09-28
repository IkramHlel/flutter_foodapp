
import 'package:flutter/material.dart';

import '../blocs/auth_bloc.dart';

import './recipes.dart';
import '../models/auth.dart';


class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
  };
  final bloc = AuthBloc();
  AuthMode _authMode = AuthMode.Login;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
      image: AssetImage('assets/food_backgrnd.jpg'),
    );
  }

  Widget _buildEmailTextField() {
    return StreamBuilder<String>(
      stream: bloc.emailStream,
      builder: (context, snapshot) {
        return TextField(
            decoration: InputDecoration(
              labelText: 'E-MAIL',
              labelStyle: TextStyle(color: Colors.white),
              icon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              errorText: snapshot.error,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            controller: _emailTextController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (s) {
              bloc.emailSink.add(s);
              _formData['email'] = _emailTextController.text;
            });
      },
    );
  }

  Widget _buildPasswordTextField() {
    return StreamBuilder<String>(
      stream: bloc.passwordStream,
      builder: (context, snapshot) {
        return TextField(
          decoration: InputDecoration(
            labelText: 'PASSWORD',
            labelStyle: TextStyle(color: Colors.white),
            icon: Icon(
              Icons.lock_outline,
              color: Colors.white,
            ),
            errorText: snapshot.error,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          obscureText: true,
          controller: _passwordTextController,
          onChanged: (s) {
            bloc.passwordSink.add(s);
            _formData['password'] = _passwordTextController.text;
          },
        );
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'CONFIRM PASSWORD',
        labelStyle: TextStyle(color: Colors.white),
        icon: Icon(
          Icons.lock_outline,
          color: Colors.white,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      obscureText: true,
      validator: (String value) {
        if (_passwordTextController.text != value) {
          return 'Passwords do not match.';
        }
      },
    );
  }

  Widget _submitButton(BuildContext context) {
    return StreamBuilder<bool>(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          return Container(
            width: 200.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0)),
            child: FlatButton(
              textColor: Colors.white,
              child: Text(
                _authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP',
                style: TextStyle(fontSize: 18.0),
              ),
              onPressed: snapshot.hasData
                  ? () {
                      _submitForm();
                    }
                  : null,
            ),
          );
        });
  }


  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    Map<String, dynamic> successInformations;
    successInformations = await bloc.authenticate(
        _formData['email'], _formData['password'], _authMode);
    if (successInformations['success']) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => RecipesPage()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('An error occured!'),
              content: Text(successInformations['message']),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.70;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(image: _buildBackgroundImage()),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: targetWidth,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _buildEmailTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildPasswordTextField(),
                      SizedBox(height: 10.0),
                      _authMode == AuthMode.Signup
                          ? _buildPasswordConfirmTextField()
                          : Container(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _submitButton(context),
                      FlatButton(
                        child: Text(
                          '${_authMode == AuthMode.Login ? 'New here? Create an accout >' : 'Login to my account >'}',
                          style: TextStyle(
                            fontSize: 18.0, 
                          ),
                        ),
                        textColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            _authMode = _authMode == AuthMode.Login
                                ? AuthMode.Signup
                                : AuthMode.Login;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

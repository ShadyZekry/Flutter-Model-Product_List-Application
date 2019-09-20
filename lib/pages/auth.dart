import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main_model.dart';

class AuthPage extends StatefulWidget {
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String email;
  String passWord;
  bool acceptTerms = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "E-mail",
          filled: true,
          fillColor: Colors.white.withOpacity(0.7)),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return "This is not a valid E-mail";
        }
      },
      onSaved: (String value) => email = value,
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Password",
          filled: true,
          fillColor: Colors.white.withOpacity(0.7)),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 3) {
          return "Tis Password is not valid";
        }
      },
      onSaved: (String value) => passWord = value,
    );
  }

  Widget _buildSwitchListTile() {
    return SwitchListTile(
      title: Text("Accept Terms"),
      value: acceptTerms,
      onChanged: (bool value) => setState(() => acceptTerms = value),
    );
  }

  BoxDecoration _buildBackground() {
    return BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop)),
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return RaisedButton(
        child: Text("Login"),
        onPressed: () {
          if (!_formKey.currentState.validate() || !acceptTerms) {
            return;
          }
          _formKey.currentState.save();
          model.login(email, passWord);
          Navigator.pushReplacementNamed(context, "/home");
        },
      );
    });
  }

  Widget _buildEnterAsGuest() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return RaisedButton(
        child: Text("Login as a Guest"),
        onPressed: () {
          model.loginAsGuest();
          Navigator.pushReplacementNamed(context, "/home");
        },
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Authintication Page"),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        decoration: _buildBackground(),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(height: 15.0),
                    _buildPasswordTextField(),
                    _buildSwitchListTile(),
                    SizedBox(height: 10.0),
                    _buildSubmitButton(),
                    _buildEnterAsGuest(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

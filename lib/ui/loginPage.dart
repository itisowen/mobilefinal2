import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../model/shareprefer.dart';
import '../model/DB.dart';
import './registerPage.dart';
import './homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreen();
  }
}

class LoginScreen extends State<LoginPage> {
  TodoProvider userdb = TodoProvider();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userid = TextEditingController();
  final TextEditingController password = TextEditingController();

  void initState() {
    super.initState();
    this.userdb.open();
    SharedPreferencesUtil.saveLastLogin(null);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                Image.asset(
                  "images/key.png",
                  height: 180,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "User ID",
                    icon: Icon(Icons.account_circle),
                  ),
                  controller: userid,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please fill out this form";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Password", icon: Icon(Icons.lock)),
                  controller: password,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please fill out this form";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text("LOGIN"),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await userdb.open();
                      userdb.getAccountByUserId(userid.text).then((account) {
                        if (account == null ||
                            password.text != account.password) {
                          Toast.show("Invalid user or password", context,
                              duration: Toast.LENGTH_SHORT,
                              backgroundColor: ,
                              gravity: Toast.BOTTOM);
                          print("LOGIN FALL");
                        } else {
                          print("LOGIN PASS");
                          SharedPreferencesUtil.saveLastLogin(userid.text);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(account)),
                          );
                        }
                      });
                    }
                  },
                ),
                Container(
                  child: FlatButton(
                    child: Text("Register New Account"),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                  ),
                  alignment: Alignment.topRight,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

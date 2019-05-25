import 'package:flutter/material.dart';
import '../ui/homePage.dart';
import '../model/shareprefer.dart';
import '../model/DB.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileScreen();
  }
}

class ProfileScreen extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TodoProvider userdb = TodoProvider();
  static String quote;
  static Account _account;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController quotefield = TextEditingController();

  bool isUserIn = false;

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  int countSpace(String s) {
    int result = 0;
    for (int i = 0; i < s.length; i++) {
      if (s[i] == ' ') {
        result += 1;
      }
    }
    return result;
  }

  void initState() {
    super.initState();
    this.userdb.open();
    print("db open");
    SharedPreferencesUtil.loadLastLogin().then((value) async {
      await userdb.open();
      await userdb.getAccountByUserId(value).then((values) {
        setState(() {
          _account = values;
          username.text = _account.userid;
          password.text = _account.password;
          name.text = _account.name;
          age.text = _account.age.toString();
        });
      });
    });
    SharedPreferencesUtil.loadQuote().then((value) {
      setState(() {
        ProfileScreen.quote = value;
        quotefield.text = quote;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: "UserId",
                      hintText: "User Id must be between 6 to 12",
                      icon: Icon(Icons.account_box),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill out this form";
                      } else if (value.length < 6 || value.length > 12) {
                        return "Please fill UserId Correctly";
                      }
                    }),
                TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "ex. 'Tony Stark'",
                      icon: Icon(Icons.account_circle),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill out this form";
                      } else if (countSpace(value) != 1) {
                        return "Please fill Name Correctly";
                      }
                    }),
                TextFormField(
                    controller: age,
                    decoration: InputDecoration(
                      labelText: "Age",
                      hintText: "Please fill Age Between 10 to 80",
                      icon: Icon(Icons.event_note),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill out this form";
                      } else if (!isNumeric(value) ||
                          int.parse(value) < 10 ||
                          int.parse(value) > 80) {
                        return "Please fill Age correctly";
                      }
                    }),
                TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Password must be longer than 6",
                      icon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill out this form";
                      } else if (value.length <= 6) {
                        return "Please fill Password Correctly";
                      }
                    }),
                TextFormField(
                    controller: quotefield,
                    decoration: InputDecoration(
                      labelText: "Quote",
                      hintText: "This feel today is ...",
                      icon: Icon(Icons.settings_system_daydream),
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: 5),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        child: Text("SAVE"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await userdb.open();
                            await userdb.update(Account(
                                id: _account.id,
                                userid: username.text,
                                name: name.text,
                                age: int.parse(age.text),
                                password: password.text));

                            _account.userid = username.text;
                            _account.name = name.text;
                            _account.age = int.parse(age.text);
                            _account.password = password.text;

                            await SharedPreferencesUtil.saveQuote(
                                quotefield.text);
                            Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => HomePage(_account)),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import '../model/DB.dart';
import '../model/shareprefer.dart';
import './profilePage.dart';



class HomePage extends StatefulWidget {
  final Account _account;
  HomePage(this._account);

  @override
  State<StatefulWidget> createState() {
    return HomeScreen();
  }
}

class HomeScreen extends State<HomePage> {
  String quote;
  final color = const Color(0xff63F534);

  void initState() {
    super.initState();
    SharedPreferencesUtil.loadQuote().then((value) {
      setState(() {
        this.quote = value;
      });
    });
    print("test");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: color,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        children: <Widget>[
          ListTile(
            title: Text("Hello ${widget._account.name}"),
            subtitle: Text("This is my quote ${this.quote} "),
          ),
          RaisedButton(
            child: Text("PROFILE SETUP"),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          RaisedButton(
            child: Text("FRIEND"),
            onPressed: () {
              Navigator.pushNamed(context, "/friend");
            },
          ),
          RaisedButton(
            child: Text("LOGOUT"),
            onPressed: () {
              SharedPreferencesUtil.saveLastLogin(null);
              SharedPreferencesUtil.saveQuote(null);
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
        ],
      ),
    );
  }
}

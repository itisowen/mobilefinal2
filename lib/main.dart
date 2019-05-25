import 'package:flutter/material.dart';
import './ui/registerPage.dart';
import './ui/loginPage.dart';
import './ui/profilePage.dart';
import './ui/friendPage.dart';
import './ui/myfriendPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mobile final',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        // "/register": (context) => RegisterPage(),
        // "/profile": (context) => ProfilePage(),
        // "/friend": (context) => FriendPage(),
      },
    );
  }
}
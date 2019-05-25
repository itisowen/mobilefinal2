import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

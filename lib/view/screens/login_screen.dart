import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../constants/Colors.dart';
import '../widgets/access_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    var todos = Hive.box('login');
    if (todos.length > 0) {
      for (int i = 0; i < todos.length; i++) {
        todos.deleteAt(i);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: MediaQuery.of(context).padding.top + 50),
            width: double.infinity,
            child: const AccessForm(),
          ),
        ),
      ),
    );
  }
}

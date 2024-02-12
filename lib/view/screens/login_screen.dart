import 'package:flutter/material.dart';

import '../constants/Colors.dart';
import '../widgets/access_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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

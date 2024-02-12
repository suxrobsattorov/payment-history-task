import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_history_task/model/login_request.dart';
import 'package:payment_history_task/view/screens/home_screen.dart';
import 'package:payment_history_task/view/widgets/input_label.dart';

import '../../provider/login_provider.dart';
import '../constants/Colors.dart';

class AccessForm extends ConsumerStatefulWidget {
  const AccessForm({super.key});

  @override
  ConsumerState createState() => _AccessFormState();
}

class _AccessFormState extends ConsumerState<AccessForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _passwordVisible = false;

  bool _loading = false;

  LoginRequest request = LoginRequest(username: '', password: '');

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Xatolik'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                _loading = false;
                Navigator.of(ctx).pop();
              },
              child: const Text('Ok!'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    var errorMessage =
        'Kechirasiz xatolik sodir bo\'ldi. Qaytadan o\'rinib ko\'ring.';
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _loading = true;
      });
      try {
        var response = await ref.read(loginProvider.notifier).login(request);
        if (response != null) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
        } else {
          _showErrorDialog('Login yoki Parol xato!');
        }
      } catch (e) {
        _showErrorDialog(errorMessage);
      }
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.mainColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
            ],
          ),
          borderRadius: BorderRadius.circular(45),
        ),
        child: Container(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
            bottom: 25,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            children: [
              Text(
                'Kirish',
                style: GoogleFonts.mulish(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputLabel(text: 'Foydalanuvchi nomi'),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Foydalanuvchi nomini kiriting',
                      hintStyle: GoogleFonts.mulish(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (login) {
                      if (login == null || login.isEmpty) {
                        return 'Iltimos, Foydalanuvchi nomini kiriting';
                      }
                      return null;
                    },
                    onSaved: (login) {
                      request.username = login!;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputLabel(text: 'Parol'),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: !_passwordVisible,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Parolni kiriting',
                      hintStyle: GoogleFonts.mulish(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black45,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Iltimos, parolni kiriting';
                      }
                      return null;
                    },
                    onSaved: (password) {
                      request.password = password!;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 35),
              _loading ? const CircularProgressIndicator() : login(),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton login() {
    return ElevatedButton(
      onPressed: () {
        _submit();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainColor,
        padding: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        'Kirish',
        style: GoogleFonts.mulish(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:payment_history_task/hive/login_adapter.dart';
import 'package:payment_history_task/provider/login_provider.dart';
import 'package:payment_history_task/view/constants/Colors.dart';
import 'package:payment_history_task/view/screens/home_screen.dart';
import 'package:payment_history_task/view/screens/login_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(LoginAdapter());
  await Hive.openBox('login');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget screens(var watch) {
    if (watch) {
      return const HomeScreen();
    }
    return const LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(builder: (context, ref, child) {
        final watch = ref.watch(loginProvider.notifier);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Payment History',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
            useMaterial3: true,
          ),
          home: watch.isAuth
              ? const HomeScreen()
              : FutureBuilder(
                  future: watch.autoLogin(),
                  builder: (c, autoLoginData) {
                    if (autoLoginData.connectionState ==
                        ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: AppColors.mainColor,
                          ),
                        ),
                      );
                    } else {
                      return screens(watch.isAuth);
                    }
                  },
                ),
          routes: {
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
          },
        );
      }),
    );
  }
}

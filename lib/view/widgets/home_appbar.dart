import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../provider/login_provider.dart';
import '../constants/Colors.dart';
import '../constants/images.dart';

class HomeAppbar extends ConsumerWidget {
  const HomeAppbar({super.key});

  void logOut(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Chiqish'),
          content: const Text('Profildan chiqmoqchimisiz!'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Yo\'q'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/login');
                    ref.read(loginProvider.notifier).logout();
                  },
                  child: const Text('Ha'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            color: AppColors.tableBorderColor,
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'To\'lovlar tarixi',
            style: GoogleFonts.mulish(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/search');
                },
                child: Image.asset(
                  Images.search,
                  fit: BoxFit.cover,
                  height: 20,
                  width: 20,
                  color: AppColors.mainColor,
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  logOut(context, ref);
                },
                child: Image.asset(
                  Images.logout,
                  fit: BoxFit.cover,
                  height: 20,
                  width: 20,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

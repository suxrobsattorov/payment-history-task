import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_history_task/model/login_response.dart';
import 'package:payment_history_task/provider/login_provider.dart';
import 'package:payment_history_task/provider/payment_history_provider.dart';
import 'package:payment_history_task/view/constants/Colors.dart';
import 'package:payment_history_task/view/constants/images.dart';
import 'package:payment_history_task/view/screens/login_screen.dart';
import 'package:payment_history_task/view/widgets/loading.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool onTabSearch = false;
  bool first = true;

  @override
  void didChangeDependencies() {
    if (onTabSearch == false && first) {
      LoginResponse response = ref.watch(loginProvider.notifier).response!;
      ref.read(paymentHistoryProvider.notifier).getPaymentHistory(response);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(paymentHistoryProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              onTabSearch ? searchAppBar() : titleAppBar(),
              const SizedBox(height: 8),
              onTabSearch
                  ? Loading(
                      isLoading: watch.isLoading,
                      payTypes: watch.payTypes,
                      data: watch.searchData,
                    )
                  : Loading(
                      isLoading: watch.isLoading,
                      payTypes: watch.payTypes,
                      data: watch.data,
                    ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Container searchAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
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
          InkWell(
            onTap: () {
              setState(() {
                onTabSearch = false;
                first = false;
                if (!first) {
                  LoginResponse response =
                      ref.watch(loginProvider.notifier).response!;
                  ref
                      .read(paymentHistoryProvider.notifier)
                      .getPaymentHistory(response);
                }
              });
            },
            child: Image.asset(
              Images.back,
              fit: BoxFit.cover,
              height: 15,
              width: 15,
              color: AppColors.mainColor,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 70,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Qidiruv',
                hintStyle: GoogleFonts.mulish(
                  fontSize: 14,
                  color: Colors.grey.shade400,
                ),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                ref.read(paymentHistoryProvider.notifier).search(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Container titleAppBar() {
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
                  setState(() {
                    onTabSearch = true;
                  });
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
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

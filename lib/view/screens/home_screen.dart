// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_history_task/provider/login_provider.dart';
import 'package:payment_history_task/provider/payment_history_provider.dart';
import 'package:payment_history_task/view/widgets/home_loading.dart';

import '../constants/Colors.dart';
import '../constants/images.dart';

final loaderProvider = StateProvider<bool>((ref) => false);
final loadMoreProvider = StateProvider<bool>((ref) => false);
final isSearchProvider = StateProvider<bool>((ref) => false);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _scrollController = ScrollController();
  String? token;
  bool first = true;

  @override
  void didChangeDependencies() {
    if (mounted) {
      loadFirst();
    }
    super.didChangeDependencies();
  }

  Future<void> loadFirst() async {
    token = ref.watch(loginProvider.notifier).token;
    if (first && token != null) {
      await ref.read(paymentHistoryProvider.notifier).getPaymentHistory(token!);
      first = false;
      _scrollController.addListener(_scrollListener);
    }
  }

  @override
  void dispose() {
    // Dispose qilishda scroll listener ni olib tashlash
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // Scroll o'zgarayotganda chaqiriladigan funksiya
  void _scrollListener() async {
    if (!first) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {

        ref.read(loadMoreProvider.notifier).state = true;
        await ref.read(paymentHistoryProvider.notifier).loadMoreData(token!);
        ref.read(loadMoreProvider.notifier).state = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              ref.watch(isSearchProvider) ? searchAppBar() : homeAppBar(),
              const SizedBox(height: 8),
              HomeLoading(
                isLoading: ref.watch(paymentHistoryProvider.notifier).isLoading,
                isSearch: ref.watch(isSearchProvider),
                isLoadingMore: ref.watch(loadMoreProvider),
                data: ref.watch(paymentHistoryProvider),
                scrollController: _scrollController,
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
            onTap: () async {
              ref.read(isSearchProvider.notifier).state = false;
              ref.read(paymentHistoryProvider.notifier).empty();
              await ref
                  .read(paymentHistoryProvider.notifier)
                  .getPaymentHistory(token!);
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
              autofocus: true,
              onChanged: (value) async {
                if (value.length > 1) {
                  ref.read(loaderProvider.notifier).state = true;
                  await ref
                      .read(paymentHistoryProvider.notifier)
                      .getSearchPaymentHistory(token!, value);
                  ref.read(loaderProvider.notifier).state = false;
                } else if (value.isEmpty) {
                  ref.read(paymentHistoryProvider.notifier).empty();
                  await ref
                      .read(paymentHistoryProvider.notifier)
                      .getPaymentHistory(token!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Container homeAppBar() {
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
                  ref.read(isSearchProvider.notifier).state = true;
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
}

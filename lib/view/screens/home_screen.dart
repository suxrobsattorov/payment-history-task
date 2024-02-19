// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/search_data.dart';
import '../../provider/login_provider.dart';
import '../../provider/payment_history_provider.dart';
import '../constants/Colors.dart';
import '../widgets/home_appbar.dart';
import '../widgets/payment_details.dart';

final loaderProvider = StateProvider<bool>((ref) => false);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<SubData> dataList = [];
  int page = 1;
  String? token;

  @override
  void didChangeDependencies() async {
    token = ref.watch(loginProvider.notifier).token;
    super.didChangeDependencies();
  }

  Future<void> loadMoreData() async {
    await fetchData(page);
    page++;
  }

  Future<void> fetchData(int pageKey) async {
    await ref
        .read(paymentHistoryProvider.notifier)
        .getPaymentHistory(token!, pageKey, '');

    if (ref.watch(paymentHistoryProvider).dataList.isNotEmpty) {
      dataList.addAll(ref.watch(paymentHistoryProvider).dataList);
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
              const HomeAppbar(),
              const SizedBox(height: 8),
              Consumer(
                builder: (context, ref, child) {
                  return Container(
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        74,
                    color: AppColors.backgroundColor2,
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                      bottom: 20,
                    ),
                    child: ListView.builder(
                      itemCount: dataList.length + 1,
                      itemBuilder: (context, index) {
                        if (index < dataList.length) {
                          return PaymentDetails(
                            index: index,
                            data: dataList[index],
                          );
                        } else {
                          if (ref
                                  .watch(paymentHistoryProvider)
                                  .data
                                  ?.totalItems !=
                              dataList.length) loadMoreData();
                          return ref
                                      .watch(paymentHistoryProvider)
                                      .data
                                      ?.totalItems ==
                                  dataList.length
                              ? Container()
                              : const Padding(
                                  padding: EdgeInsets.only(bottom: 30),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                );
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:payment_history_task/model/payment_history.dart';
import 'package:payment_history_task/provider/login_provider.dart';
import 'package:payment_history_task/provider/payment_history_provider.dart';
import 'package:payment_history_task/view/constants/Colors.dart';
import 'package:payment_history_task/view/constants/images.dart';
import 'package:payment_history_task/view/widgets/loading.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final scrollController = ScrollController();
  var loginHive = Hive.box('login');
  bool isLoadingMore = false;
  bool onTabSearch = false;
  bool first = true;
  bool backSearch = false;
  List<SubData> dataList = [];
  int page = 1;
  String? token;

  @override
  void didChangeDependencies() async {
    if (first && !onTabSearch) {
      token = ref.watch(loginProvider.notifier).token;

      await fetchData(page);
      await ref
          .read(paymentHistoryProvider.notifier)
          .getPaymentHistory2(token!);

      scrollController.addListener(_scrollListener);
    }

    super.didChangeDependencies();
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      page += 1;
      await fetchData(page);
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  Future<void> fetchData(int pageKey) async {
    await ref
        .read(paymentHistoryProvider.notifier)
        .getPaymentHistory(token!, pageKey);

    if (ref.watch(paymentHistoryProvider).data.isNotEmpty) {
      dataList.addAll(ref.watch(paymentHistoryProvider).data);
    }
  }

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(paymentHistoryProvider);
    // print(watch.dataForSearch.length);
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
                      isLoadingMore: false,
                      dataTypeIsSearch: true,
                      payTypes: watch.payTypesForSearch,
                      data: watch.searchData,
                      scrollController: scrollController,
                    )
                  : backSearch
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.mainColor,
                          ),
                        )
                      : Loading(
                          isLoading: watch.isLoading,
                          isLoadingMore: isLoadingMore,
                          dataTypeIsSearch: false,
                          payTypes: watch.payTypes,
                          data: dataList,
                          scrollController: scrollController,
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
              setState(() async {
                onTabSearch = false;
                first = false;
                page = 1;
                dataList = [];
                setState(() {
                  backSearch = true;
                });
                await fetchData(page);
                backSearch = false;
                scrollController.addListener(_scrollListener);
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
              autofocus: true,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  ref.read(paymentHistoryProvider.notifier).search(value);
                } else {
                  setState(() {
                    ref.read(paymentHistoryProvider.notifier).empty();
                  });
                }
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
                  logOut();
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

  void logOut() {
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

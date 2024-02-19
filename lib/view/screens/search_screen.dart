// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/search_data.dart';
import '../../provider/login_provider.dart';
import '../../provider/payment_history_provider.dart';
import '../constants/Colors.dart';
import '../constants/images.dart';
import '../widgets/payment_details.dart';

final loaderProvider = StateProvider<bool>((ref) => false);
final loadingMoreProvider = StateProvider<bool>((ref) => false);

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  TextEditingController controller = TextEditingController();
  List<SubData> dataList = [];
  int page = 1;
  String? token;

  @override
  void didChangeDependencies() async {
    token = ref.watch(loginProvider.notifier).token;
    dataList = [];
    page = 1;
    super.didChangeDependencies();
  }

  Future<void> loadMoreData() async {
    if (controller.text.isNotEmpty) {
      await fetchData(page, controller.text);
      page++;
    } else {
      dataList = [];
      page = 1;
    }
  }

  Future<void> fetchData(int pageKey, String fio) async {
    await ref
        .read(paymentHistoryProvider.notifier)
        .getPaymentHistory(token!, pageKey, fio);

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
              searchAppBar(),
              const SizedBox(height: 8),
              Consumer(
                builder: (context, ref, child) {
                  return ref.watch(loaderProvider)
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.mainColor,
                          ),
                        )
                      : dataList.isNotEmpty
                          ? Container(
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
                                            .data!
                                            .totalItems! >
                                        dataList.length) {
                                      loadMoreData();
                                    }
                                    return ref
                                                .watch(paymentHistoryProvider)
                                                .data!
                                                .totalItems! <=
                                            dataList.length
                                        ? Container()
                                        : const Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 30),
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.mainColor,
                                              ),
                                            ),
                                          );
                                  }
                                },
                              ),
                            )
                          : Container();
                },
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
              Navigator.of(context).pop();
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
            width: MediaQuery.of(context).size.width - 140,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Qidiruv',
                hintStyle: GoogleFonts.mulish(
                  fontSize: 14,
                  color: Colors.grey.shade400,
                ),
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.done,
              autofocus: true,
              controller: controller,
            ),
          ),
          InkWell(
            onTap: () async {
              ref.read(loaderProvider.notifier).state = true;
              await loadMoreData();
              ref.read(loaderProvider.notifier).state = false;
            },
            child: Image.asset(
              Images.search,
              fit: BoxFit.cover,
              height: 17,
              width: 17,
              color: AppColors.mainColor,
            ),
          ),
        ],
      ),
    );
  }
}

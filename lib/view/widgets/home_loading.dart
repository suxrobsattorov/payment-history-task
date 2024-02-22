// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/payment_history.dart';
import '../constants/Colors.dart';
import '../screens/home_screen.dart';
import 'payment_details.dart';

class HomeLoading extends ConsumerWidget {
  ScrollController scrollController;
  bool? isLoading;
  bool isSearch;
  bool isLoadingMore;
  List<SubData> data;

  HomeLoading({
    super.key,
    required this.isLoading,
    required this.isSearch,
    required this.isLoadingMore,
    required this.data,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isLoading == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.mainColor,
        ),
      );
    } else if (isLoading == false) {
      return Center(
        child: Text(
          'Xatolik',
          style: GoogleFonts.mulish(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.red,
          ),
        ),
      );
    } else {
      if (data.isEmpty) {
        return ref.watch(loaderProvider)
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              )
            : Center(
                child: Text(
                  isSearch
                      ? 'Hech narsa topilmadi!'
                      : 'To\'lovlar mavjud emas.',
                  style: GoogleFonts.mulish(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              );
      } else {
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
            controller: scrollController,
            itemCount: isLoadingMore ? data.length + 1 : data.length,
            itemBuilder: (context, index) {
              if (index < data.length) {
                return PaymentDetails(
                  index: index,
                  data: data[index],
                );
              } else {
                return const Padding(
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
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_history_task/provider/payment_history_provider.dart';
import 'package:payment_history_task/view/constants/Colors.dart';

import '../../model/payment_history.dart';
import 'payment_details.dart';

// ignore: must_be_immutable
class Loading extends ConsumerWidget {
  bool? isLoading;
  List<PayTypes> payTypes = [];
  List<SubData> data = [];

  Loading({
    super.key,
    required this.isLoading,
    required this.payTypes,
    required this.data,
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
      // ignore: unnecessary_null_comparison
      if (ref.watch(paymentHistoryProvider).paymentHistory == null) {
        return Center(
          child: Text(
            'To\'lovlar mavjud emas',
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
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return PaymentDetails(
                index: index,
                payTypes: payTypes,
                data: data[index],
              );
            },
          ),
        );
      }
    }
  }
}

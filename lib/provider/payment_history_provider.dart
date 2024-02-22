import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/payment_history.dart';
import '../service/payment_history_service.dart';

class PaymentHistoryProvider extends StateNotifier<List<SubData>> {
  PaymentHistoryProvider() : super([]);

  PaymentHistory? paymentHistory;
  int page = 1;
  bool? isLoading;

  Future<void> getPaymentHistory(String token) async {
    await PaymentHistoryService.getByPage(token, page).then((value) {
      if (value != null) {
        paymentHistory = value;
        if (mounted) {
          state = [...state, ...value.data?.payments?.data as List<SubData>];
        }
        isLoading = true;
      } else {
        isLoading = false;
        state = [];
      }
    });
  }

  Future<void> getSearchPaymentHistory(String token, String fio) async {
    page = 1;
    state = [];
    await PaymentHistoryService.getByPage(token, page, fio: fio).then((value) {
      if (value != null) {
        paymentHistory = value;
        if (mounted) {
          state = [...state, ...value.data?.payments?.data as List<SubData>];
        }
        isLoading = true;
      } else {
        isLoading = false;
        state = [];
      }
    });
  }

  Future<void> loadMoreData(String token) async {
    double maxPage = -1;
    if (paymentHistory != null &&
        paymentHistory!.data != null &&
        paymentHistory!.data!.payments != null &&
        paymentHistory!.data!.payments!.total != null) {
      maxPage = (paymentHistory!.data!.payments!.total! /
              paymentHistory!.data!.payments!.perPage!) +
          1;
    }
    if (maxPage == -1 || page <= maxPage) {
      if (state.length < paymentHistory!.data!.payments!.total!) {
        page++;
        await getPaymentHistory(token);
      } else {
        page = 1;
      }
    }
  }

  void empty() {
    isLoading = null;
    page = 1;
    paymentHistory = null;
    state = [];
  }
}

final paymentHistoryProvider =
    StateNotifierProvider.autoDispose<PaymentHistoryProvider, List<SubData>>(
  (ref) => PaymentHistoryProvider(),
);

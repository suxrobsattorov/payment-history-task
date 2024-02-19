import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/search_data.dart';
import '../service/payment_history_service.dart';

class PaymentHistoryState {
  List<SubData> dataList;
  Data? data;
  bool? isLoading;

  PaymentHistoryState({
    required this.dataList,
    this.data,
    this.isLoading,
  });
}

class PaymentHistoryProvider extends StateNotifier<PaymentHistoryState> {
  PaymentHistoryProvider() : super(PaymentHistoryState(dataList: []));

  void emptyDataList() {
    state.dataList = [];
  }

  Future<void> getPaymentHistory(String token, int page, String fio) async {
    await PaymentHistoryService.getByPage(token, page, fio).then((value) {
      if (value != null) {
        state = PaymentHistoryState(
          dataList: value.data?.subData as List<SubData>,
          data: value.data,
          isLoading: true,
        );
      } else {
        state.isLoading = false;
      }
    });
  }
}

final paymentHistoryProvider = StateNotifierProvider<PaymentHistoryProvider, PaymentHistoryState>(
  (ref) => PaymentHistoryProvider(),
);

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/login_response.dart';
import '../model/payment_history.dart';
import '../service/payment_history_service.dart';

class PaymentHistoryProvider extends ChangeNotifier {
  bool? isLoading;
  PaymentHistory? paymentHistory;
  List<PayTypes> payTypes = [];
  List<SubData> data = [];
  List<PayTypes> payTypesForSearch = [];
  List<SubData> dataForSearch = [];
  List<SubData> searchData = [];

  void empty() {
    searchData = [];
  }

  void search(String lastname) {
    searchData = [];
    if (dataForSearch.isNotEmpty && payTypesForSearch.isNotEmpty) {
      for (SubData s in dataForSearch) {
        if (s.student!.lastName!
            .toLowerCase()
            .startsWith(lastname.toLowerCase())) {
          searchData.add(s);
        }
      }
    }
    notifyListeners();
  }

  Future<void> getPaymentHistory(LoginResponse response, int page) async {
    searchData = [];
    data = [];
    payTypes = [];
    await PaymentHistoryService.getByPage(response, page).then((value) {
      if (value != null) {
        paymentHistory = value;
        isLoading = true;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });

    if (paymentHistory != null) {
      payTypes = paymentHistory!.data?.payTypes as List<PayTypes>;
      data = paymentHistory!.data?.payments?.data as List<SubData>;

      payTypesForSearch.addAll(payTypes);
      dataForSearch.addAll(data);
    }
    notifyListeners();
  }

/*Future<void> getPaymentHistory2(LoginResponse response) async {
    searchData = [];
    paymentHistory = null;
    isLoading = null;
    await PaymentHistoryService.fetch(response).then((value) {
      if (value != null) {
        paymentHistory = value;
        isLoading = true;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
    int pageCount = 0;
    if (paymentHistory != null &&
        paymentHistory?.data != null &&
        paymentHistory?.data?.payments != null) {
      pageCount = int.parse((paymentHistory!.data!.payments!.total! /
                  paymentHistory!.data!.payments!.perPage!)
              .toString()
              .split('.')[0]) +
          1;

      paymentHistoryList.add(paymentHistory!);

      if (pageCount > 0) {
        for (int i = 2; i <= pageCount; i++) {
          await PaymentHistoryService.getByPage(response, i).then((value) {
            if (value != null) {
              paymentHistoryList.add(value);
            }
          });
        }
      }
      for (int i = 0; i < paymentHistoryList.length; i++) {
        payTypes.addAll(paymentHistoryList[i].data?.payTypes as List<PayTypes>);
        data.addAll(
            paymentHistoryList[i].data?.payments?.data as List<SubData>);
      }
    }
    notifyListeners();
  }*/
}

final paymentHistoryProvider = ChangeNotifierProvider(
  (ref) => PaymentHistoryProvider(),
);

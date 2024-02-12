import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/payment_history.dart';
import '../constants/Colors.dart';
import '../constants/images.dart';

// ignore: must_be_immutable
class PaymentDetails extends StatelessWidget {
  int index;
  List<PayTypes> payTypes;
  SubData data;

  PaymentDetails({
    super.key,
    required this.index,
    required this.payTypes,
    required this.data,
  });

  String amount = '';
  String cardImage = '';
  List<String> cardImages = [
    Images.visa,
    Images.uzcard,
    Images.humo,
    Images.naqt,
    Images.p2p,
  ];

  void selectCardImage() {
    if (data.payType?.name == 'Plastik karta ( UZCARD)') {
      cardImage = cardImages[1];
    } else if (data.payType?.name == 'Plastik karta (HUMO)') {
      cardImage = cardImages[2];
    } else if (data.payType?.name == 'Plastik karta (VISA)') {
      cardImage = cardImages[0];
    } else if (data.payType?.name == 'Pul o`tkazma(Perechesleniya)') {
      cardImage = cardImages[4];
    } else {
      cardImage = cardImages[3];
    }
  }

  void amountStyle() {
    amount = data.amount.toString();
    String left = '', left2 = '';
    for (int i = amount.length - 1; i > -1; i--) {
      left += amount[i];
    }
    for (int i = 0; i < left.length; i++) {
      left2 += left[i];
      if ((i + 1) % 3 == 0) {
        left2 += ' ';
      }
    }
    amount = '';
    for (int i = left2.length - 1; i > -1; i--) {
      amount += left2[i];
    }
  }

  @override
  Widget build(BuildContext context) {
    amountStyle();
    selectCardImage();
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: AppColors.tableBorderColor,
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${index + 1}. ${data.student?.lastName ?? ''} ${data.student?.firstName ?? ''} ${data.student?.middleName ?? ''}',
            style: GoogleFonts.mulish(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Text(
            data.group?.nameUz ?? '',
            style: GoogleFonts.mulish(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: AppColors.tableBorderColor,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade100,
                ),
                height: 30,
                width: 70,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Image.asset(
                    cardImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    amount,
                    style: GoogleFonts.mulish(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                    ),
                  ),
                  Text(
                    'To\'langan vaqt, ${data.createdAt?.split('T')[1].substring(0, 5) ?? ''}',
                    style: GoogleFonts.mulish(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

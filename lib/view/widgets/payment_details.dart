import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_history_task/view/util/style_functions.dart';
import 'package:payment_history_task/view/widgets/image_container.dart';

import '../../model/search_data.dart';
import '../constants/Colors.dart';

// ignore: must_be_immutable
class PaymentDetails extends StatelessWidget {
  int index;
  SubData data;

  PaymentDetails({
    super.key,
    required this.index,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final debt = StyleFunctions.amountStyle(data.debt.toString().split('.')[0]);
    final educationPrice =
        StyleFunctions.amountStyle(data.group?.educationPrice.toString() ?? '');
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${index + 1}. ${data.lastName ?? ''} ${data.firstName ?? ''} ${data.middleName ?? ''}',
            style: GoogleFonts.mulish(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  data.group != null && data.group!.eduType != null
                      ? Text(
                          data.group?.eduType?.shortName ?? '',
                          style: GoogleFonts.mulish(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade700,
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 10),
                  Text(
                    'Guruh nomi : ',
                    style: GoogleFonts.mulish(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  data.group != null && data.group!.eduType != null
                      ? Text(
                    '  ${data.group!.name}' ?? '',
                          style: GoogleFonts.mulish(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        )
                      : Container(),
                ],
              ),
              data.group != null && data.group!.eduType != null
                  ? ImageContainer(url: data.group!.eduType!.image)
                  : Container(),
            ],
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
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade200,
                      blurRadius: 5,
                      offset: const Offset(-2, 2), // Shadow position
                    ),
                  ],
                ),
                child: Text(
                  educationPrice,
                  style: GoogleFonts.mulish(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade400,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade200,
                      blurRadius: 5,
                      offset: const Offset(2, 2), // Shadow position
                    ),
                  ],
                ),
                child: Text(
                  debt,
                  style: GoogleFonts.mulish(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class CancelFoodAndBeverageView extends StatelessWidget {
  // final List<Map<String, dynamic>> foodList;
  // final int index;
  final String name;
  final int price;
  final int qty;
  final Function onTapCancel;
  CancelFoodAndBeverageView(this.name,this.price,this.qty,this.onTapCancel);

// CancelFoodAndBeverageView(this.foodList,this.index);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
                const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                  onTap: ()=>onTapCancel(),
                  child: Image.asset("assets/images/cancel.png")),
              const SizedBox(width: MARGIN_MEDIUM),
               RichText(text: TextSpan(
                 children: [
                   TextSpan(
                     text:name,
                     style: const TextStyle(
                       fontWeight: FontWeight.w700,
                       fontSize: TEXT_REGULAR,
                       color: SMS_CODE_COLOR,
                     ),
                   ),
                   TextSpan(text:
                   "(Qt. ${qty})",
                     style: const TextStyle(
                       fontWeight: FontWeight.w700,
                       fontSize: TEXT_REGULAR,
                       color: SMS_CODE_COLOR,
                     ),
                   ),
                 ]
               )),
              const Spacer(),
               Text(
                "${price*qty*1000}Ks",

                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: TEXT_REGULAR,
                  color: SMS_CODE_COLOR,
                ),
              ),
            ],
          ),
          const SizedBox(height: MARGIN_MEDIUM_3),
        ],
      ),
    );
  }
}
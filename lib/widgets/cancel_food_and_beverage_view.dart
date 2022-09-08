import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class CancelFoodAndBeverageView extends StatelessWidget {
  final List<Map<String, dynamic>> foodList;
  final int index;

CancelFoodAndBeverageView(this.foodList,this.index);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset("assets/images/cancel.png"),
            const SizedBox(width: MARGIN_MEDIUM),
             RichText(text: TextSpan(
               children: [
                 TextSpan(
                   text:"${foodList.elementAt(index)['foodName']}",
                   style: const TextStyle(
                     fontWeight: FontWeight.w700,
                     fontSize: TEXT_REGULAR,
                     color: SMS_CODE_COLOR,
                   ),
                 ),
                 TextSpan(text:
                 "(Qt. ${foodList.elementAt(index)['quantity']})",
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
              "${foodList.elementAt(index)['price']}Ks",

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
    );
  }
}
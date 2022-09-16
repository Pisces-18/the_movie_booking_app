import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class PaymentTypeView extends StatelessWidget {
  final Function onTapPayment;
  final PaymentVO? payment;

  PaymentTypeView(
    this.payment,

    this.onTapPayment,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: PAYMENT_TYPE_BG_COLOR,
              ),
              borderRadius: BorderRadius.circular(
                MARGIN_MEDIUM,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: MARGIN_SMALL,
                  offset: Offset(0, 0),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_x,
              vertical: MARGIN_MEDIUM_X,
            ),
            child: Row(
              children: [
                // Image.asset(
                //   "${payment.elementAt(index)['logo']}",
                //   color: Colors.white,
                //   width: MARGIN_LARGE,
                //   height: MARGIN_LARGE,
                // ),
                const SizedBox(width: MARGIN_MEDIUM_X),
                Text(
                  payment?.name?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: TEXT_REGULAR_2Xx,
                      color: Colors.white),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: ()=>onTapPayment(),
                  child: Image.asset(
                    "assets/images/right_arrow.png",
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_X),
      ],
    );
  }
}

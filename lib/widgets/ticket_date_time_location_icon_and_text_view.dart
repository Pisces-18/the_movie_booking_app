import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class TicketDateTimeLocationIconAndTextView extends StatelessWidget {
  final String image;
  final String text;
  TicketDateTimeLocationIconAndTextView(this.image, this.text);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(MARGIN_XSMALL),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  DASH_COLOR_2,
                  TICKET_DETAILS_VIEW_GRADIENT_COLOR_1,
                  DASH_COLOR_2,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: PRIMARY_COLOR_1,
                  offset: Offset(0, 0),
                  blurRadius: MARGIN_MEDIUM_X,
                  spreadRadius: -3,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(MARGIN_XSMALL),
              child: Image.asset(
                image,
                width: MARGIN_MEDIUM_3,
                height: MARGIN_MEDIUM_3,
              ),
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM_X),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
           // mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.loose,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: TEXT_REGULAR,
                      color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

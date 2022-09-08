import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class CensorDateDurationView extends StatelessWidget {
  final String title;
  final String text;
  CensorDateDurationView(this.title,this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:  const LinearGradient(
            begin: Alignment.center,
            end: Alignment.centerRight,
            colors: [
              ABOUT_MOVIE_CENSOR_DATE_DURATION_GRADIENT_COLOR_1,
              ABOUT_MOVIE_CENSOR_DATE_DURATION_GRADIENT_COLOR_2,
            ]),
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM_X),
        boxShadow: const [
          BoxShadow(
            blurRadius: MARGIN_lLARGE,
            color: ABOUT_MOVIE_CENSOR_DATE_DURATION_BOX_SHADOW_COLOR,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_X, vertical: MARGIN_MEDIUM),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: TEXT_SMALL,
                  color: Colors.white),
            ),
            const SizedBox(height: MARGIN_MEDIUM_X),
            Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: TEXT_REGULAR_2X,
                  color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}

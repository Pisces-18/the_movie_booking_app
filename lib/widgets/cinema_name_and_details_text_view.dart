import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class CinemaNameAndDetailsTextView extends StatelessWidget {
  final Function onTapSeeDetails;
  final String title;
  CinemaNameAndDetailsTextView(this.title, this.onTapSeeDetails);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: TEXT_REGULAR_2X,
              color: Colors.white),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => onTapSeeDetails(),
          child: const Text(
            SEE_DETAILS_TEXT,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: TEXT_REGULAR_2X,
                color: PRIMARY_COLOR_1,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}

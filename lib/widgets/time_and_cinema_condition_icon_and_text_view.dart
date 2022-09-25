import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class TimeAndCinemaConditionView extends StatefulWidget {
  final String text;
  final String image;
  final String Color;
  TimeAndCinemaConditionView(this.text, this.image, this.Color);

  @override
  State<TimeAndCinemaConditionView> createState() =>
      _TimeAndCinemaConditionViewState();
}

class _TimeAndCinemaConditionViewState
    extends State<TimeAndCinemaConditionView> {
  late String textColor;
  @override
  void initState(){
    super.initState();
    textColor="0XFF${(widget.Color).substring(1,7)}";
    debugPrint(textColor);
  }
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(widget.image,color: Color(int.parse(textColor),)),
        const SizedBox(width: MARGIN_MEDIUM_X),
        Text(
          widget.text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: TEXT_REGULAR_2X,
              color: Color(int.parse(textColor)),
          ),
        ),
        // const SizedBox(width: MARGIN_XXxLARGE),

      ],
    );
  }
}
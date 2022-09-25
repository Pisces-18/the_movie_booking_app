import 'package:flutter/material.dart';
import '../resources/dimens.dart';

class AvailableServiceIconAndTextView extends StatelessWidget {
  final String text;
  final String image;
  final Color changedColor;
  AvailableServiceIconAndTextView(this.text, this.image,this.changedColor);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(image,color: changedColor,width: MARGIN_LARGE,height: MARGIN_LARGE,),
        const SizedBox(width: MARGIN_SMALL_Lx),
        Text(
          text,
          style:  TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: TEXT_REGULAR,
            color: changedColor,
          ),
        ),
        const SizedBox(width: MARGIN_MEDIUM_2),
      ],
    );
  }
}

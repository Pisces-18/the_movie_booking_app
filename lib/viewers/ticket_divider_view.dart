import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class TicketDividerView extends StatefulWidget {

  // double dividerWidth;
  // TicketDividerView(this.dividerWidth);

  @override
  State<TicketDividerView> createState() => _TicketDividerViewState();
}

class _TicketDividerViewState extends State<TicketDividerView> {
  // void initSate(){
  //   super.initState();
  //   setState((){
  //     widget.dividerWidth=widget.dividerWidth - 36.0;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Container(
          height: MARGIN_XxLARGE,
          width: MARGIN_XXLARGE,
          decoration:  const BoxDecoration(
             shape: BoxShape.circle,
              color: PAGE_BACKGROUND_COLOR,


            ),
        ),
         DottedLine(
          dashColor: APPBAR_COLOR,
          direction: Axis.horizontal,
          lineThickness: 2.0,
          lineLength: DIVIDER_WIDTH,
        ),
        Container(
          height: MARGIN_XxLARGE,
          width: MARGIN_XXLARGE,
          decoration:  const BoxDecoration(
            shape: BoxShape.circle,
            color: PAGE_BACKGROUND_COLOR,
          ),
        ),
      ],
    );
  }
}

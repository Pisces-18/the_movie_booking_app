import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../widgets/available_service_icon_and_text_view.dart';
import '../widgets/cinema_name_and_details_text_view.dart';

class CinemaListView extends StatelessWidget {
  final String cinemaName;
  final Function onTapSeeDetails;
  CinemaListView(this.cinemaName, this.onTapSeeDetails);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: MARGIN_xXLARGE, left: MARGIN_MEDIUM_2, right: MARGIN_MEDIUM_2,bottom: MARGIN_MEDIUM_2),
      decoration: const BoxDecoration(
        border:Border(
          bottom: BorderSide(
            color: SMS_CODE_COLOR
          )
        )
      ),
      child: Column(
        children: [
          CinemaNameAndDetailsTextView(cinemaName, () => onTapSeeDetails()),
          // const SizedBox(height: MARGIN_MEDIUM_3L),
          // Row(
          //   children: [
          //     AvailableServiceIconAndTextView(
          //         "Parking",
          //         "assets/images/parking_icon.png",
          //         AVAILABLE_SERVICE_TEXT_COLOR),
          //     const SizedBox(width: MARGIN_MEDIUM_2),
          //     AvailableServiceIconAndTextView(
          //         "Online Food",
          //         "assets/images/foodAndBeverage.png",
          //         AVAILABLE_SERVICE_TEXT_COLOR),
          //     const SizedBox(width: MARGIN_MEDIUM_2),
          //     AvailableServiceIconAndTextView(
          //         "Wheel Chair",
          //         "assets/images/wheel_chair_icon.png",
          //         AVAILABLE_SERVICE_TEXT_COLOR),
          //   ],
          // ),
          // const SizedBox(height: ),
          // Divider(
          //   color: SMS_CODE_COLOR,
          // )
        ],
      ),
    );
  }
}

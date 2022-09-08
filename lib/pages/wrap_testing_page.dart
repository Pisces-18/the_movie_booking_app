import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/available_service_icon_and_text_view.dart';

class WrapTestingPage extends StatelessWidget {
  final List<Map<String,dynamic>> facilityList=[
    {
      "text":"Parking",
      "icon":"assets/images/parking_icon.png",
    },
    {
      "text":"Online Food",
      "icon":"assets/images/foodAndBeverage.png",
    },
    {
      "text":"Wheel Chair",
      "icon":"assets/images/wheel_chair_icon.png",
    },
    {
      "text":"Ticket Cancelation",
      "icon":"assets/images/ticketCancelationIcon.png",
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: APPBAR_COLOR,
        leading: Image.asset(
          "assets/images/leftIcon.png",
          width: MARGIN_LARGE,
          height: MARGIN_LARGE,
        ),
        title: const Text(
          CINEMA_INFO_PAGE_TITLE_TEXT,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: TEXT_REGULAR_4X,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
            child: Image.asset(
              "assets/images/starIcon.png",
              width: MARGIN_LARGE,
              height: MARGIN_LARGE,
            ),
          ),
        ],
      ),
      body: Wrap(
        runSpacing: 17,
        children: [
          Container(
           width: MediaQuery.of(context).size.width/4.3,
            child: AvailableServiceIconAndTextView(
                "Parking", "assets/images/parking_icon.png", PRIMARY_COLOR_1),
          ),

          Container(
            width: MediaQuery.of(context).size.width/3.6,
            child: AvailableServiceIconAndTextView("Online Food",
                "assets/images/foodAndBeverage.png", PRIMARY_COLOR_1),
          ),

          Container(
            width: MediaQuery.of(context).size.width/2.7,
            child: AvailableServiceIconAndTextView("Wheel Chair",
                "assets/images/wheel_chair_icon.png", PRIMARY_COLOR_1),
          ),

          Container(
            width: MediaQuery.of(context).size.width/2.7,
            child: AvailableServiceIconAndTextView("Ticket Cancelation",
                "assets/images/ticketCancelationIcon.png", PRIMARY_COLOR_1),
          ),
        ],
      ),
    );
  }
}

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../widgets/available_service_icon_and_text_view.dart';
import '../widgets/cinema_name_and_details_text_view.dart';
import '../widgets/time_and_available_seat_view.dart';


class CinemaExpansionView extends StatelessWidget {
  final String cinemaName;
  // final bool isVisibilityTimeAndAvailableSeatView;
  //final List<String> cinemaList;
 // final int index;
  final Function onTapTime;
  final Function onTapSeeDetails;
  final List<Map<String,dynamic>> timeAndAvailableSeatData;
 CinemaExpansionView(this.cinemaName,this.onTapSeeDetails,this.onTapTime,this.timeAndAvailableSeatData);
 // CinemaDropDownView(this.cinemaList,this.index,this.onTapTime);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandablePanel(
          header: ExpandablePanelHeaderSectionView(cinemaName: cinemaName, onTapSeeDetails: onTapSeeDetails),
          expanded: ExpandablePanelExpadedSectionView(onTapTime: onTapTime, timeAndAvailableSeatData: timeAndAvailableSeatData),
          collapsed: Container(),
          theme:const ExpandableThemeData(
            hasIcon: false,
          ) ,
        ),
        const SizedBox(height: MARGIN_xXLARGE),
        const Divider(
          color: SMS_CODE_COLOR,
        ),

      ],
    );
  }
}

class ExpandablePanelExpadedSectionView extends StatelessWidget {
  const ExpandablePanelExpadedSectionView({
    Key? key,
    required this.onTapTime,
    required this.timeAndAvailableSeatData,
  }) : super(key: key);

  final Function onTapTime;
  final List<Map<String, dynamic>> timeAndAvailableSeatData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: MARGIN_MEDIUM_3LX,
          left: MARGIN_MEDIUM_2,
          right: MARGIN_MEDIUM_2),
      child: Column(
        children: [
          GestureDetector(
            onTap: ()=>onTapTime(),
              child: TimeAndAvailableSeatView(timeAndAvailableSeatData)),

        ],
      ),
    );
  }
}

class ExpandablePanelHeaderSectionView extends StatelessWidget {
  const ExpandablePanelHeaderSectionView({
    Key? key,
    required this.cinemaName,
    required this.onTapSeeDetails,
  }) : super(key: key);

  final String cinemaName;
  final Function onTapSeeDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: MARGIN_xXLARGE, left: MARGIN_MEDIUM_2, right: MARGIN_MEDIUM_2),
      child: Column(
        children: [
          CinemaNameAndDetailsTextView(
              cinemaName,
              ()=>onTapSeeDetails()),
          const SizedBox(height: MARGIN_MEDIUM_3L),
          Row(
            children: [
              AvailableServiceIconAndTextView(
                  "Parking", "assets/images/parking_icon.png",AVAILABLE_SERVICE_TEXT_COLOR),
              const SizedBox(width: MARGIN_MEDIUM_2),
              AvailableServiceIconAndTextView(
                  "Online Food", "assets/images/foodAndBeverage.png",AVAILABLE_SERVICE_TEXT_COLOR),
              const SizedBox(width: MARGIN_MEDIUM_2),
              AvailableServiceIconAndTextView(
                  "Wheel Chair", "assets/images/wheel_chair_icon.png",AVAILABLE_SERVICE_TEXT_COLOR),
            ],
          ),

        ],
      ),
    );
  }
}

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/time_slot_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/available_service_icon_and_text_view.dart';
import '../widgets/cinema_name_and_details_text_view.dart';
import '../widgets/time_and_available_seat_view.dart';

class CinemaExpansionView extends StatefulWidget {
  final String? cinemaName;
  // final bool isVisibilityTimeAndAvailableSeatView;
  //final List<String> cinemaList;
  // final int index;
  final Function(int,String) onTapTime;
  final Function(String,String) onTapSeeDetails;
  final String location;
  final List<TimeSlotVO>? timeSlots;
  CinemaExpansionView(this.cinemaName, this.onTapSeeDetails, this.onTapTime,
      this.timeSlots, this.location);

  @override
  State<CinemaExpansionView> createState() => _CinemaExpansionViewState();
}

class _CinemaExpansionViewState extends State<CinemaExpansionView> {
  // CinemaDropDownView(this.cinemaList,this.index,this.onTapTime);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandablePanel(
          header: ExpandablePanelHeaderSectionView(
            cinemaName: widget.cinemaName ?? "",
            onTapSeeDetails: widget.onTapSeeDetails,
            location: widget.location,
          ),
          expanded: ExpandablePanelExpandedSectionView(
            onTapTime: (cinemaDayTimeSlotId,startTime){
              setState((){
                widget.onTapTime(cinemaDayTimeSlotId,startTime);
              });
              //widget.onTapTime(cinemaDayTimeSlotId,startTime);
            },
            timeSlots: widget.timeSlots ?? [],
            location: widget.location,
          ),
          collapsed: Container(),
          theme: const ExpandableThemeData(
            hasIcon: false,
          ),
        ),
        const SizedBox(height: MARGIN_xXLARGE),
        const Divider(
          color: SMS_CODE_COLOR,
        ),
      ],
    );
  }
}

class ExpandablePanelExpandedSectionView extends StatefulWidget {
  const ExpandablePanelExpandedSectionView({
    Key? key,
    required this.onTapTime,
    required this.timeSlots,
    required this.location,
  }) : super(key: key);

  final Function(int,String) onTapTime;
  final List<TimeSlotVO>? timeSlots;
  final String location;

  @override
  State<ExpandablePanelExpandedSectionView> createState() =>
      _ExpandablePanelExpandedSectionViewState();
}

class _ExpandablePanelExpandedSectionViewState
    extends State<ExpandablePanelExpandedSectionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: MARGIN_MEDIUM_3LX,
          left: MARGIN_MEDIUM_2,
          right: MARGIN_MEDIUM_2),
      child: TimeAndAvailableSeatView(widget.timeSlots,(cinemaDayTimeslotsId,startTime){
        setState((){
          widget.onTapTime(cinemaDayTimeslotsId,startTime);
        });
        //widget.onTapTime(cinemaDayTimeslotsId,startTime);
      }),
    );
  }
}

class ExpandablePanelHeaderSectionView extends StatefulWidget {
  const ExpandablePanelHeaderSectionView({
    Key? key,
    required this.cinemaName,
    required this.onTapSeeDetails,
    required this.location,
  }) : super(key: key);

  final String? cinemaName;
  final Function(String,String) onTapSeeDetails;
  final String location;

  @override
  State<ExpandablePanelHeaderSectionView> createState() =>
      _ExpandablePanelHeaderSectionViewState();
}

class _ExpandablePanelHeaderSectionViewState
    extends State<ExpandablePanelHeaderSectionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: MARGIN_xXLARGE, left: MARGIN_MEDIUM_2, right: MARGIN_MEDIUM_2),
      child: Column(
        children: [
          CinemaNameAndDetailsTextView(widget.cinemaName ?? "",
              () => widget.onTapSeeDetails(widget.location,widget.cinemaName?? "")),
          const SizedBox(height: MARGIN_MEDIUM_3L),
          Row(
            children: [
              AvailableServiceIconAndTextView(
                  "Parking",
                  "assets/images/parking_icon.png",
                  AVAILABLE_SERVICE_TEXT_COLOR),
              const SizedBox(width: MARGIN_MEDIUM_2),
              AvailableServiceIconAndTextView(
                  "Online Food",
                  "assets/images/foodAndBeverage.png",
                  AVAILABLE_SERVICE_TEXT_COLOR),
              const SizedBox(width: MARGIN_MEDIUM_2),
              AvailableServiceIconAndTextView(
                  "Wheel Chair",
                  "assets/images/wheel_chair_icon.png",
                  AVAILABLE_SERVICE_TEXT_COLOR),
            ],
          ),
        ],
      ),
    );
  }
}

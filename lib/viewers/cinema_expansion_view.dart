import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/cinema_time_slots_status_vo.dart';
import 'package:the_movie_booking_app/data/vos/time_slot_vo.dart';
import '../data/vos/cinema_and_show_time_slots_vo.dart';
import '../data/vos/cinema_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/available_service_icon_and_text_view.dart';
import '../widgets/cinema_name_and_details_text_view.dart';
import '../widgets/time_and_available_seat_view.dart';

class CinemaExpansionView extends StatefulWidget {
  //final String? cinemaName;
  // final bool isVisibilityTimeAndAvailableSeatView;
  //final List<String> cinemaList;
  // final int index;
  final Function(TimeSlotVO?) onTapTime;
  final Function(String,int) onTapSeeDetails;
  final String location;
  final List<TimeSlotVO>? cinemaTimeSlots;
  final CinemaVO? cinema;
  final List<CinemaTimeSlotsStatusVO>? configList;
  CinemaExpansionView(this.onTapSeeDetails, this.onTapTime,
      this.cinemaTimeSlots, this.location,this.cinema,this.configList);

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
            cinema: widget.cinema,
            onTapSeeDetails: (location,cinema){
              setState((){
                widget.onTapSeeDetails(location,cinema);
              });
            },
            location: widget.location,
          ),
          expanded: ExpandablePanelExpandedSectionView(
            onTapTime: (cinemaTimeSlot){
              setState((){
                widget.onTapTime(cinemaTimeSlot);
              });
              //widget.onTapTime(cinemaDayTimeSlotId,startTime);
            },
            timeSlots: widget.cinemaTimeSlots?? [],
            location: widget.location,
            configList: widget.configList,
          ),
          collapsed: Container(),
          theme: const ExpandableThemeData(
            hasIcon: false,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_3),
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
    required this.location, this.configList,
  }) : super(key: key);

  final Function(TimeSlotVO?) onTapTime;
  final List<TimeSlotVO>? timeSlots;
  final String location;
  final List<dynamic>? configList;

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
      child: TimeAndAvailableSeatView(widget.timeSlots,(cinemaDayTimeSlot){
        setState((){
          widget.onTapTime(cinemaDayTimeSlot);
        });
        //widget.onTapTime(cinemaDayTimeslotsId,startTime);
      },widget.configList),
    );
  }
}

class ExpandablePanelHeaderSectionView extends StatefulWidget {
  const ExpandablePanelHeaderSectionView({
    Key? key,
    required this.cinema,
    required this.onTapSeeDetails,
    required this.location,
  }) : super(key: key);

  final CinemaVO? cinema;
  final Function(String,int) onTapSeeDetails;
  final String location;

  @override
  State<ExpandablePanelHeaderSectionView> createState() =>
      _ExpandablePanelHeaderSectionViewState();
}

class _ExpandablePanelHeaderSectionViewState
    extends State<ExpandablePanelHeaderSectionView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
              top: MARGIN_MEDIUM_3, left: MARGIN_MEDIUM_2, right: MARGIN_MEDIUM_2),
          child: CinemaNameAndDetailsTextView(widget.cinema?.name?? "",
                  () {
                setState((){
                  widget.onTapSeeDetails(widget.location, widget.cinema?.id?? 0);
                });
              }),
        ),
        const SizedBox(height: MARGIN_MEDIUM_3L),

        Wrap(
          children: widget.cinema?.facilities?.map((facility) => Container(
              margin: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2L_X),
              child: AvailableServiceIconAndTextView(facility.title?? "", facility.img?? "", AVAILABLE_SERVICE_TEXT_COLOR))).toList()?? [],
        ),
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
      ],
    );
  }
}
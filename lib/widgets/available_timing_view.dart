import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/time_slot_vo.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import '../resources/dimens.dart';

class AvailableTimingView extends StatefulWidget {

  final TimeSlotVO? timeSlots;
  final Function(int,String) onTapTime;

  AvailableTimingView(this.timeSlots,this.onTapTime);


  @override
  State<AvailableTimingView> createState() => _AvailableTimingViewState();
}

class _AvailableTimingViewState extends State<AvailableTimingView> {
late Color textColor=SMS_CODE_COLOR;
  late Color backgroundColor=PRIMARY_COLOR_3;
  late Color borderColor=SMS_CODE_COLOR;
  late bool isVisibilityAvailableSeat=true;
  int? selectedTimeSlotId;
  @override
  // void initState() {
  //   super.initState();
  //   if(widget.timeAndAvailableSeatData.elementAt(widget.index)['ticketBookingCondition']=="Available"){
  //     isVisibilityAvailableSeat=false;
  //     textColor=Colors.white;
  //     backgroundColor=AVAILABLE_BACKGROUND_COLOR;
  //     borderColor=AVAILABLE_COLOR;
  //   }else if(widget.timeAndAvailableSeatData.elementAt(widget.index)['ticketBookingCondition']=="Almost Full"){
  //     textColor=Colors.white;
  //     backgroundColor=ALMOST_FULL_BACKGROUND_COLOR;
  //     borderColor=ALMOST_FULL_COLOR;
  //   }else if(widget.timeAndAvailableSeatData.elementAt(widget.index)['ticketBookingCondition']=="Filling Fast"){
  //     textColor=Colors.white;
  //     backgroundColor=FILLING_FAST_BACKGROUND_COLOR;
  //     borderColor=FILLING_FAST_BORDER_COLOR;
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState((){
        selectedTimeSlotId=widget.timeSlots?.cinemaDayTimeslotsId?? 0;
        widget.onTapTime(
            widget.timeSlots?.cinemaDayTimeslotsId ??
                0,widget.timeSlots?.startTime?? "");

      });
      },
      child: Container(
        height: AVAILABLE_TIME_AND_SEAT_SECTION_HEIGHT,
        width: AVAILABLE_TIME_AND_SEAT_SECTION_WIDTH,
        padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_CARD_MEDIUM_2L_X, vertical: MARGIN_MEDIUM),
        decoration: BoxDecoration(
          color: (selectedTimeSlotId== widget.timeSlots?.cinemaDayTimeslotsId) ? AVAILABLE_BACKGROUND_COLOR:backgroundColor,
          borderRadius: BorderRadius.circular(MARGIN_SMALL),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.timeSlots?.startTime?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: TEXT_REGULAR,
                  color: textColor,
                ),
              ),
              const SizedBox(height: MARGIN_SMALL_L),
              Text(
                "3D",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: TEXT_SMALL,
                  color: textColor,
                ),
              ),
              const SizedBox(height: MARGIN_SMALL_L),
              Text(
                "Screen 1",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: TEXT_SMALL,
                  color: textColor,
                ),
              ),
              const SizedBox(height: MARGIN_SMALL_L),
              Text(
                "21 Available",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: TEXT_SMALL,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
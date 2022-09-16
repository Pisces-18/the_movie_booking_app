import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/time_slot_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import 'available_timing_view.dart';

class TimeAndAvailableSeatView extends StatefulWidget {
  final List<TimeSlotVO>? timeSlots;
  final Function(int, String) onTapTime;
  TimeAndAvailableSeatView(this.timeSlots, this.onTapTime);

  @override
  State<TimeAndAvailableSeatView> createState() =>
      _TimeAndAvailableSeatViewState();
}

class _TimeAndAvailableSeatViewState extends State<TimeAndAvailableSeatView> {
  int? selectedTimeSlotId;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width / 1,
      child: Column(
        children: [
          GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: MARGIN_MEDIUM_3,
                mainAxisSpacing: MARGIN_XXLARGE,
                //mainAxisExtent: 92,
              ),
              itemCount: widget.timeSlots?.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState((){
                      selectedTimeSlotId=widget.timeSlots?[index].cinemaDayTimeslotsId;
                      widget.onTapTime(
                          widget.timeSlots?[index].cinemaDayTimeslotsId ?? 0,
                          widget.timeSlots?[index].startTime ?? "");
                    });
                  },
                  child: Container(
                    height: AVAILABLE_TIME_AND_SEAT_SECTION_HEIGHT,
                    width: AVAILABLE_TIME_AND_SEAT_SECTION_WIDTH,
                    padding: const EdgeInsets.symmetric(
                        horizontal: MARGIN_CARD_MEDIUM_2L_X,
                        vertical: MARGIN_MEDIUM),
                    decoration: BoxDecoration(
                      color: (selectedTimeSlotId==widget.timeSlots?[index].cinemaDayTimeslotsId)? AVAILABLE_BACKGROUND_COLOR:PRIMARY_COLOR_3,
                      borderRadius: BorderRadius.circular(MARGIN_SMALL),
                      border: Border.all(
                        color: (selectedTimeSlotId==widget.timeSlots?[index].cinemaDayTimeslotsId)? AVAILABLE_COLOR:SMS_CODE_COLOR,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.timeSlots?[index].startTime ?? "",
                            style:  TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: TEXT_REGULAR,
                              color: (selectedTimeSlotId==widget.timeSlots?[index].cinemaDayTimeslotsId)? Colors.white:SMS_CODE_COLOR,
                            ),
                          ),
                          const SizedBox(height: MARGIN_SMALL_L),
                          Text(
                            "3D",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: TEXT_SMALL,
                              color: (selectedTimeSlotId==widget.timeSlots?[index].cinemaDayTimeslotsId)? Colors.white:SMS_CODE_COLOR,
                            ),
                          ),
                          const SizedBox(height: MARGIN_SMALL_L),
                          Text(
                            "Screen 1",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: TEXT_SMALL,
                              color: (selectedTimeSlotId==widget.timeSlots?[index].cinemaDayTimeslotsId)? Colors.white:SMS_CODE_COLOR,
                            ),
                          ),
                          const SizedBox(height: MARGIN_SMALL_L),
                          Text(
                            "21 Available",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: TEXT_SMALL,
                              color: (selectedTimeSlotId==widget.timeSlots?[index].cinemaDayTimeslotsId)? Colors.white:SMS_CODE_COLOR,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          const SizedBox(height: MARGIN_lLARGE),
          Row(
            children: [
              Image.asset("assets/images/info.png"),
              const SizedBox(width: MARGIN_SMALL_L),
              const Text(
                LONG_PRESS_INFO_TEXT,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: TEXT_REGULAR,
                  color: AVAILABLE_SERVICE_TEXT_COLOR,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// return GestureDetector(
// onTap: () {
// widget.onTapTime(
// widget.timeSlots?[index].cinemaDayTimeslotsId ??
// 0,widget.timeSlots?[index].startTime?? "");
// },
// child: Container(
// height: AVAILABLE_TIME_AND_SEAT_SECTION_HEIGHT,
// width: AVAILABLE_TIME_AND_SEAT_SECTION_WIDTH,
// padding: const EdgeInsets.symmetric(
// horizontal: MARGIN_CARD_MEDIUM_2L_X,
// vertical: MARGIN_MEDIUM),
// decoration: BoxDecoration(
// color: PRIMARY_COLOR_3,
// borderRadius: BorderRadius.circular(MARGIN_SMALL),
// border: Border.all(
// color: SMS_CODE_COLOR,
// ),
// ),
// child: Center(
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Text(
// widget.timeSlots?[index].startTime ?? "",
// style: const TextStyle(
// fontWeight: FontWeight.w600,
// fontSize: TEXT_REGULAR,
// color: SMS_CODE_COLOR,
// ),
// ),
// const SizedBox(height: MARGIN_SMALL_L),
// Text(
// "3D",
// style: TextStyle(
// fontWeight: FontWeight.w600,
// fontSize: TEXT_SMALL,
// color: SMS_CODE_COLOR,
// ),
// ),
// const SizedBox(height: MARGIN_SMALL_L),
// Text(
// "Screen 1",
// style: TextStyle(
// fontWeight: FontWeight.w600,
// fontSize: TEXT_SMALL,
// color: SMS_CODE_COLOR,
// ),
// ),
// const SizedBox(height: MARGIN_SMALL_L),
// Text(
// "21 Available",
// style: TextStyle(
// fontWeight: FontWeight.w600,
// fontSize: TEXT_SMALL,
// color: SMS_CODE_COLOR,
// ),
// ),
// ],
// ),
// ),
// ),
// );
// })

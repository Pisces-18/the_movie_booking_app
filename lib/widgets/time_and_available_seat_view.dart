import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import 'available_timing_view.dart';

class TimeAndAvailableSeatView extends StatelessWidget {
  final List<Map<String, dynamic>> timeAndAvailableSeatData;
  TimeAndAvailableSeatView(this.timeAndAvailableSeatData);

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
              itemCount: timeAndAvailableSeatData.length,
              itemBuilder: (BuildContext context, int index) {
                return AvailableTimingView(timeAndAvailableSeatData, index);
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

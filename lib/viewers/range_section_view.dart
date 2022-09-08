import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class RangeSectionView extends StatefulWidget {
final String rangeName;
final double rangeValue1;
final double rangeValue2;
RangeSectionView(this.rangeName,{this.rangeValue1=3500,this.rangeValue2=2500});
  @override
  State<RangeSectionView> createState() => _RangeSectionViewState();
}

class _RangeSectionViewState extends State<RangeSectionView> {

   double value1=3500;
  double value2=23000;

 // RangeValues _currentRangeValues =  RangeValues(_value1, value2);
   RangeValues _currentRangeValues=RangeValues(3500,2300);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         const Text(
          PRICE_RANGE_TEXT,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: TEXT_REGULAR,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_3),
        Row(
          children:  [
            Text(
              "${widget.rangeValue1.toString()}Ks",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: TEXT_REGULAR,
                color: SMS_CODE_COLOR,
              ),
            ),
            const Spacer(),
            Text(
              "${widget.rangeValue2.toString()}Ks",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: TEXT_REGULAR,
                color: SMS_CODE_COLOR,
              ),
            ),
          ],
        ),
        SliderTheme(
          data: const SliderThemeData(
            thumbColor: PRIMARY_COLOR_1,
            inactiveTrackColor: SMS_CODE_COLOR,
            activeTrackColor: PRIMARY_COLOR_1,
            activeTickMarkColor: PRIMARY_COLOR_1,
            trackHeight: 1,

          ),
          child:  RangeSlider(
            values: RangeValues(widget.rangeValue1, widget.rangeValue2),
            min: 3500,
            max: 29500,
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
            // labels: RangeLabels(
            //   _currentRangeValues.start.round().toString(),
            //   _currentRangeValues.end.round().toString(),
            // ),
          ),
        ),
      ],
    );
  }
}
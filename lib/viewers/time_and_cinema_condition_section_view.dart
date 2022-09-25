import 'package:flutter/material.dart';

import '../data/vos/config_vo.dart';
import '../data/vos/value_vo.dart';
import '../pages/choose_time_and_cinema_page.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../widgets/time_and_cinema_condition_icon_and_text_view.dart';

class TimeAndCinemaConditionSectionView extends StatefulWidget {
  final List<dynamic>? configList;
  TimeAndCinemaConditionSectionView(this.configList);
  @override
  State<TimeAndCinemaConditionSectionView> createState() =>
      _TimeAndCinemaConditionSectionViewState();
}

class _TimeAndCinemaConditionSectionViewState
    extends State<TimeAndCinemaConditionSectionView> {
  @override
  void initState(){
    super.initState();
    debugPrint("Config==>${widget.configList?[0]['title']}");
  }
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(34, 34, 34, 1),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(74, 74, 74, 0.25),
            blurRadius: MARGIN_MEDIUM_X,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_x),
        child: Wrap(
          spacing: MARGIN_XXxLARGE,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: widget.configList?.map((config) => TimeAndCinemaConditionView(
            config['title'],
            "assets/images/dot1.png",
            config['color'],
          ),
          ).toList()?? [],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';

class DateView extends StatefulWidget {
  final List<Map<String, dynamic>> dateData;
  // // final Object DateOB;
  //late final int index;
  //  //final Function(int) searchIndex;
  DateView(
    this.dateData,
  );

  @override
  State<DateView> createState() => _DateViewState();
}

class _DateViewState extends State<DateView> {
  String isSelectedItem = dateData.elementAt(0)['dayNumber'];

  @override
  Widget build(BuildContext context) {
    return Container(
     // margin: EdgeInsets.zero,
     // padding: const EdgeInsets.only(left: MARGIN_MEDIUM_X),
      height: DATE_VIEW_SECTION_HEIGHT,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 7,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => {
                setState(() {
                  isSelectedItem =
                      widget.dateData.elementAt(index)['dayNumber'];
                }),
              },
              child: Stack(
                  children: [
                Container(
                  width: DATE_VIEW_WIDTH,
                  margin: const EdgeInsets.only(right: MARGIN_MEDIUM_3,left: MARGIN_MEDIUM_X),
                  padding: const EdgeInsets.only(top: MARGIN_SMALL_Lx,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                    color: isSelectedItem ==
                            widget.dateData.elementAt(index)['dayNumber']
                        ? PRIMARY_COLOR_1
                        : DATE_VIEW_BACKGROUND_COLOR,
                      boxShadow:[
                        BoxShadow(
                          color: isSelectedItem ==
                              widget.dateData.elementAt(index)['dayNumber']
                              ? PRIMARY_COLOR_1
                              : DATE_VIEW_BACKGROUND_COLOR,
                          blurRadius: 2,
                          offset: const Offset(0,0),
                        )
                      ]

                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: MARGIN_MEDIUM_3LX,
                          height: MARGIN_SMALL_L,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(MARGIN_SMALL_L),
                            color: PAGE_BACKGROUND_COLOR,
                          ),
                        ),
                      ),
                      const SizedBox(height: MARGIN_MEDIUM_x),
                      Text(
                        "${widget.dateData.elementAt(index)['dayText']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: TEXT_REGULAR,
                            color: Colors.black),
                      ),
                      const SizedBox(height: MARGIN_SMALL_LX),
                      Text(
                        "${widget.dateData.elementAt(index)['month']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: TEXT_REGULAR,
                            color: Colors.black),
                      ),
                      const SizedBox(height: MARGIN_SMALL_LX),
                      Text(
                        "${widget.dateData.elementAt(index)['dayNumber']}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: TEXT_REGULAR,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MARGIN_XXXlLLARGE,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.zero,
                        width: MARGIN_MEDIUM_3LX,
                        height: MARGIN_MEDIUM_X,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: PAGE_BACKGROUND_COLOR,
                        ),
                      ),
                      const SizedBox(width: 46),
                      Container(
                        margin: EdgeInsets.zero,
                        width: MARGIN_MEDIUM_3LX,
                        height: MARGIN_MEDIUM_X,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: PAGE_BACKGROUND_COLOR,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          }),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/vos/date_view_data_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';

class DateView extends StatefulWidget {
  final Function(String) onTapDate;

  DateView(this.onTapDate);

  @override
  State<DateView> createState() => _DateViewState();
}

class _DateViewState extends State<DateView> {
  String isSelectedItem = DateFormat('d').format(DateTime.now());
  String today = DateFormat('d').format(DateTime.now());
  String tomorrow =
      DateFormat('d').format(DateTime.now().add(Duration(days: 1)));

  List<DateViewVO> dates=[];
  @override
  void initState(){
    super.initState();
    ///Adding Dates
    for(int i=0;i<14;i++) {
      DateTime days = DateTime.now().add(Duration(days: i));
      String d = DateFormat('yyyy-MM-dd').format(days);
      DateViewVO dateViewVO=DateViewVO(d, false);
      dates.insert(i,dateViewVO);
    }
    dates[0].isSelected=true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      // margin: EdgeInsets.zero,
      // padding: const EdgeInsets.only(left: MARGIN_MEDIUM_X),
      height: DATE_VIEW_SECTION_HEIGHT,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: dates.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => {
              //isSelectedItem = widget.dates[index].date?? "",
                setState(() {

                  for(int i=0;i<dates.length;i++){
                    if(dates[index].date==dates[i].date){
                      dates[i].isSelected=true;
                    }else{
                      dates[i].isSelected=false;
                    }
                  }
                  //debugPrint(dates[index].date.toString());
                  widget.onTapDate(dates[index].date?? "");

                  //debugPrint(widget.dd[index].isSelected.toString());
                }),
              },
              child: Stack(children: [
                Container(
                  width: DATE_VIEW_WIDTH,
                  margin: const EdgeInsets.only(
                      right: MARGIN_MEDIUM_3, left: MARGIN_MEDIUM_X),
                  padding: const EdgeInsets.only(
                    top: MARGIN_SMALL_Lx,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                      color: (dates[index].isSelected?? true)
                          ? PRIMARY_COLOR_1
                          : DATE_VIEW_BACKGROUND_COLOR,
                      boxShadow: [
                        BoxShadow(
                          color: (dates[index].isSelected?? true)
                              ? PRIMARY_COLOR_1
                              : DATE_VIEW_BACKGROUND_COLOR,
                          blurRadius: 2,
                          offset: const Offset(0, 0),
                        )
                      ]),
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
                        (DateFormat('d').format(
                                    DateTime.parse(dates[index].date?? "")) ==
                                today)
                            ? "Today"
                            : (DateFormat('d').format(
                                        DateTime.parse(dates[index].date?? "")) ==
                                    tomorrow)
                                ? "Tomorrow"
                                : DateFormat('EE').format(
                                    DateTime.parse(dates[index].date?? "")),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: TEXT_REGULAR,
                            color: Colors.black),
                      ),
                      const SizedBox(height: MARGIN_SMALL_LX),
                      Text(
                        DateFormat('MMM')
                            .format(DateTime.parse(dates[index].date?? "")),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: TEXT_REGULAR,
                            color: Colors.black),
                      ),
                      const SizedBox(height: MARGIN_SMALL_LX),
                      Text(
                        DateFormat('d')
                            .format(DateTime.parse(dates[index].date?? "")),
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

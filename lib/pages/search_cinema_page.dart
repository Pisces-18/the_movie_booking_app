import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/cinema_expansion_view.dart';
import '../widgets/drop_down_list_view.dart';
import 'choose_seat_page.dart';
import 'cinema_info_page.dart';

class SearchCinemaPage extends StatelessWidget {


  String facilitiesDropDownValue = facilityDropDownItem[0];

  String formatDropdownValue = formatDropDownItem[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: APPBAR_COLOR,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: MARGIN_MEDIUM_3LX),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: MARGIN_xXLARGE,
            ),
          ),
        ),
        title: const TextField(
          cursorColor: Colors.white,
          style: TextStyle(
            color: DASH_COLOR_2,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              size: MARGIN_MEDIUM_3LX,
              color: Colors.white,
            ),
            hintText: SEARCH_CINEMA_HINT_TEXT,
            hintStyle: TextStyle(color: DASH_COLOR_2),
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: MARGIN_MEDIUM_3LX),
            child: Icon(
              Icons.filter_list_alt,
              color: PRIMARY_COLOR_1,
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 1,
        padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_3LX, vertical: MARGIN_MEDIUM),
        color: PAGE_BACKGROUND_COLOR,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CinemaSearchTypeView(
                  facilitiesDropDownValue, facilityDropDownItem, formatDropdownValue, formatDropDownItem),
              const SizedBox(height: MARGIN_xXLARGE),
              PriceRangeSectionView(),
              const SizedBox(height: MARGIN_xXLARGE),
              TimeRangeSectionView(),
              const SizedBox(height: MARGIN_XXXlLARGE),
              Column(
                  children: cinemaList
                      .map(
                        (name) => CinemaExpansionView(
                            name,
                            () => _navigateToCinemaInfoPage(context),
                            () => _navigateToChooseSeatPage(context),timeAndAvailableSeatData),
                      )
                      .toList()),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToCinemaInfoPage(BuildContext context) =>
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CinemaInfoPage()));

  Future<dynamic> _navigateToChooseSeatPage(BuildContext context) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChooseSeatPage()));
  }
}

class TimeRangeSectionView extends StatefulWidget {
  @override
  State<TimeRangeSectionView> createState() => TimeRangeSectionViewState();
}

class TimeRangeSectionViewState extends State<TimeRangeSectionView> {
  RangeValues _currentRangeValues = const RangeValues(8, 12);
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
          children: const [
            Text(
              "8am",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: TEXT_REGULAR,
                color: SMS_CODE_COLOR,
              ),
            ),
            Spacer(),
            Text(
              "12pm",
              style: TextStyle(
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
          child: RangeSlider(
            values: _currentRangeValues,
            min: 8,
            max: 12,
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
          ),
        ),
      ],
    );
  }
}

class CinemaSearchTypeView extends StatelessWidget {
  CinemaSearchTypeView(
      this.dropdownValue,
      this.facilityList,
      this.dropdownValue1,
      this.formatList,
      );

  final String dropdownValue;
  final List<String> facilityList;
  final String dropdownValue1;
  final List<String> formatList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropDownListView(dropdownValue, facilityList),
        const SizedBox(width: MARGIN_MEDIUM_X),
        DropDownListView(dropdownValue1, formatList),
      ],
    );
  }
}

class PriceRangeSectionView extends StatefulWidget {
  @override
  State<PriceRangeSectionView> createState() => _PriceRangeSectionViewState();
}

class _PriceRangeSectionViewState extends State<PriceRangeSectionView> {
  RangeValues _currentRangeValues = const RangeValues(3500, 23000);
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
          children: const [
            Text(
              "3500Ks",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: TEXT_REGULAR,
                color: SMS_CODE_COLOR,
              ),
            ),
            Spacer(),
            Text(
              "29500Ks",
              style: TextStyle(
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
          child: RangeSlider(
            values: _currentRangeValues,
            min: 3500,
            max: 29500,
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
          ),
        ),
      ],
    );
  }
}



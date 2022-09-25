import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/models/data_model.dart';
import '../data/models/data_model_impl.dart';
import '../data/vos/cinema_and_show_time_slots_vo.dart';
import '../data/vos/cinema_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/cinema_expansion_view.dart';
import '../widgets/drop_down_list_view.dart';
import 'choose_seat_page.dart';
import 'cinema_info_page.dart';

class SearchCinemaPage extends StatefulWidget {
 final String location;
 SearchCinemaPage(this.location);

  @override
  State<SearchCinemaPage> createState() => _SearchCinemaPageState();
}

class _SearchCinemaPageState extends State<SearchCinemaPage> {
  String facilitiesDropDownValue = facilityDropDownItem[0];

  String formatDropdownValue = formatDropDownItem[0];
  DataModel dDataModel = DataModelImpl();
  List<CinemaVO>? cinemaList;
  List<CinemaAndShowTimeSlotsVO>? cinemaTimeSotsList;
  String? date;
  @override
  void initState() {
    super.initState();
    DateTime.now();
    Duration(days: 14);

    dDataModel
        .getCinemaAndShowTimeByDate(
        DateFormat('yyyy-MM-dd').format(DateTime.now()))
        ?.then((timeSlots) {
      setState(() {
        cinemaList = DataModelImpl().mCinemaRepository;
        cinemaTimeSotsList=timeSlots;
        debugPrint("Cinema Choose ${DataModelImpl().test}");
        debugPrint(DataModelImpl().mCinemaRepository?[0].name.toString());
        //debugPrint(cinemaList?[0].timeslots?[0].startTime.toString());
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
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
        //height: MediaQuery.of(context).size.height / 1,

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
              (cinemaList != null)
                  ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cinemaList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CinemaExpansionView((location,cinema) => _navigateToCinemaInfoPage(
                        context, location,cinema), (cinemaDayTimeSlot) =>(){}, cinemaTimeSotsList?[index].timeslots, widget.location, cinemaList?[index],DataModelImpl().mConfigRepository);
                  })
                  : const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<dynamic> _navigateToCinemaInfoPage(
      BuildContext context, String location,CinemaVO? cinema) =>
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CinemaInfoPage(location,cinema)));
}

class TimeRangeSectionView extends StatefulWidget {
  @override
  State<TimeRangeSectionView> createState() => TimeRangeSectionViewState();
}

class TimeRangeSectionViewState extends State<TimeRangeSectionView> {
  RangeValues _currentRangeValues = const RangeValues(8, 12);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2),
      child: Column(
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
      ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM),
      child: Row(
        children: [
          DropDownListView(dropdownValue, facilityList),
          const SizedBox(width: MARGIN_MEDIUM_X),
          DropDownListView(dropdownValue1, formatList),
        ],
      ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2),
      child: Column(
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
      ),
    );
  }
}



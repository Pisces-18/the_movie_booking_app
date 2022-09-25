import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_booking_app/pages/choose_seat_page.dart';
import 'package:the_movie_booking_app/pages/cinema_info_page.dart';
import 'package:the_movie_booking_app/pages/search_cinema_page.dart';
import 'package:the_movie_booking_app/resources/germs.dart';
import 'package:the_movie_booking_app/viewers/cinema_list_view.dart';

import '../data/models/data_model.dart';
import '../data/models/data_model_impl.dart';
import '../data/vos/cinema_and_show_time_slots_vo.dart';
import '../data/vos/cinema_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewers/cinema_expansion_view.dart';
import '../viewers/cinema_movie_type_section_view.dart';
import '../viewers/date_view.dart';
import '../viewers/time_and_cinema_condition_section_view.dart';
import '../widgets/bottom_navigation_bar_view.dart';

class CinemaPage extends StatefulWidget {
  final String location;
  CinemaPage(this.location);

  @override
  State<CinemaPage> createState() => _CinemaPageState();
}

class _CinemaPageState extends State<CinemaPage> {
  DataModel dDataModel = DataModelImpl();
  List<CinemaVO>? cinemaList;
  List<CinemaAndShowTimeSlotsVO>? cinemaTimeSotsList;
  List<String> dates=[];
  String? date;
  @override
  void initState() {
    super.initState();
    ///Adding Dates

    for(int i=0;i<14;i++) {
      DateTime days = DateTime.now().add(Duration(days: i));
      String d = DateFormat('yyyy-MM-dd').format(days);
      dates.add(d);

    }

    dDataModel
        .getCinemaAndShowTimeByDate("2022-09-26")
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
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: APPBAR_COLOR,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: MARGIN_MEDIUM_3LX,
            ),
            child: GestureDetector(
                onTap: () => _navigateToSearchCinemaPage(context,widget.location),
                child: const Icon(
                  Icons.search,
                )),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DateView(dates, (d) {
                setState(() {
                  //date=DateTime.now().toString();
                  //date = DateFormat("yyyy-MM-dd")
                     // .format(DateFormat('MMM yyy d').parse(d?? DateTime.now().toString()));
                  dDataModel
                      .getCinemaAndShowTimeByDate("2022-09-26")
                      ?.then((timeSlotsList) {
                    setState(() {
                      cinemaTimeSotsList = timeSlotsList;
                      // debugPrint(
                      //cinemaList?[0].timeslots?[0].startTime.toString());
                    });
                  }).catchError((error) {
                    debugPrint(error.toString());
                  });
                });
              }),
              const SizedBox(height: MARGIN_xXLARGE),
              MovieTypeSectionView(movieTypeList: movieTypeList),
              const SizedBox(height: MARGIN_XxLARGE),
              TimeAndCinemaConditionSectionView(DataModelImpl().mConfigRepository),
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
      // body: Container(
      //   child: ListView.builder(
      //       itemCount: cinemaList.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         return CinemaListView(cinemaList[index],
      //             (location) => _navigateToCinemaInfoPage(context, location));
      //       }),
      // ),
      //
    );
  }

  Future<dynamic> _navigateToCinemaInfoPage(
      BuildContext context, String location,CinemaVO? cinema) =>
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CinemaInfoPage(location,cinema)));

  Future<dynamic> _navigateToSearchCinemaPage(BuildContext context, location) {
    return Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context,) =>
                          SearchCinemaPage(location)));
  }
}

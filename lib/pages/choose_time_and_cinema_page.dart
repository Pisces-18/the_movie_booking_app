import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_booking_app/data/models/data_model.dart';
import 'package:the_movie_booking_app/pages/choose_seat_page.dart';
import '../data/models/data_model_impl.dart';
import '../data/vos/cinema_and_show_time_slots_vo.dart';
import '../data/vos/cinema_vo.dart';
import '../data/vos/config_vo.dart';
import '../data/vos/time_slot_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../viewers/cinema_expansion_view.dart';
import '../viewers/cinema_movie_type_section_view.dart';
import '../viewers/date_view.dart';
import '../viewers/time_and_cinema_condition_section_view.dart';
import 'cinema_info_page.dart';

class ChooseTimeAndCinemaPage extends StatefulWidget {
  final String location;
  final int movieId;

  ChooseTimeAndCinemaPage(this.location, this.movieId);
  @override
  State<ChooseTimeAndCinemaPage> createState() =>
      _ChooseTimeAndCinemaPageState();
}

class _ChooseTimeAndCinemaPageState extends State<ChooseTimeAndCinemaPage> {
  DataModel dDataModel = DataModelImpl();
  List<CinemaVO>? cinemaList;
  List<CinemaAndShowTimeSlotsVO>? cinemaTimeSotsList;
  // String date=DateFormat("yyyy-MM-dd").format(DateFormat('MMM yyy d').parse('Sep 2022 11'));
  List<String> dates=[];
  String? date;
  @override
  void initState() {
    super.initState();

    ///Adding Dates
    for(int i=0;i<14;i++) {
      DateTime days = DateTime.now().add(Duration(days: i));
      String d = DateFormat('yyyy-MM-dd').format(days);
      // DateTime d=DateFormat('yyyy-MM-dd').parse(DateTime.now().toString()).add(Duration(days: 1));
      // debugPrint("Days===>$days");
      // debugPrint("Formatted Days===>$d");
      dates.add(d);
      //debugPrint("Looping Dates===>$dates");
    }
    // debugPrint(DateFormat('EE').format(DateTime.now()));
    // debugPrint(DateFormat('MM').format(DateTime.now()));
    // debugPrint(DateFormat('d').format(DateTime.now()));
    // debugPrint("Outside Dates===>$dates");

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
    debugPrint("Configuration===>${DataModelImpl().mConfigRepository}");
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: APPBAR_COLOR,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: MARGIN_xXLARGE,
          ),
        ),
        actions: [
          const Icon(
            Icons.near_me,
            size: MARGIN_MEDIUM_2,
          ),
          const SizedBox(width: MARGIN_MEDIUM),
          Center(
            child: Text(
              widget.location,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: TEXT_REGULAR_2X,
                  fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(width: MARGIN_LARGE),
          const Icon(
            Icons.search,
            size: MARGIN_MEDIUM_3LX,
          ),
          const SizedBox(width: MARGIN_xXLARGE),
          const Padding(
            padding: EdgeInsets.only(right: MARGIN_MEDIUM_3LX),
            child: Icon(
              Icons.filter_list_alt,
              size: MARGIN_MEDIUM_3LX,
            ),
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
           // mainAxisSize: MainAxisSize.min,
            children: [
              DateView(dates, (d) {
                setState(() {

                  debugPrint("Date===>$d");
                  dDataModel
                      .getCinemaAndShowTimeByDate(d)
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
                              context, location,cinema), (cinemaDayTimeSlot) => _navigateToChooseSeatPage(
                                  context, widget.location,cinemaDayTimeSlot,cinemaList?[index],widget.movieId,date?? DateTime.now().toString()), cinemaTimeSotsList?[index].timeslots, widget.location, cinemaList?[index],DataModelImpl().mConfigRepository);
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

  Future<dynamic> _navigateToChooseSeatPage(
      BuildContext context, String location, TimeSlotVO? cinemaDayTimeSlot, CinemaVO? cinema, int movieId,String? date) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChooseSeatPage(
                  location: location, cinema: cinema, movieId: movieId, date: date?? DateTime.now().toString(),  cinemaDayTimeSlot: cinemaDayTimeSlot,
                )));
  }
}









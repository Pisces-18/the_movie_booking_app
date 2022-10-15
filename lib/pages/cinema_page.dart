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
import '../data/vos/cinema_time_slots_status_vo.dart';
import '../data/vos/cinema_vo.dart';
import '../data/vos/date_view_data_vo.dart';
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
  List<CinemaTimeSlotsStatusVO>? cinemaTimeSlotsStatus;
  List<CinemaVO>? cinemaList;
  List<CinemaAndShowTimeSlotsVO>? cinemaTimeSotsList;
  String? token;
  String? date;



  @override
  void initState() {
    super.initState();

    ///Get User token from database
    dDataModel.signInWithPhoneDatabase()?.then((user){
      setState((){
        ///Time Slots from network
        dDataModel
            .getCinemaAndShowTimeByDate(user.token?? "",DateFormat('yyyy-MM-dd').format(DateTime.now()))
            ?.then((timeSlots) {
          setState(() {

            cinemaTimeSotsList=timeSlots;
            //debugPrint(cinemaList?[0].timeslots?[0].startTime.toString());
          });
        }).catchError((error) {
          debugPrint(error.toString());
        });
        token=user.token;
        debugPrint("Location Token==>$token");
      });
    }).catchError((error){
      debugPrint("User Database Error ===> $error");
    });

    ///TimeSlotsStatus from Database
    dDataModel.getCinemaTimeSlotsStatusFromDatabase()?.then((timeSlots) {
      setState((){
        cinemaTimeSlotsStatus=timeSlots;
      });
    }).catchError((error){
      debugPrint("TimeSlotsStatus===>$error}");
    });

    ///Cinemas fom Database
    dDataModel.getCinemasFromDatabase()?.then((cinemas){
      setState((){
        cinemaList=cinemas;
      });
    }).catchError((error){
      debugPrint("Cinemas Database Errors==>$error");
    });
    ///Times Slots from Database
    dDataModel.getCinemaAndShowTimeByDateFromDatabase(DateFormat('yyyy-MM-dd').format(DateTime.now()))?.then((times) {
      setState((){
        debugPrint("Time Slots from Database ===>${times.date}");
        cinemaTimeSotsList=times.data;
      });
    }).catchError((error){
      debugPrint("Time Slots Database error$error");
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
              DateView((d) {
                setState(() {

                  dDataModel
                      .getCinemaAndShowTimeByDate(token?? "",d)
                      ?.then((timeSlotsList) {
                    setState(() {
                      cinemaTimeSotsList = timeSlotsList;

                    });
                  }).catchError((error) {
                    debugPrint(error.toString());
                  });

                  ///Time Slots from Database
                  dDataModel.getCinemaAndShowTimeByDateFromDatabase(d)?.then((times) {
                    setState((){
                      debugPrint("Time Slots from Database ===>${times.date}");
                      cinemaTimeSotsList=times.data;
                    });
                  }).catchError((error){
                    debugPrint("Time Slots Database error$error");
                  });
                });


              }),
              const SizedBox(height: MARGIN_xXLARGE),
              MovieTypeSectionView(movieTypeList: movieTypeList),
              const SizedBox(height: MARGIN_XxLARGE),
              TimeAndCinemaConditionSectionView(cinemaTimeSlotsStatus),
              (cinemaList != null)
                  ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cinemaList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CinemaExpansionView((location,cinemaId) => _navigateToCinemaInfoPage(
                        context, location,cinemaId), (cinemaDayTimeSlot) =>(){}, cinemaTimeSotsList?[index].timeslots, widget.location, cinemaList?[index],cinemaTimeSlotsStatus);
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
      BuildContext context, String location,int cinemaId) =>
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CinemaInfoPage(location,cinemaId)));

  Future<dynamic> _navigateToSearchCinemaPage(BuildContext context, location) {
    return Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context,) =>
                          SearchCinemaPage(location)));
  }
}

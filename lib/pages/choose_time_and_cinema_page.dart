import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_booking_app/data/models/data_model.dart';
import 'package:the_movie_booking_app/pages/choose_seat_page.dart';
import '../data/models/data_model_impl.dart';
import '../data/vos/cinema_and_show_time_slots_vo.dart';
import '../data/vos/cinema_time_slots_status_vo.dart';
import '../data/vos/cinema_vo.dart';
import '../data/vos/config_vo.dart';
import '../data/vos/date_view_data_vo.dart';
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
  List<CinemaTimeSlotsStatusVO>? cinemaTimeSlotsStatus;
  List<CinemaVO>? cinemaList;
  List<CinemaAndShowTimeSlotsVO>? cinemaTimeSotsList;
  String? token;

  // String date=DateFormat("yyyy-MM-dd").format(DateFormat('MMM yyy d').parse('Sep 2022 11'));

  String? date;
  @override
  void initState() {
    super.initState();

      ///Get User token from database
      dDataModel.signInWithPhoneDatabase()?.then((user){
        setState((){
          ///Time Slots from Network
          dDataModel
              .getCinemaAndShowTimeByDate(user.token?? "",DateFormat('yyyy-MM-dd').format(DateTime.now()))
              ?.then((timeSlotsList) {

            setState((){
              cinemaTimeSotsList = timeSlotsList;
              debugPrint("TimeSlotsStatus from network==>${cinemaTimeSotsList?[0].timeslots}");
            });

          }).catchError((error) {
            debugPrint("Time SLots error==>$error");
          });

          token=user.token;
          debugPrint("Location Token==>$token");

        });

      }).catchError((error){
        debugPrint("User Database Error ===> $error");
      });

      ///TimeSlotsStatus from Database
      dDataModel.getCinemaTimeSlotsStatusFromDatabase()?.then((timeSlotsStatus) {
        setState((){
          cinemaTimeSlotsStatus=timeSlotsStatus;
          debugPrint("TimeSlotsStatus from database==>${cinemaTimeSlotsStatus?[0].title}");
        });
      }).catchError((error){
        debugPrint("TimeSlotsStatus===>$error}");
      });

      ///Cinemas from Database
      dDataModel.getCinemasFromDatabase()?.then((cinemas){
        setState((){
          cinemaList=cinemas;
        });
      }).catchError((error){
        debugPrint("Cinemas Database Errors==>$error");
      });

     String dd=DateFormat('yyyy-MM-dd').format(DateTime.now());
    ///Times Slots from Database
    dDataModel.getCinemaAndShowTimeByDateFromDatabase(dd)?.then((times) {
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
              DateView((d) {
                setState(() {
                  ///Time Slots From Network
                  dDataModel
                      .getCinemaAndShowTimeByDate(token?? "",d)
                      ?.then((timeSlotsList) {
                    setState(() {
                      cinemaTimeSotsList = timeSlotsList;
                      date=d;
                      debugPrint("TimeSlotsStatus from network==>${cinemaTimeSotsList?[0].timeslots}");
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
                              context, location,cinemaId), (cinemaDayTimeSlot) => _navigateToChooseSeatPage(
                                  context, widget.location,cinemaDayTimeSlot,cinemaList?[index],widget.movieId,date?? DateTime.now().toString()), cinemaTimeSotsList?[index].timeslots, widget.location, cinemaList?[index],cinemaTimeSlotsStatus);
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
          BuildContext context, String location,int cinemaId) =>
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CinemaInfoPage(location,cinemaId)));

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









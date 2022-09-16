import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_booking_app/data/models/data_model.dart';
import 'package:the_movie_booking_app/pages/choose_seat_page.dart';
import '../data/models/data_model_impl.dart';
import '../data/vos/cinema_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../viewers/cinema_expansion_view.dart';
import '../viewers/date_view.dart';
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
  final List<String> movieTypeList = ["2D", "3D", "3D IMAX", "3D DBOX"];
  DataModel mMovieModel = DataModelImpl();
  List<CinemaVO>? cinemaList;
  // String date=DateFormat("yyyy-MM-dd").format(DateFormat('MMM yyy d').parse('Sep 2022 11'));

  String? date;
  @override
  void initState() {
    super.initState();
    mMovieModel
        .getCinemaDayTimeSlots(
            widget.movieId, DateFormat('yyyy-MM-dd').format(DateTime.now()))
        ?.then((cinemaData) {
      setState(() {
        cinemaList = cinemaData;
        debugPrint(cinemaList?[0].timeslots?[0].startTime.toString());
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

// List<String> cinemaNameList=cinemaList?;

  // DateTime date=DateFormat('MMM yyy d').parse(rawDate??"");
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
            children: [
              DateView(dateData, (d) {
                setState(() {
                  //date=DateTime.now().toString();
                  date = DateFormat("yyyy-MM-dd")
                      .format(DateFormat('MMM yyy d').parse(d?? DateTime.now().toString()));
                  mMovieModel
                      .getCinemaDayTimeSlots(widget.movieId, date ?? "")
                      ?.then((cinemaData) {
                    setState(() {
                      cinemaList = cinemaData;
                      debugPrint(
                          cinemaList?[0].timeslots?[0].startTime.toString());
                    });
                  }).catchError((error) {
                    debugPrint(error.toString());
                  });
                });
              }),
              //DateFormat("yyyy-MM-dd").format(DateFormat('MMM yyy d').parse(date)).toString()
              // Text(
              //   DateFormat('yyyy-MM-dd').format(DateTime.now()),
              //   style: TextStyle(color: Colors.white),
              // ),
              const SizedBox(height: MARGIN_xXLARGE),
              MovieTypeSectionView(movieTypeList: movieTypeList),
              const SizedBox(height: MARGIN_XxLARGE),
              TimeAndCinemaConditionSectionView(),
              // Container(
              //   child: GridView.builder(
              //     shrinkWrap: true,
              //       physics: NeverScrollableScrollPhysics(),
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 1,
              //         mainAxisExtent: 140,
              //       ),
              //       itemCount: cinemaList?.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return CinemaExpansionView(
              //             cinemaList?[index].cinema ?? "",
              //             (location) =>
              //                 _navigateToCinemaInfoPage(context, location),
              //             (location) =>
              //                 _navigateToChooseSeatPage(context, location),
              //             cinemaList?[index].timeslots ?? [],
              //             widget.location);
              //       }),
              // ),

              // Container(
              //   height: 1000,
              //   child: (cinemaList != null)
              //       ? ListView.builder(
              //           physics: ScrollPhysics(),
              //           shrinkWrap: true,
              //           itemCount: cinemaList?.length,
              //           itemBuilder: (BuildContext context, int index) {
              //             return CinemaExpansionView(
              //                 cinemaList?[index].cinema ?? "",
              //                 (location) => _navigateToCinemaInfoPage(
              //                     context, location,),
              //                 (cinemaDayTimeSlotId,startTime) => _navigateToChooseSeatPage(
              //                     context, widget.location,cinemaDayTimeSlotId,startTime,cinemaList?[index],widget.movieId,date?? DateTime.now().toString()),
              //                 cinemaList?[index].timeslots ?? [],
              //                 widget.location);
              //           })
              //       : const Center(
              //           child: CircularProgressIndicator(),
              //         ),
              // ),
              (cinemaList !=null )?Column(
                children: cinemaList?.map((cinema) => CinemaExpansionView(cinema.cinema, (location,cinemaName) => _navigateToCinemaInfoPage(
                  context, location,cinemaName),(cinemaDayTimeSlotId,startTime) => _navigateToChooseSeatPage(
                    context, widget.location,cinemaDayTimeSlotId,startTime,cinema,widget.movieId,date?? DateTime.now().toString()),
                    cinema.timeslots ?? [],
                    widget.location)).toList()?? [],
              ):const Center(
                child: CircularProgressIndicator(),
              ),
              // Column(
              //    children: cinemaList
              //        ?.map(
              //          (name) => CinemaExpansionView(
              //              cinemaList?.first.cinema?? "",
              //              (location) => _navigateToCinemaInfoPage(context,location),
              //              (location) => _navigateToChooseSeatPage(context,location),cinemaList?[0].timeslots?? [],widget.location),
              //        )
              //        .toList()?? [],)
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToCinemaInfoPage(
          BuildContext context, String location,String cinemaName) =>
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CinemaInfoPage(location,cinemaName)));

  Future<dynamic> _navigateToChooseSeatPage(
      BuildContext context, String location, int cinemaDayTimeSlotId,String startTime, CinemaVO? cinema, int movieId,String? date) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChooseSeatPage(
                  location: location, cinemaDayTimeSlotId: cinemaDayTimeSlotId, cinema: cinema, movieId: movieId, date: date?? DateTime.now().toString(), startTime: startTime,
                )));
  }
}

class TimeAndCinemaConditionSectionView extends StatefulWidget {
  @override
  State<TimeAndCinemaConditionSectionView> createState() =>
      _TimeAndCinemaConditionSectionViewState();
}

class _TimeAndCinemaConditionSectionViewState
    extends State<TimeAndCinemaConditionSectionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Row(
          children: [
            TimeAndCinemaConditionView(
              "Availible",
              "assets/images/dot1.png",
              AVAILABLE_COLOR,
            ),
            const SizedBox(width: MARGIN_XXxLARGE),
            TimeAndCinemaConditionView(
              "Filling Fast",
              "assets/images/dot2.png",
              FILLING_FAST_COLOR,
            ),
            const SizedBox(width: MARGIN_XXxLARGE),
            TimeAndCinemaConditionView(
              "Almost Full",
              "assets/images/dot3.png",
              ALMOST_FULL_COLOR,
            ),
          ],
        ),
      ),
    );
  }
}

class TimeAndCinemaConditionView extends StatefulWidget {
  final String text;
  final String image;
  final Color textColor;
  TimeAndCinemaConditionView(this.text, this.image, this.textColor);

  @override
  State<TimeAndCinemaConditionView> createState() =>
      _TimeAndCinemaConditionViewState();
}

class _TimeAndCinemaConditionViewState
    extends State<TimeAndCinemaConditionView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(widget.image),
        SizedBox(width: MARGIN_MEDIUM_X),
        Text(
          widget.text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: TEXT_REGULAR_2X,
            color: widget.textColor,
          ),
        )
      ],
    );
  }
}

class MovieTypeSectionView extends StatefulWidget {
  const MovieTypeSectionView({
    Key? key,
    required this.movieTypeList,
  }) : super(key: key);

  final List<String> movieTypeList;

  @override
  State<MovieTypeSectionView> createState() => _MovieTypeSectionViewState();
}

class _MovieTypeSectionViewState extends State<MovieTypeSectionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Wrap(
        children: widget.movieTypeList
            .map((type) => MovieTypeChipView(type))
            .toList(),
      ),
    );
  }
}

class MovieTypeChipView extends StatefulWidget {
  final String type;
  MovieTypeChipView(this.type);

  @override
  State<MovieTypeChipView> createState() => _MovieTypeChipViewState();
}

class _MovieTypeChipViewState extends State<MovieTypeChipView> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Chip(
          padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_CARD_MEDIUM_2L, vertical: MARGIN_SMALL_L),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MARGIN_SMALL_L),
          ),
          side: const BorderSide(
            width: 1,
            color: Colors.white,
          ),
          backgroundColor: BUTTON_TEXT_COLOR_NS,
          label: Text(
            widget.type,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: TEXT_REGULAR_2X,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: MARGIN_MEDIUM_3LX),
      ],
    );
  }
}

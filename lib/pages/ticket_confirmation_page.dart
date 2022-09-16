import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/pages/movie_page.dart';
import '../data/models/data_model.dart';
import '../data/models/data_model_impl.dart';
import '../data/vos/cinema_vo.dart';
import '../data/vos/movie_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/ticket_info_view.dart';

class TicketConfirmationPage extends StatefulWidget {
  //late Function onTapTicket;
  final String location;
  // final int movieId;
  // final CinemaVO? cinema;
  // final int cinemaDayTimeSlotId;
  // final String startTime;
  // final String date;
  // final String seatNo;
  // final List<Map<String,dynamic>> snackList;
  //TicketConfirmationPage(this.location,this.movieId,this.cinema,this.cinemaDayTimeSlotId,this.startTime,this.date,this.seatNo,this.snackList);
  TicketConfirmationPage(this.location);
  @override
  State<TicketConfirmationPage> createState() => _TicketConfirmationPageState();
}

class _TicketConfirmationPageState extends State<TicketConfirmationPage> {
  DataModel dDataModel = DataModelImpl();

  // CinemaVO? cinema;
  MovieVO? mMovie;
  int? movieId;
  CinemaVO? cinema;
  int? cinemaDayTimeSlotId;
  String? startTime;
  String? date;
  String? seatNo;
  List<Map<String, dynamic>>? snackList;

  @override
  void initState() {
    super.initState();

    ///Get Movie
    dDataModel.getMovieDetails(movieId?? 817451)?.then((movie) {
      setState(() {
        mMovie = movie;
        debugPrint(mMovie?.title.toString());
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
    debugPrint(cinema?.cinema.toString());
    debugPrint(cinemaDayTimeSlotId.toString());
    debugPrint(date);
    debugPrint(snackList.toString());
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PAGE_BACKGROUND_COLOR,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: APPBAR_COLOR,
          title: const Text(
            TICKET_CONFIRMATION_PAGE_TITLE,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: TEXT_REGULAR_3X,
                color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: (mMovie != null)
            ? Container(
                padding: const EdgeInsets.only(
                  top: MARGIN_xXLARGE,
                ),
                child: Column(
                  children: [
                    TicketInfoView(
                        () => this,
                        "$IMAGE_BASE_URL${mMovie?.posterPath}",
                        mMovie?.title ?? "",
                        cinema?.cinema ?? "",
                        seatNo?? "G8",
                        date?? DateTime.now().toString(),
                        startTime?? ""),
                    SizedBox(height: MediaQuery.of(context).size.height / 10),
                    QrAndPinView(),
                    SizedBox(height: MediaQuery.of(context).size.height / 12),
                    DoneButtonView(widget.location)
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class DoneButtonView extends StatelessWidget {
  final String location;
  DoneButtonView(this.location);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage(location))),
      style: TextButton.styleFrom(backgroundColor: PRIMARY_COLOR_1),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Text(
          TICKET_CONFIRMATION_BUTTON_TEXT,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: TEXT_REGULAR_3X,
              color: APPBAR_COLOR),
        ),
      ),
    );
  }
}

class QrAndPinView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/qrAndPin.png",
      width: QR_AND_PIN_WIDTH,
      height: QR_AND_PIN_HEIGHT,
    );
  }
}

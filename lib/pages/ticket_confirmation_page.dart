import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/check_out_vo.dart';
import 'package:the_movie_booking_app/data/vos/time_slot_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/pages/movie_page.dart';
import '../data/models/data_model.dart';
import '../data/models/data_model_impl.dart';
import '../data/vos/cinema_and_show_time_slots_vo.dart';
import '../data/vos/cinema_vo.dart';
import '../data/vos/movie_vo.dart';
import '../data/vos/snack_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/ticket_info_view.dart';

class TicketConfirmationPage extends StatefulWidget {
  //late Function onTapTicket;
  final String location;
  final CinemaVO? cinema;

  TicketConfirmationPage(this.location,this.cinema);
  //TicketConfirmationPage(this.location);
  @override
  State<TicketConfirmationPage> createState() => _TicketConfirmationPageState();
}

class _TicketConfirmationPageState extends State<TicketConfirmationPage> {
  DataModel dDataModel = DataModelImpl();


  MovieVO? mMovie;
  List<SnackVO>? snackVO;
  CheckOutVO? checkoutData;

  @override
  void initState() {
    super.initState();

    // debugPrint(cinema?.name.toString());
    // debugPrint(cinemaDayTimeSlotId.toString());
    // debugPrint(date);
    // debugPrint(snackList.toString());
    // dDataModel.postCheckout("SSDK", widget.cinemaTimeSlot?.cinemaDayTimeslotsId?? 0, "G-6", widget.date, widget.movieId, widget.paymentId, [SnackVO(1, "Beverage", "", 1000, 123, "", 1, 2, 2000),SnackVO(1, "Beverage", "", 1000, 123, "", 1, 2, 2000)])?.then((checkout) {
    //   setState((){
    //     checkoutData=checkout;
    //     debugPrint("MovieId Id${checkoutData?.movieId}");
    //   });
    // }).catchError((error){
    //   debugPrint("Confirmation error$error");
    // });
    debugPrint("Movie Id ${DataModelImpl().mCheckOutRepository?.movieId}");
    checkoutData=DataModelImpl().mCheckOutRepository;
    ///Get Movie
    dDataModel.getMovieDetails(checkoutData?.movieId?? 0)?.then((movie) {
      setState(() {
        mMovie = movie;
        debugPrint(mMovie?.title.toString());
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

  }

  @override
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
                    TicketInfoView(mMovie,widget.cinema,checkoutData,()=>this),
                    SizedBox(height: MediaQuery.of(context).size.height / 10),
                    QrAndPinView(checkoutData?.qrCode?.substring(7)?? ""),
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

class QrAndPinView extends StatefulWidget {
  final String image;
  QrAndPinView(this.image);
  @override
  State<QrAndPinView> createState() => _QrAndPinViewState();
}

class _QrAndPinViewState extends State<QrAndPinView> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/qrAndPin.png",
      width: QR_AND_PIN_WIDTH,
      height: QR_AND_PIN_HEIGHT,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/data_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/time_slot_vo.dart';
import 'package:the_movie_booking_app/pages/payment_page.dart';
import '../data/models/data_model.dart';
import '../data/vos/cinema_and_show_time_slots_vo.dart';
import '../data/vos/cinema_vo.dart';
import '../data/vos/movie_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/ticket_details_view.dart';

class TicketCheckOutPage extends StatefulWidget {
  final String location;
  final int movieId;
  final CinemaVO? cinema;
  final TimeSlotVO? cinemaDayTimeSlot;
  final String? date;
  final String seatNo;
  final List<SnackVO>? snackList;
  TicketCheckOutPage(
      this.location,
      this.movieId,
      this.cinema,
      this.cinemaDayTimeSlot,
      this.date,
      this.seatNo,
      this.snackList);

  @override
  State<TicketCheckOutPage> createState() => _TicketCheckOutPageState();
}

class _TicketCheckOutPageState extends State<TicketCheckOutPage> {
  DataModel dDataModel = DataModelImpl();

  // CinemaVO? cinema;
  MovieVO? mMovie;
  int totalAmount = 0;

  @override
  void initState() {
    super.initState();

    ///Get Movie
    dDataModel.getMovieDetails(widget.movieId)?.then((movie) {
      setState(() {
        mMovie = movie;
        debugPrint(mMovie?.title.toString());
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
    // debugPrint(widget.cinema?.cinema.toString());
    // debugPrint(widget.cinemaDayTimeSlotId.toString());
    // debugPrint(widget.date);
    // debugPrint(widget.snackList.toString());

    for (int i = 0; i < (widget.snackList?.length?? 0); i++) {
      totalAmount = (totalAmount +
              ((widget.snackList?[i].price?? 0) *
                  (widget.snackList?[i].quantity?? 0) *
                  1000))
          .toInt();
    }
    totalAmount = totalAmount + 500;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: APPBAR_COLOR,
        title: const Text(
          TICKET_CHECKOUT_PAGE_TITLE,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: TEXT_REGULAR_4X,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: MARGIN_xXLARGE,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          vertical: MARGIN_xXLARGE,
        ),
        color: APPBAR_COLOR,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TicketDetailsView(
                  "${mMovie?.title} (3D) (U/A)",
                  widget.cinema,
                  widget.date ?? DateTime.now().toString(),
                  widget.cinemaDayTimeSlot?.startTime?? "",
                  widget.snackList?? [],
                totalAmount,(canceledFood,total){
                    setState((){
                      totalAmount=total+500;
                    });
              }
              ),
              const SizedBox(height: MARGIN_XXXLARGE),
              ContinueButtonView(
                  (location) => _navigateToPaymentPage(context, location),
                  widget.location)
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToPaymentPage(
      BuildContext context, String location) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
            location,
            widget.movieId,
            widget.cinema,
            widget.cinemaDayTimeSlot,
            widget.date ?? DateTime.now().toString(),
            widget.seatNo,
            widget.snackList,
        totalAmount),
      ),
    );
  }
}

class ContinueButtonView extends StatelessWidget {
  final String location;
  final Function(String) onTapContinue;
  ContinueButtonView(this.onTapContinue, this.location);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTapContinue(location),
        child: Image.asset("assets/images/continueButton.png"));
  }
}

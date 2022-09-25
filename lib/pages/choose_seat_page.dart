import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/time_slot_vo.dart';
import 'package:the_movie_booking_app/pages/ticket_check_out_page.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';

import '../data/models/data_model.dart';
import '../data/models/data_model_impl.dart';
import '../data/vos/cinema_and_show_time_slots_vo.dart';
import '../data/vos/cinema_vo.dart';
import '../data/vos/seat_vo.dart';
import '../resources/colors.dart';
import '../viewers/buy_ticket_dialog_box-view.dart';
import 'food_and_beverage_all_page.dart';

class ChooseSeatPage extends StatefulWidget {
  final String location;
  final int movieId;
  final CinemaVO? cinema;
  final TimeSlotVO? cinemaDayTimeSlot;
  final String? date;
  const ChooseSeatPage(
      {Key? key,
      required this.location,
      required this.movieId,
      required this.cinema,
      required this.cinemaDayTimeSlot,required this.date})
      : super(key: key);

  @override
  State<ChooseSeatPage> createState() => _ChooseSeatPageState();
}

class _ChooseSeatPageState extends State<ChooseSeatPage> {
  DataModel mMovieModel = DataModelImpl();

  List<List<SeatVO>>? seatList;

  @override
  void initState() {
    super.initState();

    ///Get Movie Details

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_XXXXXLLARGE, vertical: MARGIN_MEDIUM_X),
        child: BuyTicketButtonView(widget.location,widget.movieId,widget.cinema,widget.cinemaDayTimeSlot, widget.date?? DateTime.now().toString(),"G5"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }
}

class BuyTicketButtonView extends StatefulWidget {
  final String location;
  final int movieId;
  final CinemaVO? cinema;
  final TimeSlotVO? cinemaDayTimeSlot;
  final String date;
  final String setNo;
  BuyTicketButtonView(this.location, this.movieId, this.cinema, this.cinemaDayTimeSlot, this.date,this.setNo);

  @override
  State<BuyTicketButtonView> createState() => _BuyTicketButtonViewState();
}

class _BuyTicketButtonViewState extends State<BuyTicketButtonView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return BuyTicketDialogBoxView(widget.location,widget.movieId,widget.cinema,widget.cinemaDayTimeSlot,widget.date,widget.setNo);
            },
          );
        },
        child: Image.asset("assets/images/buyTicketButton.png"));
  }
}

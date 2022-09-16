import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/ticket_check_out_page.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';

import '../data/vos/cinema_vo.dart';
import '../resources/colors.dart';
import '../viewers/buy_ticket_dialog_box-view.dart';
import 'food_and_beverage_all_page.dart';

class ChooseSeatPage extends StatefulWidget {
  final String location;
  final int movieId;
  final CinemaVO? cinema;
  final int cinemaDayTimeSlotId;
  final String startTime;
  final String? date;
  const ChooseSeatPage(
      {Key? key,
      required this.location,
      required this.movieId,
      required this.cinema,
      required this.cinemaDayTimeSlotId, required this.startTime, required this.date})
      : super(key: key);

  @override
  State<ChooseSeatPage> createState() => _ChooseSeatPageState();
}

class _ChooseSeatPageState extends State<ChooseSeatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_XXXXXLLARGE, vertical: MARGIN_MEDIUM_X),
        child: BuyTicketButtonView(widget.location,widget.movieId,widget.cinema,widget.cinemaDayTimeSlotId,widget.startTime,widget.date?? DateTime.now().toString(),"G8"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }
}

class BuyTicketButtonView extends StatefulWidget {
  final String location;
  final int movieId;
  final CinemaVO? cinema;
  final int cinemaDayTimeSlotId;
  final String startTime;
  final String date;
  final String setNo;
  BuyTicketButtonView(this.location, this.movieId, this.cinema, this.cinemaDayTimeSlotId, this.startTime,this.date,this.setNo);

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
              return BuyTicketDialogBoxView(widget.location,widget.movieId,widget.cinema,widget.cinemaDayTimeSlotId,widget.startTime,widget.date,widget.setNo);
            },
          );
        },
        child: Image.asset("assets/images/buyTicketButton.png"));
  }
}

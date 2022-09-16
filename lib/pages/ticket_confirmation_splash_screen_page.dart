import 'dart:async';
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/pages/ticket_confirmation_page.dart';
import '../data/vos/cinema_vo.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class TicketConfirmationSplashScreenPage extends StatefulWidget {
  //const TicketConfirmationSplashScreenPage({Key? key, required this.location, required this.movieId, required this.cinema, required this.cinemaDayTimeSlotId, required this.startTime, required this.date, required this.seatNo, required this.snackList}) : super(key: key);

  final String location;
  TicketConfirmationSplashScreenPage(this.location);
  // final int movieId;
  // final CinemaVO? cinema;
  // final int cinemaDayTimeSlotId;
  // final String startTime;
  // final String date;
  // final String seatNo;
  // final List<Map<String,dynamic>> snackList;
  @override
  State<TicketConfirmationSplashScreenPage> createState() =>
      _TicketConfirmationSplashScreenPageState();
}

class _TicketConfirmationSplashScreenPageState
    extends State<TicketConfirmationSplashScreenPage> {
  void initState() {//Future.delay
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TicketConfirmationPage(widget.location),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: TICKET_CONFIRMATION_SPLASH_SCREEN_HEIGHT,
        child: Stack(
          children: const [
            Positioned.fill(
              child: BallonImageView(),
            ),
            Align(
              alignment: Alignment.center,
              child: HomeCinemaImageView(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextView(),
            )
          ],
        ),
      ),
    );
  }
}

class TextView extends StatelessWidget {
  const TextView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          TICKET_CONFIRMATION_TEXT1,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w800,
            fontSize: TEXT_REGULAR_3X,
            color: Colors.white,
          ),
        ),
        Text(
          TICKET_CONFIRMATION_TEXT2,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w800,
            fontSize: TEXT_REGULAR_3X,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

class HomeCinemaImageView extends StatelessWidget {
  const HomeCinemaImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/homeCinema.png",
    );
  }
}

class BallonImageView extends StatelessWidget {
  const BallonImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/ballon.png",
      height: BALLON_IMAGE_HEIGHT,
    );
  }
}

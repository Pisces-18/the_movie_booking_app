import 'package:flutter/material.dart';
import '../data/vos/cinema_vo.dart';
import '../pages/food_and_beverage_all_page.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class BuyTicketDialogBoxView extends StatefulWidget {
  final String location;
  final int movieId;
  final CinemaVO? cinema;
  final int cinemaDayTimeSlotId;
  final String startTime;
  final String date;
  final String seatNo;
  BuyTicketDialogBoxView(this.location, this.movieId, this.cinema,
      this.cinemaDayTimeSlotId,this.startTime, this.date,this.seatNo);

  @override
  State<BuyTicketDialogBoxView> createState() => _BuyTicketDialogBoxViewState();
}

class _BuyTicketDialogBoxViewState extends State<BuyTicketDialogBoxView> {
  final List<String> termsList = [
    BUY_TICKET_TERMS_1,
    BUY_TICKET_TERMS_2,
    BUY_TICKET_TERMS_3,
    BUY_TICKET_TERMS_4,
    BUY_TICKET_TERMS_5,
    BUY_TICKET_TERMS_6
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: APPBAR_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
      ),
      title: const Text(
        BUY_TICKET_TERMS_AND_CONDITION_TEXT,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: TEXT_REGULAR,
            color: Colors.white),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.all(MARGIN_CARD_MEDIUM_2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: termsList
                    .map((text) => TermsAndConditionsTextView(text))
                    .toList(),
              ),
              // ListView.separated(
              //
              //     itemBuilder: (BuildContext context,int index){
              //   return TermsAndConditionsTextView(termsList[index]);
              // }, separatorBuilder: (BuildContext context,int index){
              //   return SizedBox(height: MARGIN_MEDIUM_X);
              // }, itemCount: termsList.length,
              // physics: BouncingScrollPhysics(),
              // shrinkWrap: true,),
              const SizedBox(height: MARGIN_SMALL_LX),
              Image.asset("assets/images/termsAndConditionPic.png"),
              const SizedBox(height: MARGIN_MEDIUM_X),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CancelButtonView(),
                  AcceptButtonView(
                      () => _navigateToFoodAndBeverageAllPage(
                          context,
                          widget.location,
                          widget.movieId,
                          widget.cinema,
                          widget.cinemaDayTimeSlotId,
                          widget.startTime,
                          widget.date,
                      widget.seatNo)),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Future<dynamic> _navigateToFoodAndBeverageAllPage(
          BuildContext context,
          String location,
          int movieId,
          CinemaVO? cinema,
          int cinemaDayTimeSlotId,
          String startTime,
          String date,
      String seatNo) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FoodAndBeverageAllPage(
                  location,
                  movieId,
                  cinema,
                  cinemaDayTimeSlotId,
                  startTime,
                  date,
              seatNo)));
}

class AcceptButtonView extends StatefulWidget {
  final Function onPressedAccept;
  // final int movieId;
  // final CinemaVO? cinemaId;
  // final int cinemaDayTimeSlotId;
  // final String startTime;
  // final String date;
  AcceptButtonView(this.onPressedAccept);

  @override
  State<AcceptButtonView> createState() => _AcceptButtonViewState();
}

class _AcceptButtonViewState extends State<AcceptButtonView> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => widget.onPressedAccept(),
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM)),
          backgroundColor: PRIMARY_COLOR_1),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          BUY_TICKET_ACCEPT_BUTTON_TEXT,
          style: TextStyle(
              color: APPBAR_COLOR,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class CancelButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      style: TextButton.styleFrom(
          side: const BorderSide(color: PRIMARY_COLOR_1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM))),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          BUY_TICKET_CANCEL_BUTTON_TEXT,
          style: TextStyle(
              color: PRIMARY_COLOR_1,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class TermsAndConditionsTextView extends StatelessWidget {
  final String text;
  TermsAndConditionsTextView(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          textAlign: TextAlign.start,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: TEXT_SMALL,
              color: Colors.white),
        ),
        const SizedBox(height: MARGIN_MEDIUM_X)
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/ticket_check_out_page.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';

import '../resources/colors.dart';
import '../viewers/buy_ticket_dialog_box-view.dart';
import 'food_and_beverage_all_page.dart';

class ChooseSeatPage extends StatelessWidget {
  const ChooseSeatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_XXXXXLLARGE, vertical: MARGIN_MEDIUM_X),
        child: BuyTicketButtonView(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }
}

class BuyTicketButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return BuyTicketDialogBoxView();
            },
          );
        },
        child: Image.asset("assets/images/buyTicketButton.png"));
  }
}

import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/ticket_info_view.dart';

class TicketConfirmationPage extends StatelessWidget {
  late Function onTapTicket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        color: APPBAR_COLOR,
        padding: const EdgeInsets.only(
          left: MARGIN_CARD_MEDIUM_2,
          right: MARGIN_CARD_MEDIUM_2,
          top: MARGIN_xXLARGE,
        ),
        child: Column(
          children: [
            TicketInfoView(BookedticketData, 0, () => onTapTicket()),
            const SizedBox(height: MARGIN_xXLARGE),
            QrAndPinView(),
            const SizedBox(height: MARGIN_MEDIUM_3L),
            DoneButtonView()
          ],
        ),
      ),
    );
  }
}

class DoneButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage("Yangon"))),
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

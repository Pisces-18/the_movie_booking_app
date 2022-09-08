import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/payment_page.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/ticket_details_view.dart';

class TicketCheckOutPage extends StatefulWidget {


  @override
  State<TicketCheckOutPage> createState() => _TicketCheckOutPageState();
}

class _TicketCheckOutPageState extends State<TicketCheckOutPage> {
  @override
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
          horizontal: MARGIN_CARD_MEDIUM_2,
          vertical: MARGIN_xXLARGE,
        ),
        color: APPBAR_COLOR,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TicketDetailsView("Black Widow (3D) (U/A)",foodList),
              const SizedBox(height: MARGIN_XXXLARGE),
              ContinueButtonView(
                () => _navigateToPaymentPage(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToPaymentPage(BuildContext context) {
    return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentPage(),
                ),
              );
  }
}

class ContinueButtonView extends StatelessWidget {
  final Function onTapContinue;
  ContinueButtonView(this.onTapContinue);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTapContinue(),
        child: Image.asset("assets/images/continueButton.png"));
  }
}

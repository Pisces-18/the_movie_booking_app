import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/ticket_page.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/ticket_details_view.dart';

class CancelBookingPage extends StatefulWidget {

  final String movieName;
  CancelBookingPage(this.movieName);

  @override
  State<CancelBookingPage> createState() => _CancelBookingPageState();
}

class _CancelBookingPageState extends State<CancelBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: APPBAR_COLOR,
        title: const Text(
          CANCEL_BOOKING_PAGE_TITLE_TEXT,
          style:
              TextStyle(fontWeight: FontWeight.w700, fontSize: TEXT_REGULAR_4X),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: MARGIN_xXLARGE,
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          vertical: MARGIN_xXLARGE,
        ),

        child: SingleChildScrollView(
          child: Column(
            children: [
              //TicketDetailsView(widget.movieName,foodList),
              const SizedBox(height: MARGIN_XXXLARGE),
              RefundAmountAndCancelBookingSectionView(()=>_navigateToTicketPage(context))
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToTicketPage(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context)=>TicketPage()));
}

class RefundAmountAndCancelBookingSectionView extends StatefulWidget {
  final Function onTapCancel;
  RefundAmountAndCancelBookingSectionView(this.onTapCancel);

  @override
  State<RefundAmountAndCancelBookingSectionView> createState() => _RefundAmountAndCancelBookingSectionViewState();
}

class _RefundAmountAndCancelBookingSectionViewState extends State<RefundAmountAndCancelBookingSectionView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3LX),
      child: Row(
        children: [
          Column(
            children: const [
              Text(
                REFUND_AMOUN_TEXT,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: TEXT_REGULAR_2X,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: MARGIN_SMALL_Lx),
              Text(
                "15000KS",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: TEXT_REGULAR_3X,
                  color: TICKET_POLICY_BUTTON_COLOR,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: MARGIN_xLARGE,
          ),
          GestureDetector(
              onTap: ()=>widget.onTapCancel(),
              child: Image.asset("assets/images/cancelBookingButton.png")),
        ],
      ),
    );
  }
}

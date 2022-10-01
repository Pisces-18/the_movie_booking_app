import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/cancel_booking_page.dart';
import 'package:the_movie_booking_app/pages/movie_page.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/ticket_info_view.dart';
import '../widgets/bottom_navigation_bar_view.dart';

class TicketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: MARGIN_xXLARGE),
        child: SingleChildScrollView(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              // return TicketInfoView(
              //   ticketData,
              //   index,
              //   () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => CancelBookingPage(
              //           "${ticketData.elementAt(index)['movieName']}"),
              //     ),
              //   ),
              // );
              return Container();
            },
            itemCount: ticketData.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: MARGIN_xXLARGE,
              );
            },
          ),
        ),
      ),

    );
  }
}

import 'package:flutter/material.dart';
import 'package:measure_size/measure_size.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../widgets/ticket_date_time_location_icon_and_text_view.dart';
import 'ticket_divider_view.dart';

class TicketInfoView extends StatefulWidget {
  final List<Map<String, dynamic>> ticketData;
  final int index;
  final Function onTapTicket;
  TicketInfoView(this.ticketData, this.index, this.onTapTicket);

  @override
  State<TicketInfoView> createState() => _TicketInfoViewState();
}

class _TicketInfoViewState extends State<TicketInfoView> {
  // double? sizeHeight;
  // double? sizeWidth;
  Size? _size;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTapTicket(),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3LX),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  TICKET_INFO_VIEW_GRADIENT_COLOR_1,
                  TICKET_INFO_VIEW_GRADIENT_COLOR_2,
                  TICKET_INFO_VIEW_GRADIENT_COLOR_3,
                  TICKET_INFO_VIEW_GRADIENT_COLOR_4,
                ],
              ),
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,
              children: [
                MeasureSize(
                  onChange: (newSize){
                    setState((){
                      _size=newSize;
                    });
                  },
                  child: Padding(
                        padding: const EdgeInsets.only(bottom: MARGIN_MEDIUM_3),
                        child: MovieAndCinemaInfoView(
                            image:
                                "${widget.ticketData.elementAt(widget.index)['image']}",
                            movieName:
                                "${widget.ticketData.elementAt(widget.index)['movieName']}",
                            cinemaName:
                                "${widget.ticketData.elementAt(widget.index)['cinemaName']}",
                            numberOfTicket:
                                "${widget.ticketData.elementAt(widget.index)['noOfTicket']}",
                            ticketNumber:
                                "${widget.ticketData.elementAt(widget.index)['ticketNumber']}",
                            screenNumber:
                                "${widget.ticketData.elementAt(widget.index)['screenNumber']}"),
                      ),
                ),
                //Text(_size?.toString()?? "",style: TextStyle(color: Colors.white),),
                Padding(
                  padding: const EdgeInsets.only(
                      top: MARGIN_XXLARGE,
                      left: MARGIN_LARGE,
                      right: MARGIN_LARGE,
                      bottom: MARGIN_XxLARGE),
                  child: DateTimeLocationInfoView(
                    date:
                        "${widget.ticketData.elementAt(widget.index)['date']}",
                    time:
                        "${widget.ticketData.elementAt(widget.index)['time']}",
                    location:
                        "${widget.ticketData.elementAt(widget.index)['location']}",
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: _size?.height?? 0,
              child: TicketDividerView(_size?.width?? 0))
        ],
      ),
    );
  }
}

class DateTimeLocationInfoView extends StatelessWidget {
  const DateTimeLocationInfoView({
    Key? key,
    required this.date,
    required this.time,
    required this.location,
  }) : super(key: key);

  final String date;
  final String time;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TicketDateTimeLocationIconAndTextView("assets/images/date.png", date),
        const SizedBox(width: MARGIN_xXLARGE),
        TicketDateTimeLocationIconAndTextView("assets/images/date.png", time),
        const SizedBox(width: MARGIN_xXLARGE),
        TicketDateTimeLocationIconAndTextView(
          "assets/images/location.png",
          location,
        ),
      ],
    );
  }
}

class MovieAndCinemaInfoView extends StatelessWidget {
  const MovieAndCinemaInfoView({
    Key? key,
    required this.image,
    required this.movieName,
    required this.cinemaName,
    required this.numberOfTicket,
    required this.ticketNumber,
    required this.screenNumber,
  }) : super(key: key);

  final String image;
  final String movieName;
  final String cinemaName;
  final String numberOfTicket;
  final String ticketNumber;
  final String screenNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: MARGIN_MEDIUM_2,
            left: MARGIN_MEDIUM_2x,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(MARGIN_SMALL),
            child: Image.asset(
              image,
              height: TICKET_INFO_VIEW_IMAGE_HEIGHT,
            ),
          ),
        ),
        const SizedBox(width: MARGIN_MEDIUM_2X),
        Padding(
          padding: const EdgeInsets.only(top: MARGIN_MEDIUM_2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                movieName,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: TEXT_REGULAR_2X,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: MARGIN_MEDIUM_X),
              Text(
                cinemaName,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: TEXT_REGULAR_2X,
                    color: PRIMARY_COLOR_1),
              ),
              const SizedBox(height: MARGIN_MEDIUM_2x),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "M-Ticket(",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: TEXT_REGULAR,
                        color: Color.fromRGBO(170, 170, 170, 1),
                      ),
                    ),
                    TextSpan(
                      text: numberOfTicket,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: TEXT_REGULAR,
                        color: PRIMARY_COLOR_1,
                      ),
                    ),
                    const TextSpan(
                      text: ")",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: TEXT_REGULAR,
                        color: Color.fromRGBO(170, 170, 170, 1),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: MARGIN_MEDIUM_X),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: ticketNumber,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: TEXT_REGULAR_2X,
                          color: Colors.white),
                    ),
                    TextSpan(
                      text: screenNumber,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: TEXT_REGULAR,
                          color: SMS_CODE_COLOR),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

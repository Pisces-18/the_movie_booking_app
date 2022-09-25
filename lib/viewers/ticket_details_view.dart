import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:measure_size/measure_size.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';

import 'package:the_movie_booking_app/viewers/ticket_cancelion_policy_dialog_box_view.dart';
import 'package:the_movie_booking_app/viewers/ticket_divider_view.dart';
import '../data/vos/cinema_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/cancel_food_and_beverage_view.dart';
import '../widgets/ticket_date_time_location_icon_and_text_view.dart';

class TicketDetailsView extends StatefulWidget {
  final String movieName;
  final CinemaVO? cinema;
  final String date;
  final String startTime;
  final List<SnackVO> foodList;
 final int totalAmount;
  final Function(SnackVO,int) onTapCancel;

  TicketDetailsView(
    this.movieName,
    this.cinema,
    this.date,
    this.startTime,
    this.foodList,
      this.totalAmount,this.onTapCancel

  );

  @override
  State<TicketDetailsView> createState() => _TicketDetailsViewState();
}

class _TicketDetailsViewState extends State<TicketDetailsView> {
  Size? _size;

  @override

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3LX),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  DASH_COLOR_2,
                  TICKET_DETAILS_VIEW_GRADIENT_COLOR_1,
                  DASH_COLOR_2,
                ]),
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MovieAndCinemaInfoView(
                movieName: widget.movieName,
                cinema: widget.cinema,
                startTime: widget.startTime,
                date: widget.date,
              ),
              FoodAndBeverageSectionView(widget.foodList,(canceledFood,total){
                setState((){
                  widget.onTapCancel(canceledFood,total);
                });
              }),
              const SizedBox(height: MARGIN_lLARGE),
              ConvenienceFeeAndTicketCancellionPolicyView(),
              TotalAmountView(widget.totalAmount),
              // const SizedBox(height: MARGIN_MEDIUM_3),
            ],
          ),
        ),
        Text(_size?.height.toString() ?? "",
            style: TextStyle(color: Colors.white, fontSize: 22)),
        Positioned(
            bottom: TICKET_DETAILS_DIVIDER_HEIGHT, child: TicketDividerView()),
      ],
    );
  }
}

class TotalAmountView extends StatefulWidget {
  final int totalAmount;
  TotalAmountView(this.totalAmount);
  @override
  State<TotalAmountView> createState() => _TotalAmountViewState();
}

class _TotalAmountViewState extends State<TotalAmountView> {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_LARGE, vertical: MARGIN_MEDIUM_3),
      child: Row(
        children: [
          const Text(
            TOTAL_TEXT,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: TEXT_REGULAR_2Xx,
              color: PRIMARY_COLOR_1,
            ),
          ),
          Spacer(),
          Text(
            "${widget.totalAmount}Ks",
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: TEXT_REGULAR_2Xx,
              color: PRIMARY_COLOR_1,
            ),
          ),
        ],
      ),
    );
  }
}

class ConvenienceFeeAndTicketCancellionPolicyView extends StatefulWidget {
  @override
  State<ConvenienceFeeAndTicketCancellionPolicyView> createState() =>
      _ConvenienceFeeAndTicketCancellionPolicyViewState();
}

class _ConvenienceFeeAndTicketCancellionPolicyViewState
    extends State<ConvenienceFeeAndTicketCancellionPolicyView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MARGIN_LARGE, right: MARGIN_LARGE, top: MARGIN_MEDIUM_X),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                CONVENIENCE_FEE_TEXT,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: TEXT_REGULAR_2X,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: MARGIN_SMALL_L),
              Image.asset("assets/images/down.png"),
              const Spacer(),
              const Text(
                "500Ks",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: TEXT_REGULAR_2X,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: MARGIN_MEDIUM_3),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return TicketConcelionPolicyDialogBoxView();
                  });
            },
            child: Container(
              width: TICKET_POLICY_BUTTON_WITH,
              decoration: BoxDecoration(
                color: TICKET_POLICY_BUTTON_COLOR,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_MEDIUM_X, vertical: MARGIN_SMALL_L),
                child: Row(
                  children: const [
                    Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                    SizedBox(width: MARGIN_SMALL_L),
                    Text(
                      TICKET_CONCELION_POLICY_TEXT,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: TEXT_REGULAR,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: MARGIN_xXLARGE),
          const Divider(
            color: SMS_CODE_COLOR,
          ),
        ],
      ),
    );
  }
}

class FoodAndBeverageSectionView extends StatefulWidget {
  final List<SnackVO>? foodList;
  final Function(SnackVO,int) onTapCancel;
  FoodAndBeverageSectionView(this.foodList, this.onTapCancel);

  @override
  State<FoodAndBeverageSectionView> createState() =>
      _FoodAndBeverageSectionViewState();
}

class _FoodAndBeverageSectionViewState
    extends State<FoodAndBeverageSectionView> {
  bool isChangedIcon = false;
  int total = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      for (int i = 0; i < (widget.foodList?.length?? 0); i++) {
        total = (total +
                ((widget.foodList?[i].price?? 0) *
                        (widget.foodList?[i].quantity?? 0)) *
                    1000)
            .toInt();
      }
    });
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_X),
          child: ExpansionTile(
            onExpansionChanged: (newState) {
              if (newState) {
                setState(() {
                  isChangedIcon = true;
                });
              } else {
                setState(() {
                  isChangedIcon = false;
                });
              }
            },
            title: Row(
              children: [
                const Text(
                  FOOD_AND_BEVERAGE_TEXT,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: TEXT_REGULAR_2Xx,
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  (isChangedIcon)
                      ? "assets/images/up.png"
                      : "assets/images/down.png",
                  width: MARGIN_LARGE,
                  height: MARGIN_LARGE,
                ),
              ],
            ),

            leading: Image.asset(
              "assets/images/foodAndBeverage.png",
              color: Colors.white,
              width: MARGIN_LARGE,
              height: MARGIN_LARGE,
            ),
            trailing: Text(
              "${total}Ks",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: TEXT_REGULAR_2X,
                color: Colors.white,
              ),
            ),
            children: widget.foodList
                ?.map((foods) => CancelFoodAndBeverageView(
                        foods.name?? "", foods.price?? 0, foods.quantity?? 0, () {
                      setState(() {
                        widget.foodList?.remove(foods);
                        total = 0;
                        for (int i = 0; i < (widget.foodList?.length?? 0); i++) {
                          total = (total +
                              ((widget.foodList?[i].price?? 0) *
                                  (widget.foodList?[i].quantity?? 0) *
                                  1000))
                              .toInt();
                        }
                        total = total;
                        widget.onTapCancel(foods,total);
                      });
                    }))
                .toList()?? [],
            // iconColor: Colors.white,
            // controlAffinity: ListTileControlAffinity.trailing,
            // children: [
            //   Container(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            //     height: TICKET_INFO_FOOD_AND_BEVERAGE_LIST_VIEW_HEIGHT,
            //     child: ListView.builder(
            //         physics: NeverScrollableScrollPhysics(),
            //         itemCount: widget.foodList.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           return CancelFoodAndBeverageView(widget.foodList, index);
            //         }),
            //   ),
            // ],
          ),
        ),

        // TicketDividerView(),
      ],
    );
  }
}

class MovieAndCinemaInfoView extends StatefulWidget {
  const MovieAndCinemaInfoView({
    Key? key,
    required this.movieName,
    required this.cinema,
    required this.date,
    required this.startTime,
  }) : super(key: key);

  final String movieName;
  final CinemaVO? cinema;
  final String date;
  final String startTime;

  @override
  State<MovieAndCinemaInfoView> createState() => _MovieAndCinemaInfoViewState();
}

class _MovieAndCinemaInfoViewState extends State<MovieAndCinemaInfoView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: MARGIN_LARGE, right: MARGIN_LARGE, top: MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.movieName,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: TEXT_REGULAR_2X,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM_X),
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: widget.cinema?.name?? "",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: TEXT_REGULAR,
                color: PRIMARY_COLOR_1,
              ),
            ),
            const TextSpan(
              text: " (SCREEN 2)",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: TEXT_REGULAR,
                color: AVAILABLE_SERVICE_TEXT_COLOR,
              ),
            ),
          ])),
          const SizedBox(height: MARGIN_xXLARGE),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TicketDateTimeLocationIconAndTextView(
                  "assets/images/date.png",
                  DateFormat('E, d MMM, yyy')
                      .format(DateTime.parse(widget.date))),
              const SizedBox(width: MARGIN_xXLARGE),
              TicketDateTimeLocationIconAndTextView(
                  "assets/images/date.png", widget.startTime),
              const SizedBox(width: MARGIN_xXLARGE),
              TicketDateTimeLocationIconAndTextView(
                "assets/images/location.png",
                widget.cinema?.address?? "",
              ),
            ],
          ),
          const SizedBox(height: MARGIN_MEDIUM_3),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "M-Ticket(",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: TEXT_REGULAR,
                    color: AVAILABLE_SERVICE_TEXT_COLOR,
                  ),
                ),
                TextSpan(
                  text: " 2 ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: TEXT_REGULAR,
                    color: PRIMARY_COLOR_1,
                  ),
                ),
                TextSpan(
                  text: ")",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: TEXT_REGULAR,
                    color: AVAILABLE_SERVICE_TEXT_COLOR,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM_X),
          Row(
            children: const [
              Text(
                "Gold-G8,G7",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: TEXT_REGULAR_2X,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Text(
                "20000Ks",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: TEXT_REGULAR_2X,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: MARGIN_MEDIUM_2),
          const Divider(
            color: SMS_CODE_COLOR,
          ),
        ],
      ),
    );
  }
}

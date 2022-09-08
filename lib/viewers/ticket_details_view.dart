import 'package:flutter/material.dart';
import 'package:measure_size/measure_size.dart';

import 'package:the_movie_booking_app/viewers/ticket_cancelion_policy_dialog_box_view.dart';
import 'package:the_movie_booking_app/viewers/ticket_divider_view.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/cancel_food_and_beverage_view.dart';
import '../widgets/ticket_date_time_location_icon_and_text_view.dart';

class TicketDetailsView extends StatefulWidget {
  final String movieName;
  final List<Map<String, dynamic>> foodList;
  TicketDetailsView(this.movieName, this.foodList);

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
              MovieAndCinemaInfoView(movieName: widget.movieName),
              FoodAndBeverageSectionView(widget.foodList),
              const SizedBox(height: MARGIN_lLARGE),

              MeasureSize(
                onChange: (newSize){
                  setState((){
                    _size=newSize;
                  });
                },
                child: Column(
                  children: [
                    ConvenienceFeeAndTicketCancellionPolicyView(),
                    TotalAmountView()
                  ],
                ),
              ),
              // const SizedBox(height: MARGIN_MEDIUM_3),
            ],
          ),
        ),
        Positioned(
            bottom: _size?.height?? 0,
            child: TicketDividerView(_size?.width?? 0)),
      ],
    );
  }
}

class TotalAmountView extends StatefulWidget {
  @override
  State<TotalAmountView> createState() => _TotalAmountViewState();
}

class _TotalAmountViewState extends State<TotalAmountView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_LARGE, vertical: MARGIN_MEDIUM_3),
      child: Row(
        children: const [
          Text(
            TOTAL_TEXT,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: TEXT_REGULAR_2Xx,
              color: PRIMARY_COLOR_1,
            ),
          ),
          Spacer(),
          Text(
            "22500Ks",
            style: TextStyle(
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
  State<ConvenienceFeeAndTicketCancellionPolicyView> createState() => _ConvenienceFeeAndTicketCancellionPolicyViewState();
}

class _ConvenienceFeeAndTicketCancellionPolicyViewState extends State<ConvenienceFeeAndTicketCancellionPolicyView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MARGIN_LARGE,right: MARGIN_LARGE,top: MARGIN_MEDIUM_X),
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
  final List<Map<String, dynamic>> foodList;
  FoodAndBeverageSectionView(this.foodList);

  @override
  State<FoodAndBeverageSectionView> createState() =>
      _FoodAndBeverageSectionViewState();
}

class _FoodAndBeverageSectionViewState
    extends State<FoodAndBeverageSectionView> {
  bool isChangedIcon = false;
  @override
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
            trailing: const Text(
              "2000Ks",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: TEXT_REGULAR_2X,
                color: Colors.white,
              ),
            ),
            // iconColor: Colors.white,
            // controlAffinity: ListTileControlAffinity.trailing,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                height: TICKET_INFO_FOOD_AND_BEVERAGE_LIST_VIEW_HEIGHT,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.foodList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CancelFoodAndBeverageView(widget.foodList, index);
                    }),
              ),
            ],
          ),
        ),
        const SizedBox(height: MARGIN_lLARGE),
        // TicketDividerView(),
      ],
    );
  }
}

class MovieAndCinemaInfoView extends StatefulWidget {
  const MovieAndCinemaInfoView({
    Key? key,
    required this.movieName,
  }) : super(key: key);

  final String movieName;

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
              text: const TextSpan(children: [
            TextSpan(
              text: "JCGV : Junction City",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: TEXT_REGULAR,
                color: PRIMARY_COLOR_1,
              ),
            ),
            TextSpan(
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
                  "assets/images/date.png", "Sat, 18 Jun, 2022"),
              const SizedBox(width: MARGIN_xXLARGE),
              TicketDateTimeLocationIconAndTextView(
                  "assets/images/date.png", "3:30PM"),
              const SizedBox(width: MARGIN_xXLARGE),
              TicketDateTimeLocationIconAndTextView(
                "assets/images/location.png",
                "Q5H3+JPP, Corner of, Bogyoke Lann, Yangon",
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

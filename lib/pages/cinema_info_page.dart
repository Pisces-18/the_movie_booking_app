import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/resources/colors.dart';

import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../widgets/available_service_icon_and_text_view.dart';

class CinemaInfoPage extends StatelessWidget {
  final String location;
  final String cinemaName;
  CinemaInfoPage(this.location, this.cinemaName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: APPBAR_COLOR,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            "assets/images/leftIcon.png",
            width: MARGIN_LARGE,
            height: MARGIN_LARGE,
          ),
        ),
        title: const Text(
          CINEMA_INFO_PAGE_TITLE_TEXT,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: TEXT_REGULAR_4X,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
            child: Image.asset(
              "assets/images/starIcon.png",
              width: MARGIN_LARGE,
              height: MARGIN_LARGE,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height/1,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              cinemaVideoView(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_xLARGE),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CinemaNameAndLocationView(cinemaName),
                    const SizedBox(height: MARGIN_XXLARGE),
                    FacilitiesSectionView(facilityList),
                    const SizedBox(height: MARGIN_XXLARGE),
                    SafetySectionView(safetyList: safetyList)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SafetySectionView extends StatelessWidget {
  const SafetySectionView({
    Key? key,
    required this.safetyList,
  }) : super(key: key);

  final List<String> safetyList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          SAFETY_TEXT,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: TEXT_REGULAR_2Xx,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_3L),
        Container(
          width: MediaQuery.of(context).size.width / 1,
          child: Wrap(
            spacing: MARGIN_SMALL_L,
            runSpacing: MARGIN_CARD_MEDIUM_2,
            children: safetyList.map((type) => SafetyTypeView(type)).toList(),
          ),
        )
      ],
    );
  }
}

class SafetyTypeView extends StatelessWidget {
  final String type;
  SafetyTypeView(this.type);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_X,
        vertical: MARGIN_XSMALL,
      ),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR_1,
        borderRadius: BorderRadius.circular(MARGIN_SMALL),
      ),
      child: Text(
        type,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: TEXT_REGULAR,
          color: APPBAR_COLOR,
        ),
      ),
    );
  }
}

class FacilitiesSectionView extends StatelessWidget {
  final List<Map<String, dynamic>> facilityList;
  FacilitiesSectionView(this.facilityList);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          CINEMA_FACILIRIES_TEXT,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: TEXT_REGULAR_2Xx,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        Wrap(
          runSpacing: MARGIN_MEDIUM_2x,
          spacing: MARGIN_CARD_MEDIUM_2L_X,
          children: [
            AvailableServiceIconAndTextView(
                "Parking", "assets/images/parking_icon.png", PRIMARY_COLOR_1),
            AvailableServiceIconAndTextView("Online Food",
                "assets/images/foodAndBeverage.png", PRIMARY_COLOR_1),
            AvailableServiceIconAndTextView("Wheel Chair",
                "assets/images/wheel_chair_icon.png", PRIMARY_COLOR_1),
            AvailableServiceIconAndTextView("Ticket Cancelation",
                "assets/images/ticketCancelationIcon.png", PRIMARY_COLOR_1),
          ],
        ),
      ],
    );
  }
}

class CinemaNameAndLocationView extends StatelessWidget {
  final String cinemaName;
  CinemaNameAndLocationView(this.cinemaName);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          cinemaName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: TEXT_REGULAR_2X,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: MARGIN_CARD_MEDIUM_2L_X),
        Row(
          children: [
            const Flexible(
              child: Text(
                "Q5H3+JPP, Corner of, Bogyoke Lann, Yangon ",
                style: TextStyle(
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.w600,
                  fontSize: TEXT_REGULAR_2Xx,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: MARGIN_XXXLLARGE),
            Image.asset("assets/images/cinemaLocationIcon.png"),
          ],
        )
      ],
    );
  }
}

class cinemaVideoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: CINEMA_INFO_IMAGE_HEIGHT,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/cinemaDetailsImage.png",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset("assets/images/playButton.png"),
          )
        ],
      ),
    );
  }
}

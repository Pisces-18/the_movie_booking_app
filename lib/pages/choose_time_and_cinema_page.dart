import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/choose_seat_page.dart';
import 'package:the_movie_booking_app/resources/dateObject.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../viewers/cinema_expansion_view.dart';
import '../viewers/date_view.dart';
import 'cinema_info_page.dart';

class ChooseTimeAndCinemaPage extends StatefulWidget {
  @override
  State<ChooseTimeAndCinemaPage> createState() =>
      _ChooseTimeAndCinemaPageState();
}

class _ChooseTimeAndCinemaPageState extends State<ChooseTimeAndCinemaPage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: APPBAR_COLOR,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: MARGIN_xXLARGE,
          ),
        ),
        actions: const [
          Icon(
            Icons.near_me,
            size: MARGIN_MEDIUM_2,
          ),
          SizedBox(width: MARGIN_MEDIUM),
          Center(
            child: Text(
              "Yangon",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: TEXT_REGULAR_2X,
                  fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(width: MARGIN_LARGE),
          Icon(
            Icons.search,
            size: MARGIN_MEDIUM_3LX,
          ),
          SizedBox(width: MARGIN_xXLARGE),
          Padding(
            padding: EdgeInsets.only(right: MARGIN_MEDIUM_3LX),
            child: Icon(
              Icons.filter_list_alt,
              size: MARGIN_MEDIUM_3LX,
            ),
          )
        ],
      ),
      body: Container(
        color: PAGE_BACKGROUND_COLOR,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DateView(
                dateData,
              ),
              const SizedBox(height: MARGIN_xXLARGE),
              MovieTypeSectionView(movieTypeList: movieTypeList),
              const SizedBox(height: MARGIN_XxLARGE),
              TimeAndCinemaConditionSectionView(),
              Column(
                  children: cinemaList
                      .map(
                        (name) => CinemaExpansionView(
                            name,
                            () => _navigateToCinemaInfoPage(context),
                            () => _navigateToChooseSeatPage(context),timeAndAvailableSeatData,),
                      )
                      .toList(),)
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToCinemaInfoPage(BuildContext context) =>
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CinemaInfoPage()));

  Future<dynamic> _navigateToChooseSeatPage(BuildContext context) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChooseSeatPage()));
  }
}

class TimeAndCinemaConditionSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(34, 34, 34, 1),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(74, 74, 74, 0.25),
            blurRadius: MARGIN_MEDIUM_X,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_x),
        child: Row(
          children: [
            TimeAndCinemaConditionView(
              "Availible",
              "assets/images/dot1.png",
              AVAILABLE_COLOR,
            ),
            const SizedBox(width: MARGIN_XXxLARGE),
            TimeAndCinemaConditionView(
              "Filling Fast",
              "assets/images/dot2.png",
              FILLING_FAST_COLOR,
            ),
            const SizedBox(width: MARGIN_XXxLARGE),
            TimeAndCinemaConditionView(
              "Almost Full",
              "assets/images/dot3.png",
              ALMOST_FULL_COLOR,
            ),
          ],
        ),
      ),
    );
  }
}

class TimeAndCinemaConditionView extends StatelessWidget {
  final String text;
  final String image;
  final Color textColor;
  TimeAndCinemaConditionView(this.text, this.image, this.textColor);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image),
        SizedBox(width: MARGIN_MEDIUM_X),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: TEXT_REGULAR_2X,
            color: textColor,
          ),
        )
      ],
    );
  }
}

class MovieTypeSectionView extends StatelessWidget {
  const MovieTypeSectionView({
    Key? key,
    required this.movieTypeList,
  }) : super(key: key);

  final List<String> movieTypeList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Wrap(
        children: movieTypeList.map((type) => MovieTypeChipView(type)).toList(),
      ),
    );
  }
}

class MovieTypeChipView extends StatelessWidget {
  final String type;
  MovieTypeChipView(this.type);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Chip(
          padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_CARD_MEDIUM_2L, vertical: MARGIN_SMALL_L),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MARGIN_SMALL_L),
          ),
          side: const BorderSide(
            width: 1,
            color: Colors.white,
          ),
          backgroundColor: BUTTON_TEXT_COLOR_NS,
          label: Text(
            type,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: TEXT_REGULAR_2X,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: MARGIN_MEDIUM_3LX),
      ],
    );
  }
}



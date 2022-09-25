import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../viewers/banner_view.dart';

class CarouselSliderTestPage extends StatefulWidget {
  const CarouselSliderTestPage({Key? key}) : super(key: key);

  @override
  State<CarouselSliderTestPage> createState() => _CarouselSliderTestPageState();
}

class _CarouselSliderTestPageState extends State<CarouselSliderTestPage> {
  double _position=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: APPBAR_COLOR,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: MARGIN_XxlLARGE),
          child: Icon(
            Icons.near_me,
            size: MARGIN_MEDIUM_2,
          ),
        ),
        title: Text(
          "Yngon",
          style: GoogleFonts.inter(
            textStyle: Theme.of(context).textTheme.labelMedium,
            fontWeight: FontWeight.w700,
            fontSize: TEXT_REGULAR_2X,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
              // onTap: () => onTapSearch(),
              child: const Icon(
            Icons.search,
            size: MARGIN_MEDIUM_3LX,
          )),
          const SizedBox(width: MARGIN_MEDIUM_2),
          const Icon(Icons.notifications),
          Padding(
            padding: const EdgeInsets.only(right: MARGIN_MEDIUM_2X),
            child: Image.asset("assets/images/scanner.png"), //const
          )
        ],
      ),
      body: ClipRRect(
        child: Container(
          // padding: const EdgeInsets.only(
          //     //top: MARGIN_CARD_MEDIUM_2,
          //     left: MARGIN_MEDIUM_X,
          //     right: MARGIN_MEDIUM_X),
          color: APPBAR_COLOR,
          child: Column(
            children: [
              CarouselSlider.builder(
                itemCount: 4,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                 // return BannerView();
                      return Container();
                },
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 4.5,
                  enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                  initialPage: 1,
                    disableCenter: true,
                  onPageChanged: (index,reason){
                    setState(() {
                      _position = index.toDouble();
                    });
                  }
                ),
              ),
              const SizedBox(height: MARGIN_MEDIUM_2x),
              DotsIndicator(
                dotsCount: 4,
                position: _position,
                decorator: const DotsDecorator(
                  color: DOTSINDICATOR_INACTIVE_COLOR,
                  activeColor: PRIMARY_COLOR_1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

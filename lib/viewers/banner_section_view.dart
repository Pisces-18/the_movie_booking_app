import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import '../data/vos/banner_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import 'banner_view.dart';

class BannerSectionView extends StatefulWidget {
  const BannerSectionView({Key? key, this.bannerList}) : super(key: key);
  final List<BannerVO>? bannerList;

  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.bannerList?.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            return BannerView(widget.bannerList?[itemIndex]);
          },
          options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 5,
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
          dotsCount: widget.bannerList?.length?? 0,
          position: _position,
          decorator: const DotsDecorator(
            color: DOTSINDICATOR_INACTIVE_COLOR,
            activeColor: PRIMARY_COLOR_1,
          ),
        )
      ],
    );
  }
}

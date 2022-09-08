import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class BannerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
      const BorderRadius.all(Radius.circular(MARGIN_MEDIUM)),
      child: Stack(
        children: const [
          Positioned.fill(
            child: BannerImageView(),
          ),
          Positioned.fill(
            child: LinearGradientView(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: PromotionTextView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: CardImageView(),
          )
        ],
      ),
    );
  }
}

class CardImageView extends StatelessWidget {
  const CardImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: MARGIN_MEDIUM_2X, bottom: MARGIN_MEDIUM_2),
      child: Image.asset(
        "assets/images/card.png",
      ),
    );
  }
}

class PromotionTextView extends StatelessWidget {
  const PromotionTextView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: MARGIN_MEDIUM_2, left: MARGIN_MEDIUM_2X),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                "10%",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: TEXT_HEADING_3X,
                    color: Colors.white),
              ),
              SizedBox(width: MARGIN_SMALL),
              Text(
                "off",
                style: TextStyle(
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ],
          ),
          const Text(
            "with KBZ debit card",
            style: TextStyle(
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          )
        ],
      ),
    );
  }
}

class LinearGradientView extends StatelessWidget {
  const LinearGradientView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                BANNER_LINEAR_GRADIENT_COLOR_1,
                BANNER_LINEAR_GRADIENT_COLOR_2,
          ])),
    );
  }
}

class BannerImageView extends StatelessWidget {
  const BannerImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/kfc_censor.png",
      fit: BoxFit.cover,
    );
  }
}

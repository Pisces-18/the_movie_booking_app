import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';

class CinemaSeeDetailsDialogBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: APPBAR_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "JCGV : Junction City",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: TEXT_REGULAR,
                color: Colors.white,
              ),
            ),
            Text(
              "(Screen2)",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: TEXT_REGULAR,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_CARD_MEDIUM_2,
            ),
            child: Column(
              children: [
                PriceView(priceList.elementAt(0)['type'],priceList.elementAt(0)['price']),
                PriceView(priceList.elementAt(1)['type'],priceList.elementAt(1)['price']),
                PriceView(priceList.elementAt(2)['type'],priceList.elementAt(2)['price']),
                PriceView(priceList.elementAt(3)['type'],priceList.elementAt(3)['price']),
                PriceView(priceList.elementAt(4)['type'],priceList.elementAt(4)['price']),
                PriceView(priceList.elementAt(5)['type'],priceList.elementAt(5)['price']),
                cinemaDialogImageView(),
                const SizedBox(height: MARGIN_MEDIUM_2),
                PriceView(priceList.elementAt(0)['type'],priceList.elementAt(0)['price']),
                PriceView(priceList.elementAt(1)['type'],priceList.elementAt(1)['price']),
                PriceView(priceList.elementAt(2)['type'],priceList.elementAt(2)['price']),
                PriceView(priceList.elementAt(3)['type'],priceList.elementAt(3)['price']),
                PriceView(priceList.elementAt(4)['type'],priceList.elementAt(4)['price']),
                cinemaDialogImageView(),
                // GridView.builder(
                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 1,
                //     ),
                //     itemCount: priceList.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return PriceView(priceList, index);
                //     })
              ],
            ),
          )
        ],
      ),
    );
  }
}

class cinemaDialogImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/cinemaImage.png");
  }
}

class PriceView extends StatelessWidget {
  //  final String type;
  //  final String price;
  // PriceView(this.type,this.price);
  final List<Map<String, dynamic>> priceList;
  final int index;
  PriceView(this.priceList, this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${priceList.elementAt(index)['type']}",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: TEXT_REGULAR_2X,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Text(
              "${priceList.elementAt(index)['price']}",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: TEXT_REGULAR_2X,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: MARGIN_MEDIUM_3),
      ],
    );
  }
}

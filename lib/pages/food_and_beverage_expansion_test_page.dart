import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/cancel_food_and_beverage_view.dart';

class ExpansionTest extends StatelessWidget {
  final List<Map<String, dynamic>> foodList = [
    {
      "foodName": "Potatoe Chips ",
      "quantity": 2,
      "price": 1000,
    },
    {
      "foodName": "Cocala Large ",
      "quantity": 2,
      "price": 1000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      color: PAGE_BACKGROUND_COLOR,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/images/foodAndBeverage.png",
                color: Colors.white,
              ),
              const SizedBox(width: MARGIN_SMALL_L),
              const Text(
                FOOD_AND_BEVERAGE_TEXT,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: TEXT_REGULAR_2Xx,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: MARGIN_MEDIUM),
              Image.asset("assets/images/up.png"),
              const Spacer(),
              const Text(
                "2000Ks",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: TEXT_REGULAR_2X,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: MARGIN_LARGE),
          Container(
            height: 100,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
                itemCount: foodList.length,
                itemBuilder: (BuildContext context, int index) {
                  return CancelFoodAndBeverageView(foodList,index);
                }),
          ),
          // CancelFoodAndBeverageView(),

          const SizedBox(height: MARGIN_MEDIUM_3L),
          const DottedLine(
            dashColor: DASH_COLOR_2,
          ),

          ExpansionTile(
            title: const Text(
              FOOD_AND_BEVERAGE_TEXT,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: TEXT_REGULAR_2Xx,
                color: Colors.white,
              ),
            ),
            children: [
              Container(
                height: 100,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: foodList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CancelFoodAndBeverageView(foodList,index);
                    }),
              ),
            ],
          ),
        ],
      ),

    );
  }
}

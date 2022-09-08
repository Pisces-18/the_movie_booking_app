import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class FoodAndBeverageDataSectionView extends StatelessWidget {
  final List<Map<String, dynamic>> foodList;
  FoodAndBeverageDataSectionView(this.foodList);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: MARGIN_lLARGE,
          mainAxisSpacing: MARGIN_lLARGE,
          mainAxisExtent: FOOD_AND_BEVERAGE_LIST_HEIGHT,
        ),
        itemCount: foodList.length,
        itemBuilder: (BuildContext context, int index) {
          return FoodAndBeverageDataView(foodList: foodList, index: index,);
        });
  }
}

class FoodAndBeverageDataView extends StatelessWidget {
  const FoodAndBeverageDataView({
    Key? key,
    required this.foodList, required this.index,
  }) : super(key: key);

  final List<Map<String, dynamic>> foodList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            FOOD_AND_BEVERAGE_GRADIENT_COLOR_1,
            FOOD_AND_BEVERAGE_GRADIENT_COLOR_2,
          ],
        ),
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: MARGIN_MEDIUM_X),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Image.asset(
              "${foodList.elementAt(index)['image']}",
              height: FOOD_AND_BEVERAGE_DATA_HEIGHT,
            )),
            const SizedBox(height: MARGIN_MEDIUM_3),
            Text(
              "${foodList.elementAt(index)['foodName']}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: TEXT_SMALL,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: MARGIN_SMALL_L),
            Text(
              "${foodList.elementAt(index)['price']}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: TEXT_SMALL,
                color: PRIMARY_COLOR_1,
              ),
            ),
            const SizedBox(height: MARGIN_MEDIUM_X),
            ElevatedButton(
              onPressed: () => {},
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(PRIMARY_COLOR_1),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(MARGIN_SMALL),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MARGIN_XXxlLARGE,
                  vertical: MARGIN_SMALL_L,
                ),
                child: Text(FOOD_AND_BEVERAGE_ADD_BUTTON_TEXT),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class FoodAndBeverageDataSectionView extends StatefulWidget {
  final List<SnackVO>? snackList;
  final Function(Map<String, dynamic>) onPressedADD;
  //final int foodCount;
  FoodAndBeverageDataSectionView(
      this.snackList, this.onPressedADD);

  @override
  State<FoodAndBeverageDataSectionView> createState() =>
      _FoodAndBeverageDataSectionViewState();
}

class _FoodAndBeverageDataSectionViewState
    extends State<FoodAndBeverageDataSectionView> {
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
        itemCount: widget.snackList?.length,
        itemBuilder: (BuildContext context, int index) {
          return FoodAndBeverageDataView(
              snack: widget.snackList?[index],
              onPressedADD: (snacks) {
                widget.onPressedADD(snacks);
              },
              );
        });
  }
}

class FoodAndBeverageDataView extends StatefulWidget {
  const FoodAndBeverageDataView({
    Key? key,
    required this.snack,
    required this.onPressedADD,

  }) : super(key: key);

  final SnackVO? snack;
  final Function(Map<String, dynamic>) onPressedADD;
  //final int foodCount;

  @override
  State<FoodAndBeverageDataView> createState() =>
      _FoodAndBeverageDataViewState();
}

class _FoodAndBeverageDataViewState extends State<FoodAndBeverageDataView> {
  Map<String, dynamic> snack = {'id': 0, 'name': "", 'price': 0, 'qty': 0};
  List<Map<String, dynamic>> snacks = [];
  int count = 0;
  int qty = 0;
  int selectedItem = 0;
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
        padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_X),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Image.network(
              widget.snack?.image ?? "",
              height: FOOD_AND_BEVERAGE_DATA_HEIGHT,
            )),
            const SizedBox(height: MARGIN_MEDIUM_3),
            Text(
              widget.snack?.name ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: TEXT_SMALL,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: MARGIN_SMALL_L),
            Text(
              "${widget.snack?.price}000KS",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: TEXT_SMALL,
                color: PRIMARY_COLOR_1,
              ),
            ),
            const SizedBox(height: MARGIN_MEDIUM_X),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedItem = widget.snack?.id ?? 0;
                  // Map<String,dynamic> selectedSnack={"id": widget.snack?.id?? 0,"name" :widget.snack?.name ?? '',"price" :widget.snack?.price ?? 0,"qty" :qty,};

                  //snacks.where((id) => snacks.elementAt(0)['id']==selectedItem);

                  qty = qty + 1;
                  snack['id'] = widget.snack?.id ?? 0;
                  snack['name'] = widget.snack?.name ?? '';
                  snack['price'] = widget.snack?.price ?? 0;
                  snack['qty'] = qty;
                  // snacks.add(snack);
                 // debugPrint("price${snack['price']}");
                });

                widget.onPressedADD(snack);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR_1),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(MARGIN_SMALL),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MARGIN_SMALL_L,
                ),
                child: Center(
                    child: Text(
                  FOOD_AND_BEVERAGE_ADD_BUTTON_TEXT,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

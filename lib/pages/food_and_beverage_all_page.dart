import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_booking_app/pages/ticket_check_out_page.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/food_and_beverage_data_view.dart';

class FoodAndBeverageAllPage extends StatefulWidget {
  @override
  State<FoodAndBeverageAllPage> createState() => _FoodAndBeverageAllPageState();
}

class _FoodAndBeverageAllPageState extends State<FoodAndBeverageAllPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: foodTitleList.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: APPBAR_COLOR,
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: MARGIN_xXLARGE,
                ),
              ),
              const SizedBox(width: MARGIN_XXXLARGE),
              const Text(
                FOOD_AND_BEVERAGE_TITLE,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: TEXT_REGULAR_4X,
                    color: Colors.white),
              ),
              const SizedBox(width: MARGIN_EXTRA_LARGE),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TicketCheckOutPage())),
                child: const Text(
                  FOOD_AND_BEVERAGE_SKIP_TEXT,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: TEXT_REGULAR_3X,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_XL),
            indicatorColor: PRIMARY_COLOR_1,
            isScrollable: true,
            tabs: foodTitleList
                .map(
                  (title) => Tab(
                    child: Text(
                      title,
                      // style: const TextStyle(
                      //  fontFamily: 'DM Sans',
                      //     //fontStyle: ,
                      //     fontSize: TEXT_REGULAR_2X,
                      //     fontWeight: FontWeight.w600,
                      //     color: Colors.white),
                      style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.labelMedium,
                        fontWeight: FontWeight.w600,
                        fontSize: TEXT_REGULAR_2X,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        body: Container(
          color: PAGE_BACKGROUND_COLOR,
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_lLARGE,
            vertical: MARGIN_xXLARGE,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FoodAndBeverageDataSectionView(foodAllList),
                const SizedBox(height: MARGIN_xXLARGE),
                // BottomSheetBar(body: body, expandedBuilder: expandedBuilder)
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.zero,
          height: FLOATING_BUTTON_HEIGHT,
          width: double.infinity,
          color: PAGE_BACKGROUND_COLOR,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_3LX,
              vertical: MARGIN_CARD_MEDIUM_2L,
            ),
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MARGIN_MEDIUM_X),
                color: PRIMARY_COLOR_1),
            child: Row(
              children: [
                flloatingButtonImageView(),
                //const SizedBox(width: MARGIN_MEDIUM),
                FloatingButtonBottomSheetButtonView(
                  () => showBottom(),
                ),
                const Spacer(),
                FloatingButtonTotalPriceView(),
                const SizedBox(width: MARGIN_MEDIUM_X),
                NavigateToTicketCheckOutPageButtonView(
                  () => _navigateToTicketCheckOutPage(context),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Future<dynamic> _navigateToTicketCheckOutPage(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketCheckOutPage(),
      ),
    );
  }

  void showBottom() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(MARGIN_MEDIUM_3),
              topRight: Radius.circular(MARGIN_MEDIUM_3)),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.zero,
            height: BOTTOM_SHEET_HEIGHT,
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_3LX,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(MARGIN_MEDIUM_3),
                  topRight: Radius.circular(MARGIN_MEDIUM_3)),
              color: PAGE_BACKGROUND_COLOR,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomSheetFoodListHeight(selectedFoodList: selectedFoodList),
                const SizedBox(height: MARGIN_MEDIUM_2x),
                TotalFoodPriceView(),
              ],
            ),
          );
        });
  }
}

class NavigateToTicketCheckOutPageButtonView extends StatelessWidget {
  final Function onTapButton;
  NavigateToTicketCheckOutPageButtonView(this.onTapButton);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapButton(),
      child: Image.asset(
        "assets/images/right_arrow.png",
        color: APPBAR_COLOR,
      ),
    );
  }
}

class FloatingButtonTotalPriceView extends StatelessWidget {
  // const FloatingButtonTotalPriceView({
  //   Key? key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "2000Ks",
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: TEXT_REGULAR_2X,
          color: APPBAR_COLOR),
    );
  }
}

class FloatingButtonBottomSheetButtonView extends StatelessWidget {
  final Function showBottom;
  FloatingButtonBottomSheetButtonView(this.showBottom);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showBottom(),
      child: Image.asset(
        "assets/images/up.png",
        width: MARGIN_LARGE,
        height: MARGIN_LARGE,
        color: APPBAR_COLOR,
      ),
    );
  }
}

class flloatingButtonImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MARGIN_XXLARGE,
      child: Stack(
        children: [
          Image.asset("assets/images/foodAndBeverage.png"),
          Positioned(
            bottom: MARGIN_MEDIUM_X,
            left: MARGIN_MEDIUM_3,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(MARGIN_SMALL),
                child: Text(
                  "2",
                  style: GoogleFonts.inter(
                    textStyle: Theme.of(context).textTheme.bodySmall,
                    fontWeight: FontWeight.w400,
                    fontSize: MARGIN_MEDIUM,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TotalFoodPriceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXLARGE,
      width: double.infinity,
      color: PAGE_BACKGROUND_COLOR,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM_X),
            color: PRIMARY_COLOR_1),
        child: Row(
          children: [
            flloatingButtonImageView(),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                "assets/images/down.png",
                width: MARGIN_LARGE,
                height: MARGIN_LARGE,
                color: APPBAR_COLOR,
              ),
            ),
            const Spacer(),
            const Text(
              "2000Ks",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: TEXT_REGULAR_2X,
                  color: APPBAR_COLOR),
            ),
            const SizedBox(width: MARGIN_MEDIUM_X),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TicketCheckOutPage(),
                ),
              ),
              child: Image.asset(
                "assets/images/right_arrow.png",
                color: APPBAR_COLOR,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BottomSheetFoodListHeight extends StatelessWidget {
  const BottomSheetFoodListHeight({
    Key? key,
    required this.selectedFoodList,
  }) : super(key: key);

  final List<Map<String, dynamic>> selectedFoodList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: BOTTOM_SHEET_FOOD_LIST_HEIGHT,
      child: ListView.builder(
          itemCount: selectedFoodList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: MARGIN_xLARGE,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3.5,
                          child: Text(
                            "${selectedFoodList.elementAt(index)['name']}",
                            style: GoogleFonts.inter(
                              textStyle: Theme.of(context).textTheme.bodySmall,
                              fontWeight: FontWeight.w600,
                              fontSize: TEXT_REGULAR,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: MARGIN_XXLARGE),
                        Container(
                          decoration: const BoxDecoration(
                              color: PRIMARY_COLOR_1, shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(MARGIN_XSMALL),
                            child: Text(
                              "+",
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                fontWeight: FontWeight.w700,
                                fontSize: TEXT_REGULAR_2X,
                                color: BUTTON_TEXT_COLOR_NS,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: MARGIN_CARD_MEDIUM_2L),
                        Text(
                          "${selectedFoodList.elementAt(index)['qty']}",
                          style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.bodySmall,
                            fontWeight: FontWeight.w700,
                            fontSize: TEXT_REGULAR,
                            color: PRIMARY_COLOR_1,
                          ),
                        ),
                        const SizedBox(width: MARGIN_CARD_MEDIUM_2L),
                        Container(
                          decoration: const BoxDecoration(
                              color: PRIMARY_COLOR_1, shape: BoxShape.circle),
                          child: Padding(
                            padding: EdgeInsets.all(MARGIN_XSMALL),
                            child: Text(
                              "-",
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                fontWeight: FontWeight.w700,
                                fontSize: TEXT_REGULAR_2X,
                                color: BUTTON_TEXT_COLOR_NS,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: MARGIN_XXXXXLARGE),
                        Text(
                          "${selectedFoodList.elementAt(index)['price']}Ks",
                          style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.bodySmall,
                            fontWeight: FontWeight.w700,
                            fontSize: TEXT_REGULAR_2X,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

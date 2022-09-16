import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_booking_app/data/models/data_model.dart';
import 'package:the_movie_booking_app/data/models/data_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/pages/ticket_check_out_page.dart';
import '../data/vos/snack_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/food_and_beverage_data_section_view.dart';

class FoodAndBeverageAllPage extends StatefulWidget {
  final String location;
  final int movieId;
  final CinemaVO? cinema;
  final int cinemaDayTimeSlotId;
  final String startTime;
  final String date;
  final String seatNo;
  FoodAndBeverageAllPage(this.location, this.movieId, this.cinema,
      this.cinemaDayTimeSlotId, this.startTime, this.date, this.seatNo);
  @override
  State<FoodAndBeverageAllPage> createState() => _FoodAndBeverageAllPageState();
}

class _FoodAndBeverageAllPageState extends State<FoodAndBeverageAllPage> {
  DataModel mMovieModel = DataModelImpl();
  List<SnackVO>? snackList;
  int count = 0;

  // int price = 0;
  int co = 0;
  int total = 0;
  List<Map<String, dynamic>> selectedSnacks = [];

  @override
  void initState() {
    super.initState();
    mMovieModel.getSnackList()?.then((snacks) {
      setState(() {
        snackList = snacks;
        // List<Map<String,dynamic>>? testList;
        // Map<String,dynamic>? testMap={"id": snackList?[0].id?? 0,"name" :snackList?[0].name ?? '',"price" :snackList?[0].price ?? 0,"qty" :count,};
        // testList?.add(testMap);
        // debugPrint(testList?[0]["name"].toString());
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: foodTitleList.length,
      child: Scaffold(
        backgroundColor: PAGE_BACKGROUND_COLOR,
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
                onTap: () => _navigateToTicketCheckOutPage(
                    context,
                    widget.location,
                    widget.movieId,
                    widget.cinema,
                    widget.cinemaDayTimeSlotId,
                    widget.startTime,
                    widget.date,
                    widget.seatNo,
                    selectedSnacks),
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
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_lLARGE,
            vertical: MARGIN_xXLARGE,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FoodAndBeverageDataSectionView(snackList ?? [], (snacks) {
                  setState(() {
                    //count = c;
                    selectedSnacks.add(snacks);
                    total = ((total + snacks['price'] * 1000)).toInt();
                    //count=(count+snacks['qty']).toInt();
                    selectedSnacks = selectedSnacks.toSet().toList();
                    //debugPrint(count.toString());
                    // count=count+tempCount;
                    // debugPrint(selectedSnacks.toString());
                  });
                  int tempCount = 0;
                  for (int i = 0; i < selectedSnacks.length; i++) {
                    tempCount = (tempCount + selectedSnacks.elementAt(i)['qty'])
                        .toInt();
                    //tempCount=count;
                    //total = (total+selectedSnacks.elementAt(i)['price']).toInt();
                  }

                  count = tempCount.toInt();
                  selectedSnacks.forEach((items) {
                    debugPrint("Home Snack===>${items.toString()}");
                  });
                }),
                const SizedBox(height: MARGIN_xXLARGE),
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
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_CARD_MEDIUM_2,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MARGIN_MEDIUM_X),
                color: PRIMARY_COLOR_1),
            child: Row(
              children: [
                flloatingButtonImageView(count),
                FloatingButtonBottomSheetButtonView(selectedSnacks,(location,selectedSnacksFromBottomSheet){
                  setState(() {
                    selectedSnacks=selectedSnacksFromBottomSheet;
                    int tempCount = 0;
                    for (int i = 0; i < selectedSnacks.length; i++) {
                      tempCount = (tempCount + selectedSnacks.elementAt(i)['qty'])
                          .toInt();
                      //tempCount=count;
                      //total = (total+selectedSnacks.elementAt(i)['price']).toInt();
                    }

                    count = tempCount.toInt();
                    selectedSnacks.forEach((items) {
                      debugPrint("On Tap Snack at Home===>${items.toString()}");
                    });
                  });
                }, widget.location, count,total,()=>_navigateToTicketCheckOutPage(
                    context,
                    widget.location,
                    widget.movieId,
                    widget.cinema,
                    widget.cinemaDayTimeSlotId,
                    widget.startTime,
                    widget.date,
                    widget.seatNo,
                    selectedSnacks)),

                //const SizedBox(width: MARGIN_MEDIUM),
                // FloatingButtonBottomSheetButtonView(
                //   (location) => showBottom(widget.location,count, widget.movieId, widget.cinema, widget.cinemaDayTimeSlotId,
                //       widget.startTime, widget.date, selectedSnacks,(addCount,index,c){
                //        setState((){
                //          selectedSnacks.elementAt(index)['qty']=addCount;
                //          count=c;
                //        });
                //       },(minusCount,index,c){
                //         setState((){
                //           selectedSnacks.elementAt(index)['qty']=minusCount;
                //           count=c;
                //         });
                //       }
                //   ),
                //   widget.location,
                //   count,
                // ),
                const Spacer(),
                FloatingButtonTotalPriceView(
                  totalPrice: total,
                ),
                const SizedBox(width: MARGIN_MEDIUM_X),
                NavigateToTicketCheckOutPageButtonView(
                    (location) => _navigateToTicketCheckOutPage(
                        context,
                        location,
                        widget.movieId,
                        widget.cinema,
                        widget.cinemaDayTimeSlotId,
                        widget.startTime,
                        widget.date,
                        widget.seatNo,
                        selectedSnacks),
                    widget.location)
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Future<dynamic> _navigateToTicketCheckOutPage(
      BuildContext context,
      location,
      int movieId,
      CinemaVO? cinema,
      int cinemaDayTimeSlotId,
      String startTime,
      String date,
      String seatNo,
      List<Map<String, dynamic>> selectedSnacks) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketCheckOutPage(location, movieId, cinema,
            cinemaDayTimeSlotId, startTime, date, seatNo, selectedSnacks),
      ),
    );
  }


}

class NavigateToTicketCheckOutPageButtonView extends StatelessWidget {
  final String location;
  final Function(String) onTapButton;
  NavigateToTicketCheckOutPageButtonView(this.onTapButton, this.location);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapButton(location),
      child: Image.asset(
        "assets/images/right_arrow.png",
        color: APPBAR_COLOR,
      ),
    );
  }
}

class FloatingButtonTotalPriceView extends StatelessWidget {
  const FloatingButtonTotalPriceView({
    Key? key,
    required this.totalPrice,
  }) : super(key: key);
  final int totalPrice;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${totalPrice}KS",
      style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: TEXT_REGULAR_2X,
          color: APPBAR_COLOR),
    );
  }
}

class FloatingButtonBottomSheetButtonView extends StatefulWidget {
  final List<Map<String,dynamic>> selectedSnacks;
  final String location;
  final Function(String,List<Map<String,dynamic>>) onTapShowBottom;
  late int count;
  late int total;
  final Function onTapNavigate;


   FloatingButtonBottomSheetButtonView(this.selectedSnacks,
      this.onTapShowBottom, this.location, this.count,this.total,this.onTapNavigate);

  @override
  State<FloatingButtonBottomSheetButtonView> createState() =>
      _FloatingButtonBottomSheetButtonViewState();
}

class _FloatingButtonBottomSheetButtonViewState
    extends State<FloatingButtonBottomSheetButtonView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       setState((){
         showBottom();
         widget.onTapShowBottom(widget.location,widget.selectedSnacks);
         widget.selectedSnacks.forEach((items) {
           debugPrint("On Tap Snack===>${items.toString()}");
         });
       });
        // widget.onTapShowBottom()
      },
      child: Image.asset(
        "assets/images/up.png",
        width: MARGIN_LARGE,
        height: MARGIN_LARGE,
        color: APPBAR_COLOR,
      ),
    );
  }
  void showBottom() {
    //int bottomSheetCount=count;
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
                BottomSheetFoodList(
                  selectedFoodList: widget.selectedSnacks,
                  onTapAdd: (addCount, index, c, bottomSheetSelectedSnacks) {
                    //selectedSnacks.elementAt(index)['qty']=selectedSnacks.elementAt(index)['qty']+1;
                    setState(() {
                      widget.selectedSnacks.elementAt(index)['qty'] = addCount;
                      widget.count = c;
                      widget.total = 0;
                      for (int i = 0; i < widget.selectedSnacks.length; i++) {
                        widget.total = (widget.total +
                            (widget.selectedSnacks.elementAt(i)['price'] *
                                widget.selectedSnacks.elementAt(i)['qty'] *
                                1000))
                            .toInt();
                      }
                      //widget.selectedSnacks = [];
                      //selectedSnacks = bottomSheetSelectedSnacks;
                      bottomSheetSelectedSnacks.forEach((items) {
                        debugPrint("Main Snack===>${items.toString()}");
                      });
                    });
                  },
                  onTapMinus:
                      (minusCount, index, c, bottomSheetSelectedSnacks) {
                    setState(() {
                      //selectedSnacks=bottomSheetSelectedSnacks;

                      widget.selectedSnacks.elementAt(index)['qty'] = minusCount;
                      widget.count = c;
                      widget.total = 0;
                      for (int i = 0; i < widget.selectedSnacks.length; i++) {
                        widget.total = (widget.total +
                            (widget.selectedSnacks.elementAt(i)['price'] *
                                widget.selectedSnacks.elementAt(i)['qty'] *
                                1000))
                            .toInt();
                      }
                      //selectedSnacks = [];
                      //selectedSnacks = bottomSheetSelectedSnacks;
                      bottomSheetSelectedSnacks.forEach((items) {
                        debugPrint("Main Snack===>${items.toString()}");
                      });
                    });
                    // selectedSnacks.elementAt(index)['qty']=minusCount;
                    // showBottomCount=c;
                  },
                  count: widget.count,
                ),
                const SizedBox(height: MARGIN_MEDIUM_2x),
                // TotalFoodPriceView(
                //     widget.location,
                //     count,
                //     widget.movieId,
                //     widget.cinema,
                //     widget.cinemaDayTimeSlotId,
                //     widget.startTime,
                //     widget.date,
                //     selectedSnacks,
                //     total),
                Container(
                  height: MARGIN_XXLARGE,
                  width: double.infinity,
                  color: PAGE_BACKGROUND_COLOR,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(MARGIN_MEDIUM_X),
                        color: PRIMARY_COLOR_1),
                    child: Row(
                      children: [
                        flloatingButtonImageView(widget.count),
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
                        Text(
                          "${widget.total}Ks",
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: TEXT_REGULAR_2X,
                              color: APPBAR_COLOR),
                        ),
                        const SizedBox(width: MARGIN_MEDIUM_X),
                        GestureDetector(
                          onTap: () => widget.onTapNavigate(),
                          child: Image.asset(
                            "assets/images/right_arrow.png",
                            color: APPBAR_COLOR,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class flloatingButtonImageView extends StatefulWidget {
  final int foodCount;
  flloatingButtonImageView(this.foodCount);
  @override
  State<flloatingButtonImageView> createState() =>
      _flloatingButtonImageViewState();
}

class _flloatingButtonImageViewState extends State<flloatingButtonImageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MARGIN_XXLARGE,
      child: Stack(
        children: [
          Image.asset("assets/images/foodAndBeverage.png"),
          Positioned(
            bottom: MARGIN_SMALL_LX,
            left: MARGIN_MEDIUM_3,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(MARGIN_SMALL_L),
                child: Text(
                  widget.foodCount.toString(),
                  style: GoogleFonts.inter(
                    textStyle: Theme.of(context).textTheme.bodySmall,
                    fontWeight: FontWeight.w600,
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

class TotalFoodPriceView extends StatefulWidget {
  final String location;
  final int foodCount;
  final int movieId;
  final CinemaVO? cinema;
  final int cinemaDayTimeSlotId;
  final String startTime;
  final String date;
  final List<Map<String, dynamic>> snackList;
  final int total;
  TotalFoodPriceView(
    this.location,
    this.foodCount,
    this.movieId,
    this.cinema,
    this.cinemaDayTimeSlotId,
    this.startTime,
    this.date,
    this.snackList,
    this.total,
  );

  @override
  State<TotalFoodPriceView> createState() => _TotalFoodPriceViewState();
}

class _TotalFoodPriceViewState extends State<TotalFoodPriceView> {
  //int total = 0;
  @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     for (int i = 0; i < widget.snackList.length; i++) {
  //       total = (total + widget.snackList.elementAt(i)['price']).toInt();
  //     }
  //   });
  // }

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
            flloatingButtonImageView(widget.foodCount),
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
            Text(
              "${widget.total}Ks",
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: TEXT_REGULAR_2X,
                  color: APPBAR_COLOR),
            ),
            const SizedBox(width: MARGIN_MEDIUM_X),
            // GestureDetector(
            //   onTap: () => Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => TicketCheckOutPage(
            //               widget.location,
            //               widget.movieId,
            //               widget.cinema,
            //               widget.cinemaDayTimeSlotId,
            //               widget.startTime,
            //               widget.date,
            //               widget.snackList))),
            //   child: Image.asset(
            //     "assets/images/right_arrow.png",
            //     color: APPBAR_COLOR,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class BottomSheetFoodList extends StatefulWidget {
  const BottomSheetFoodList({
    Key? key,
    required this.selectedFoodList,
    required this.onTapAdd,
    required this.onTapMinus,
    required this.count,
  }) : super(key: key);

  final List<Map<String, dynamic>> selectedFoodList;
  final Function(int, int, int, List<Map<String, dynamic>>) onTapAdd;
  final Function(int, int, int, List<Map<String, dynamic>>) onTapMinus;
  final int count;

  @override
  State<BottomSheetFoodList> createState() => _BottomSheetFoodListState();
}

class _BottomSheetFoodListState extends State<BottomSheetFoodList> {
  int addCount = 0;
  int minusCount = 0;
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: BOTTOM_SHEET_FOOD_LIST_HEIGHT,
      child: ListView.builder(
          itemCount: widget.selectedFoodList.length,
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
                            "${widget.selectedFoodList.elementAt(index)['name']}",
                            style: GoogleFonts.inter(
                              textStyle: Theme.of(context).textTheme.bodySmall,
                              fontWeight: FontWeight.w600,
                              fontSize: TEXT_REGULAR,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: MARGIN_XXLARGE),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              addCount = widget.selectedFoodList
                                      .elementAt(index)['qty'] +
                                  1;
                              _count = widget.count + 1;
                              widget.onTapAdd(addCount, index, _count,
                                  widget.selectedFoodList);
                              widget.selectedFoodList.forEach((items) {
                                debugPrint(
                                    "Bottom Snack===>${items.toString()}");
                              });
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                color: PRIMARY_COLOR_1, shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: MARGIN_SMALL,
                                  top: MARGIN_XSMALL,
                                  left: MARGIN_XSMALL,
                                  right: MARGIN_XSMALL),
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
                        ),
                        const SizedBox(width: MARGIN_CARD_MEDIUM_2L),
                        Text(
                          "${widget.selectedFoodList.elementAt(index)['qty']}",
                          style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.bodySmall,
                            fontWeight: FontWeight.w700,
                            fontSize: TEXT_REGULAR,
                            color: PRIMARY_COLOR_1,
                          ),
                        ),
                        const SizedBox(width: MARGIN_CARD_MEDIUM_2L),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              minusCount = widget.selectedFoodList
                                      .elementAt(index)['qty'] -
                                  1;
                              _count = widget.count - 1;
                              if (widget.selectedFoodList
                                      .elementAt(index)['qty'] !=
                                  0) {
                                widget.onTapMinus(minusCount, index, _count,
                                    widget.selectedFoodList);
                                widget.selectedFoodList.forEach((items) {
                                  debugPrint(
                                      "Bottom Snack===>${items.toString()}");
                                });
                                if (widget.selectedFoodList
                                        .elementAt(index)['qty'] ==
                                    0) {
                                  widget.selectedFoodList.removeAt(index);
                                  debugPrint(
                                      "Removed Snack===>${widget.selectedFoodList.toString()}");
                                }
                              }
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                color: PRIMARY_COLOR_1, shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: MARGIN_SMALL,
                                  top: MARGIN_XSMALL,
                                  left: MARGIN_SMALL,
                                  right: MARGIN_SMALL),
                              child: Center(
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
                          ),
                        ),
                        const SizedBox(width: MARGIN_XXXXXLARGE),
                        Text(
                          "${widget.selectedFoodList.elementAt(index)['price'] * widget.selectedFoodList.elementAt(index)['qty'] * 1000}Ks",
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

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_booking_app/data/models/data_model.dart';
import 'package:the_movie_booking_app/data/models/data_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/cinema_and_show_time_slots_vo.dart';
import 'package:the_movie_booking_app/data/vos/time_slot_vo.dart';
import 'package:the_movie_booking_app/pages/ticket_check_out_page.dart';
import '../data/vos/cinema_vo.dart';
import '../data/vos/snack_category_vo.dart';
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
  final TimeSlotVO? cinemaDayTimeSlot;
  final String date;
  final String seatNo;
  FoodAndBeverageAllPage(this.location, this.movieId, this.cinema,
      this.cinemaDayTimeSlot, this.date, this.seatNo);
  @override
  State<FoodAndBeverageAllPage> createState() => _FoodAndBeverageAllPageState();
}

class _FoodAndBeverageAllPageState extends State<FoodAndBeverageAllPage> {
  DataModel dDataModel = DataModelImpl();
  List<SnackCategoryVO>? snackCategory;
  List<SnackVO>? snackList;
  List<SnackVO> selectedSnacks=[];
  int count = 0;
  Map<String, dynamic> allCategory = {"id": 0, "title": "All"};


  // int price = 0;

 List<int> snacksId=[];
  int total = 0;
  //List<Map<String, dynamic>> selectedSnacks = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      // snackCategory?.first.id = 0;
      // snackCategory?.first.title = "All";
      // snackCategory?.addAll(DataModelImpl().mSnackCategoryRepository ?? []);
      snackCategory = DataModelImpl().mSnackCategoryRepository;
      debugPrint(snackCategory?.first.title);
      _getSnacksByCategoryAndRefresh(0);
    });

  }

  void _getSnacksByCategoryAndRefresh(int categoryId) {
    dDataModel.getSnacks(categoryId)?.then((snacks) {
      setState(() {
        snackList = snacks;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  static const List<Tab> categoryTab = [
    // // Tab(child: Text("All"),),
    // snackCategory
    //     ?.map(
    //       (category) => Tab(
    //     child: Text(
    //       category.title?? "",
    //       // style: const TextStyle(
    //       //  fontFamily: 'DM Sans',
    //       //     //fontStyle: ,
    //       //     fontSize: TEXT_REGULAR_2X,
    //       //     fontWeight: FontWeight.w600,
    //       //     color: Colors.white),
    //       style: GoogleFonts.inter(
    //         textStyle: Theme.of(context).textTheme.labelMedium,
    //         fontWeight: FontWeight.w600,
    //         fontSize: TEXT_REGULAR_2X,
    //         color: Colors.white,
    //       ),
    //     ),
    //   ),
    // )
    //     .toList()?? [],
  ];
  Widget build(BuildContext context) {

    return Scaffold(
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
                  widget.cinemaDayTimeSlot,
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
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DefaultTabController(
                length: 5,
                child: TabBar(
                    onTap: (index) {
                      setState(() {
                        if (index == 0) {
                          debugPrint(index.toString());
                          dDataModel.getSnacks(0)?.then((snacks) {
                            setState(() {
                              snackList = snacks;
                            });
                          }).catchError((error) {
                            debugPrint(error.toString());
                          });
                        } else {
                          _getSnacksByCategoryAndRefresh(
                              snackCategory?[index - 1].id ?? 0);
                          debugPrint("${snackCategory?[index - 1].id ?? 0}");
                        }
                      });
                    },
                    padding: const EdgeInsets.symmetric(
                        horizontal: MARGIN_MEDIUM_XL),
                    indicatorColor: PRIMARY_COLOR_1,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: Text(
                          "All",
                          style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.labelMedium,
                            fontWeight: FontWeight.w600,
                            fontSize: TEXT_REGULAR_2X,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "${snackCategory?[0].title}",
                          style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.labelMedium,
                            fontWeight: FontWeight.w600,
                            fontSize: TEXT_REGULAR_2X,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "${snackCategory?[1].title}",
                          style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.labelMedium,
                            fontWeight: FontWeight.w600,
                            fontSize: TEXT_REGULAR_2X,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "${snackCategory?[2].title}",
                          style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.labelMedium,
                            fontWeight: FontWeight.w600,
                            fontSize: TEXT_REGULAR_2X,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "${snackCategory?[3].title}",
                          style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.labelMedium,
                            fontWeight: FontWeight.w600,
                            fontSize: TEXT_REGULAR_2X,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ]),
              ),
              (snackList != null)
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: MARGIN_lLARGE,
                        vertical: MARGIN_xXLARGE,
                      ),
                      child: FoodAndBeverageDataSectionView(snackList ?? [],
                          (snack) {


                        setState(() {
                          snacksId=selectedSnacks.map((snack) => snack.id?? 0).toList();
                          if(snacksId.contains(snack.id)){
                            debugPrint("Equal===>$selectedSnacks");
                            for(int j=0;j<selectedSnacks.length;j++){
                              if(snack.id==selectedSnacks[j].id){
                                selectedSnacks[j].quantity=(selectedSnacks[j].quantity?? 0)+1;
                              }
                            }
                            count=count+1;
                            total=total+((snack.price?? 0)*1000);
                          }else{
                            snack.quantity=1;
                            selectedSnacks.add(snack);
                            count=count+1;
                            total=total+((snack.price?? 0)*1000);
                          }

                          debugPrint("selected Snacks===>$selectedSnacks");


                        });
                      }),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
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
              Badge(
                toAnimate: false,
                position: BadgePosition.topEnd(end: -12),
                badgeContent: Text(
                  "$count",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: MARGIN_MEDIUM,
                      fontWeight: FontWeight.bold),
                ),
                elevation: 0,
                child: Image.asset("assets/images/foodAndBeverage.png"),
              ),
              const SizedBox(width: MARGIN_MEDIUM_X),
              GestureDetector(
                onTap: () {
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: MARGIN_MEDIUM_3LX,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(MARGIN_MEDIUM_3),
                                topRight: Radius.circular(MARGIN_MEDIUM_3)),
                            color: PAGE_BACKGROUND_COLOR,
                          ),
                          child: FoodList(selectedSnacks,(addCount,price,index,selected){
                            setState((){
                              selectedSnacks[index].quantity=addCount;
                              count=count+1;
                              total = total+price;


                            });
                          },(minusCount,price,index,selected){
                            setState((){
                              selectedSnacks[index].quantity=minusCount;
                              count=count-1;
                              total=total-price;

                            });
                          },(){
                            _navigateToTicketCheckOutPage(
                                context,
                                widget.location,
                                widget.movieId,
                                widget.cinema,
                                widget.cinemaDayTimeSlot,
                                widget.date,
                                widget.seatNo,
                                selectedSnacks);
                          }),
                        );
                      });
                },
                child: Image.asset(
                  "assets/images/up.png",
                  width: MARGIN_LARGE,
                  height: MARGIN_LARGE,
                  color: APPBAR_COLOR,
                ),
              ),
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
                      widget.cinemaDayTimeSlot,
                      widget.date,
                      widget.seatNo,
                      selectedSnacks),
                  widget.location)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<dynamic> _navigateToTicketCheckOutPage(
      BuildContext context,
      location,
      int movieId,
      CinemaVO? cinema,
      TimeSlotVO? cinemaDayTimeSlot,
      String date,
      String seatNo,
      List<SnackVO>? selectedSnacks) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketCheckOutPage(location, movieId, cinema,
            cinemaDayTimeSlot, date, seatNo, selectedSnacks),
      ),
    );
  }
}

class FoodList extends StatefulWidget {
  final List<SnackVO>? selectedSnack;
  final Function(int,int,int,List<SnackVO>) onTapAdd;
  final Function(int,int,int,List<SnackVO>) onTapMinus;
  // late int count;
  // late int total;
  final Function onTapNavigateCheckout;
  FoodList(this.selectedSnack,this.onTapAdd,this.onTapMinus,this.onTapNavigateCheckout);
  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  int count=0;
  int total=0;
  void initState(){
    super.initState();
    setState((){
      for(int i=0;i<(widget.selectedSnack?.length?? 0);i++){
        count=count+(widget.selectedSnack?[i].quantity?? 0);
        total=total+((widget.selectedSnack?[i].price?? 0)*(widget.selectedSnack?[i].quantity?? 0)*1000);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          shrinkWrap: true,
          children: widget.selectedSnack
              ?.map(
                (snack) => Padding(
                  padding: const EdgeInsets.only(
                    top: MARGIN_xLARGE,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: Text(
                          snack.name?? "",
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
                            // addCount = widget.selectedFoodList
                            //     .elementAt(index)['qty'] +
                            //     1;
                            // _count = widget.count + 1;
                            // widget.onTapAdd(widget.qty+1);
                            count=count+1;
                            int price=((snack.price?? 0)*1000);
                            total=total+price;
                            widget.onTapAdd((snack.quantity?? 0)+1,price,widget.selectedSnack?.indexOf(snack)?? 0,widget.selectedSnack?? []);
                            widget.selectedSnack?.forEach((items) {
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
                                textStyle: Theme.of(context).textTheme.bodySmall,
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
                        "${snack.quantity}",
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
                            count=count-1;
                            int price=((snack.price?? 0)*1000);
                            total=total-price;
                            if((snack.quantity?? 0)>0){
                              widget.onTapMinus((snack.quantity?? 0)-1,price,widget.selectedSnack?.indexOf(snack)?? 0,widget.selectedSnack?? []);
                              if((snack.quantity?? 0)==0){
                                // widget.onTapMinus(snack['qty']-1,widget.selectedSnack.indexOf(snack));
                                widget.selectedSnack?.remove(snack);

                              }
                            }

                           // debugPrint(widget.selectedSnack.indexOf(snack).toString());
                            // minusCount = widget.selectedFoodList
                            //     .elementAt(index)['qty'] -
                            //     1;
                            // _count = widget.count - 1;
                            // if (widget.selectedFoodList
                            //     .elementAt(index)['qty'] !=
                            //     0) {
                            // if(widget.qty!=0){
                            //   widget.onTapMinus(widget.qty-1);
                            // }
                            //   widget.selectedFoodList.forEach((items) {
                            //     debugPrint(
                            //         "Bottom Snack===>${items.toString()}");
                            //   });
                            //   if (widget.selectedFoodList
                            //       .elementAt(index)['qty'] ==
                            //       0) {
                            //     widget.selectedFoodList.removeAt(index);
                            //     debugPrint(
                            //         "Removed Snack===>${widget.selectedFoodList.toString()}");
                            //   }
                            // }
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
                                  textStyle: Theme.of(context).textTheme.bodySmall,
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
                      Expanded(
                        child: Text(
                          "${(snack.price?? 0) * (snack.quantity?? 0) * 1000}Ks",
                          style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.bodySmall,
                            fontWeight: FontWeight.w700,
                            fontSize: TEXT_REGULAR_2X,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList()?? [],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 15),
            height: MARGIN_XXLARGE,
            width: double.infinity,
            color: PAGE_BACKGROUND_COLOR,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: MARGIN_MEDIUM_2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      MARGIN_MEDIUM_X),
                  color: PRIMARY_COLOR_1),
              child: Row(
                children: [
                  Badge(
                    toAnimate: false,
                    position: BadgePosition.topEnd(end: -12),
                    badgeContent: Text(
                      "${count}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: MARGIN_MEDIUM,
                          fontWeight: FontWeight.bold),
                    ),
                    elevation: 0,
                    child: Image.asset("assets/images/foodAndBeverage.png"),
                  ),
                  const SizedBox(width: MARGIN_MEDIUM_X),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/images/down.png",
                      width: MARGIN_LARGE,
                      height: MARGIN_LARGE,
                      color: APPBAR_COLOR,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${total}Ks",
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: TEXT_REGULAR_2X,
                        color: APPBAR_COLOR),
                  ),
                  const SizedBox(width: MARGIN_MEDIUM_X),
                  GestureDetector(
                    onTap: () =>widget.onTapNavigateCheckout(),
                    child: Image.asset(
                      "assets/images/right_arrow.png",
                      color: APPBAR_COLOR,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
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
  final List<Map<String, dynamic>> selectedSnacks;
  final String location;
  final Function(String, List<Map<String, dynamic>>, int, int) onTapShowBottom;
  late int count;
  late int total;
  final Function onTapNavigate;

  FloatingButtonBottomSheetButtonView(this.selectedSnacks, this.onTapShowBottom,
      this.location, this.count, this.total, this.onTapNavigate);

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
        setState(() {
          showBottom();

          int tempCount = 0;
          for (int i = 0; i < widget.selectedSnacks.length; i++) {
            tempCount =
                (tempCount + widget.selectedSnacks.elementAt(i)['qty']).toInt();
            //tempCount=count;
            //total = (total+selectedSnacks.elementAt(i)['price']).toInt();
          }
          widget.count = tempCount.toInt();

          widget.total = 0;
          for (int i = 0; i < widget.selectedSnacks.length; i++) {
            widget.total = (widget.total +
                    (widget.selectedSnacks.elementAt(i)['price'] *
                        widget.selectedSnacks.elementAt(i)['qty'] *
                        1000))
                .toInt();
          }

          widget.onTapShowBottom(widget.location, widget.selectedSnacks,
              widget.count, widget.total);
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
                      // widget.total = 0;
                      // for (int i = 0; i < widget.selectedSnacks.length; i++) {
                      //   widget.total = (widget.total +
                      //       (widget.selectedSnacks.elementAt(i)['price'] *
                      //           widget.selectedSnacks.elementAt(i)['qty'] *
                      //           1000))
                      //       .toInt();
                      // }
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

                      widget.selectedSnacks.elementAt(index)['qty'] =
                          minusCount;
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
                          onTap: () {
                            setState(() {
                              int tempCount = 0;
                              for (int i = 0;
                                  i < widget.selectedSnacks.length;
                                  i++) {
                                tempCount = (tempCount +
                                        widget.selectedSnacks
                                            .elementAt(i)['qty'])
                                    .toInt();
                                //tempCount=count;
                                //total = (total+selectedSnacks.elementAt(i)['price']).toInt();
                              }
                              widget.count = tempCount.toInt();

                              widget.total = 0;
                              for (int i = 0;
                                  i < widget.selectedSnacks.length;
                                  i++) {
                                widget.total = (widget.total +
                                        (widget.selectedSnacks
                                                .elementAt(i)['price'] *
                                            widget.selectedSnacks
                                                .elementAt(i)['qty'] *
                                            1000))
                                    .toInt();
                              }

                              widget.onTapShowBottom(
                                  widget.location,
                                  widget.selectedSnacks,
                                  widget.count,
                                  widget.total);
                              widget.selectedSnacks.forEach((items) {
                                debugPrint(
                                    "On Tap Snack===>${items.toString()}");
                              });
                              Navigator.pop(context);
                            });
                          },
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
    return Badge(
      toAnimate: false,
      position: BadgePosition.topEnd(end: -12),
      badgeContent: Text(
        "${widget.foodCount}",
        style: TextStyle(
            color: Colors.white,
            fontSize: MARGIN_MEDIUM,
            fontWeight: FontWeight.bold),
      ),
      child: Image.asset("assets/images/foodAndBeverage.png"),
      elevation: 0,
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

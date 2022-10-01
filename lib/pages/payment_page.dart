import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:the_movie_booking_app/data/models/data_model.dart';
import 'package:the_movie_booking_app/data/models/data_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/time_slot_vo.dart';
import 'package:the_movie_booking_app/pages/ticket_confirmation_splash_screen_page.dart';
import 'package:toast/toast.dart';
import '../data/vos/checkout_snack_vo.dart';
import '../data/vos/cinema_and_show_time_slots_vo.dart';
import '../data/vos/cinema_vo.dart';
import '../data/vos/payment_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewers/payment_type_view.dart';

class PaymentPage extends StatefulWidget {
  final String location;
  final int movieId;
  final CinemaVO? cinema;
  final TimeSlotVO? cinemaDayTimeSlot;
  final String date;
  final String seatNo;
  late List<SnackVO>? snackList;
  final int totalAmount;
  PaymentPage(this.location, this.movieId, this.cinema, this.cinemaDayTimeSlot,
      this.date, this.seatNo, this.snackList, this.totalAmount);

  @override
  State<PaymentPage> createState() => _PaymentPageState();

}


class _PaymentPageState extends State<PaymentPage> {

  DataModel dDataModel = DataModelImpl();

  List<PaymentVO>? paymentList;
  List<SnackVO>? snackVO;
  String? userName;
  @override
  void initState() {
    super.initState();

    for (int i = 0; i < (widget.snackList?.length ?? 0); i++) {
      snackVO?[i].id = (widget.snackList?[i].id);
      snackVO?[i].quantity = (widget.snackList?[i].quantity);
    }

    ///Get Payment List
    dDataModel.getPaymentTypes()?.then((payment) {
      setState(() {
        paymentList = payment;
        debugPrint(paymentList?[0].title.toString());
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
    debugPrint(widget.totalAmount.toString());
  }

  final myController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }
  _showToast(String msg){
    showToast(
      msg,
      context: context,
      duration: const Duration(seconds: 3),
      animation: StyledToastAnimation.slideToRightFade,
      position: StyledToastPosition.bottom,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: APPBAR_COLOR,
        title: const Text(
          PAYMENT_PAGE_TITLE,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: TEXT_REGULAR_4X,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: MARGIN_xXLARGE,
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 1,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: MARGIN_XXLARGE,
                    right: MARGIN_XXLARGE,
                    top: MARGIN_XxlLARGE),
                child: TextFormField(
                  controller: myController,
                  style: const TextStyle(color: DASH_COLOR_2),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: INPUT_NAME_HINT_TEXT,
                    fillColor: DASH_COLOR_2,
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: TEXT_REGULAR,
                        color: DASH_COLOR_2),
                    labelText: NAME_TEXT,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: TEXT_REGULAR,
                        color: PRIMARY_COLOR_1),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                      borderSide: const BorderSide(
                        color: PRIMARY_COLOR_1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: MARGIN_XLARGE),
              PromoCodeView(),
              const SizedBox(height: MARGIN_XxlLARGE),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: PaymentSectionView(
                  paymentList: paymentList ?? [],
                  onTapPayment: (location, paymentId) {

                    userName = myController.text;
                    if(userName==""){
                      _showToast("Please Enter Your Name");
                    }else{
                      widget.snackList=[SnackVO(0, "", "", 0, 0, "", 0, 0, 0)];
                      dDataModel.postCheckout(
                          userName ?? "",
                          widget.cinemaDayTimeSlot?.cinemaDayTimeslotsId ?? 0,
                          "G-3",
                          widget.date,
                          widget.movieId,
                          paymentId,
                          widget.snackList ?? [])?.then((response) {
                        if(response.code==200){
                          debugPrint("Code Success!");
                          _navigateToTicketConfirmationSplashScreenPage(
                              context, location);
                        }else if(response.code==400){
                          _showToast("Your Seats are not available!");
                        }
                      }).catchError((error){
                        debugPrint("Check Out Error===>$error");

                      });
                    }
                  },
                  location: widget.location,
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }


  void _navigateToTicketConfirmationSplashScreenPage(
          BuildContext context, location) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TicketConfirmationSplashScreenPage(
              cinema: widget.cinema, location: location),
        ),
      );
}

class PaymentSectionView extends StatelessWidget {
  const PaymentSectionView({
    Key? key,
    required this.paymentList,
    required this.onTapPayment,
    required this.location,
  }) : super(key: key);

  final List<PaymentVO>? paymentList;
  final Function(String, int) onTapPayment;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChoosePaymentTextView(),
        const SizedBox(height: MARGIN_MEDIUM_3),
        Container(
          height: PAYMENT_TYPE_VIEW_HEIGHT,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: paymentList?.length,
              itemBuilder: (BuildContext context, int index) {
                return PaymentTypeView(paymentList?[index],
                    (paymentId) => onTapPayment(location, paymentId));
              }),
        )
      ],
    );
  }
}

class ChoosePaymentTextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      PAYMENT_TEXT,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: TEXT_REGULAR_2Xx,
          color: PRIMARY_COLOR_1),
    );
  }
}

class PromoCodeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_XXLARGE),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR_1,
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_XXLARGE,
          vertical: MARGIN_CARD_MEDIUM_2,
        ),
        child: Row(
          children: [
            Image.asset("assets/images/percentIcon.png"),
            const SizedBox(width: MARGIN_CARD_MEDIUM_2),
            const Text(
              PROMOCODE_TEXT,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: TEXT_REGULAR,
                  color: APPBAR_COLOR),
            ),
          ],
        ),
      ),
    );
  }
}

class InputNameView extends StatefulWidget {
  const InputNameView({
    Key? key,
    required this.getName,
  }) : super(key: key);
  final Function(String) getName;

  @override
  State<InputNameView> createState() => _InputNameViewState();
}

class _InputNameViewState extends State<InputNameView> {
  final myController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    myController.dispose();
    setState(() {
      widget.getName(myController.text);
    });
  }

  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      style: const TextStyle(color: DASH_COLOR_2),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: INPUT_NAME_HINT_TEXT,
        fillColor: DASH_COLOR_2,
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: TEXT_REGULAR,
            color: DASH_COLOR_2),
        labelText: NAME_TEXT,
        labelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: TEXT_REGULAR,
            color: PRIMARY_COLOR_1),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
          borderSide: const BorderSide(
            color: PRIMARY_COLOR_1,
          ),
        ),
      ),
    );
  }
}

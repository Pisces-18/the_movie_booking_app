import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/ticket_confirmation_splash_screen_page.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/payment_type_view.dart';

class PaymentPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        color: PAGE_BACKGROUND_COLOR,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: MARGIN_XXLARGE,right: MARGIN_XXLARGE,top: MARGIN_XxlLARGE),
                child: InputNameView(),
              ),
              const SizedBox(height: MARGIN_XLARGE),
              PromoCodeView(),
              const SizedBox(height: MARGIN_XxlLARGE),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: PaymentSectionView(
                  paymentList: paymentList,
                  onTapPayment: () =>
                      _navigateToTicketConfirmationSplashScreenPage(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToTicketConfirmationSplashScreenPage(BuildContext context) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TicketConfirmationSplashScreenPage(),
        ),
      );
}

class PaymentSectionView extends StatelessWidget {
  const PaymentSectionView({
    Key? key,
    required this.paymentList,
    required this.onTapPayment,
  }) : super(key: key);

  final List<Map<String, dynamic>> paymentList;
  final Function onTapPayment;

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
              itemCount: paymentList.length,
              itemBuilder: (BuildContext context, int index) {
                return PaymentTypeView(
                    paymentList, index, () => onTapPayment());
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

class InputNameView extends StatelessWidget {
  const InputNameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: INPUT_NAME_HINT_TEXT,
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: TEXT_REGULAR,
            color: DASH_COLOR_2),
        labelText: NAME_TEXT,
        labelStyle:const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: TEXT_REGULAR,
          color: PRIMARY_COLOR_1),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
          borderSide: const BorderSide(color: PRIMARY_COLOR_1,),),

      ),
    );
  }
}

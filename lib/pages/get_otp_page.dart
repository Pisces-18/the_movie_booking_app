import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_booking_app/pages/location_page.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/login_logo_and_text_view.dart';

class GetOTPPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: APPBAR_COLOR,
        leading: GestureDetector(
          onTap: ()=>Navigator.pop(context),
          child: Image.asset(
            "assets/images/leftIcon.png",
            width: MARGIN_LARGE,
            height: MARGIN_LARGE,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: MARGIN_XLARGE),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height/2.4,
                  child: LoginLogoAndTextView(OTP_CODE_TEXT_1, OTP_CODE_TEXT_2)),

              OTPCodeSectionView(
                  codeList, () => _navigateToLocationPage(context)),
               SizedBox(height: MediaQuery.of(context).size.height/6),
              PrivacyPolicyTextView(),

            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToLocationPage(BuildContext context) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationPage()));
  }
}

class PrivacyPolicyTextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        PRIVACY_POLICY_TEXT,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: TEXT_SMALL,
          color: PRIVACY_POLICY_TEXT_COLOR,
        ),
      ),
    );
  }
}

class OTPCodeSectionView extends StatelessWidget {
  final List<int> codeList;
  final Function onPressedConfirm;
  OTPCodeSectionView(
    this.codeList,
    this.onPressedConfirm,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        OTPCodeTitleTextView(),
        const SizedBox(height: MARGIN_MEDIUM),
        Wrap(
          children: codeList
              .map(
                (code) => OTPCodeChipView(code),
              )
              .toList(),
        ),
        const SizedBox(height: MARGIN_XXLARGE),
        Align(
          alignment: Alignment.center,
          child: ResendOTPCodeTextView(),
        ),
        const SizedBox(height: MARGIN_XXLARGE),
        ConfirmOTPButtonView(() => onPressedConfirm()),
      ],
    );
  }
}

class ConfirmOTPButtonView extends StatelessWidget {
  final Function onPressedConfirm;
  ConfirmOTPButtonView(this.onPressedConfirm);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXxxLARGE,
      width: OTP_CODE_BUTTON_WIDTH,
      child: TextButton(
        onPressed: () => onPressedConfirm(),
        style: TextButton.styleFrom(
            backgroundColor: PRIMARY_COLOR_1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_XXXXXLARGE,
            vertical: MARGIN_MEDIUM,
          ),
          child: Text(
            OTP_CODE_TEXT_6,
            style: GoogleFonts.inter(
              textStyle: Theme.of(context).textTheme.bodySmall,
              fontWeight: FontWeight.w400,
              fontSize: TEXT_REGULAR_2X,
              color: APPBAR_COLOR,
            ),
          ),
        ),
      ),
    );
  }
}

class ResendOTPCodeTextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: OTP_CODE_TEXT_4,
            style: GoogleFonts.inter(
              textStyle: Theme.of(context).textTheme.labelMedium,
              fontWeight: FontWeight.w400,
              fontSize: TEXT_REGULAR_2X,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: OTP_CODE_TEXT_5,
            style: GoogleFonts.inter(
              textStyle: Theme.of(context).textTheme.labelMedium,
              fontWeight: FontWeight.w400,
              fontSize: TEXT_REGULAR_2X,
              color: PRIMARY_COLOR_1,
            ),
          ),
        ],
      ),
    );
  }
}

class OTPCodeChipView extends StatelessWidget {
  final int code;
  OTPCodeChipView(this.code);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Chip(
          padding: const EdgeInsets.all(MARGIN_CARD_MEDIUM_2L_X),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MARGIN_SMALL),
          ),
          label: Text(
            code.toString(),
            style: GoogleFonts.dmSans(
              textStyle: Theme.of(context).textTheme.labelMedium,
              fontWeight: FontWeight.w500,
              fontSize: TEXT_REGULAR,
              color: PRIVACY_POLICY_TEXT_COLOR,
            ),
          ),
        ),
        const SizedBox(width: MARGIN_SMALL_LX),
      ],
    );
  }
}

class OTPCodeTitleTextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Text(
      OTP_CODE_TEXT_3,
      style: GoogleFonts.dmSans(
        textStyle: Theme.of(context).textTheme.labelMedium,
        fontWeight: FontWeight.w400,
        fontSize: TEXT_REGULAR,
        color: OTP_CODE_TEXT_COLOR,
      ),
    );
  }
}

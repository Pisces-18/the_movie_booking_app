import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_booking_app/data/models/data_model.dart';
import 'package:the_movie_booking_app/data/models/data_model_impl.dart';
import 'package:the_movie_booking_app/pages/location_page.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/login_logo_and_text_view.dart';

class GetOTPPage extends StatefulWidget {
  final String phone;
  GetOTPPage(this.phone);
  @override
  State<GetOTPPage> createState() => _GetOTPPageState();
}

class _GetOTPPageState extends State<GetOTPPage> {
  DataModel dDataModel = DataModelImpl();
  String? message;

  @override
  // void initState(){
  //   super.initState();
  //
  //  setState((){
  //    Fluttertoast.showToast(msg: "OTP code was sent",  toastLength: Toast.LENGTH_SHORT,timeInSecForIosWeb: 1,gravity: ToastGravity.CENTER,textColor: Colors.white,fontSize: TEXT_REGULAR_2X);
  //  });
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: APPBAR_COLOR,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
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
                  height: MediaQuery.of(context).size.height / 2.4,
                  child:
                      LoginLogoAndTextView(OTP_CODE_TEXT_1, OTP_CODE_TEXT_2)),
              OTPCodeSectionView(codeList, (otp) {
                debugPrint("OTP Code===>$otp");
                setState(() {
                  dDataModel
                      .signInWithPhone(widget.phone, int.parse(otp))
                      ?.then((user) {
                    if (user.message == "Success") {
                      debugPrint("Token===>${user.token}");
                      _navigateToLocationPage(context);
                    }
                  }).catchError((error) {
                    debugPrint("Token Errors===>$error");
                  });
                });
              }),
              SizedBox(height: MediaQuery.of(context).size.height / 6),
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

class OTPCodeSectionView extends StatefulWidget {
  final List<int> codeList;
  final Function(String) onPressedConfirm;
  OTPCodeSectionView(
    this.codeList,
    this.onPressedConfirm,
  );

  @override
  State<OTPCodeSectionView> createState() => _OTPCodeSectionViewState();
}

class _OTPCodeSectionViewState extends State<OTPCodeSectionView> {
  final _otpController1 = TextEditingController();
  final _otpController2 = TextEditingController();
  final _otpController3 = TextEditingController();
  final _otpController4 = TextEditingController();
  final _otpController5 = TextEditingController();
  final _otpController6 = TextEditingController();
  late String otp;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        OTPCodeTitleTextView(),
        const SizedBox(height: MARGIN_MEDIUM),
        Wrap(
          children: [
            Chip(
                padding: const EdgeInsets.all(MARGIN_MEDIUM),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MARGIN_SMALL),
                ),
                label: Container(
                  width: 20,
                  height: 35,
                  child: TextField(
                    controller: _otpController1,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                          1), //n is maximum number of characters you want in textfield
                    ],
                    style: const TextStyle(color: OTP_CODE_TEXT_COLOR),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      //contentPadding: EdgeInsets.symmetric(vertical: -1),

                      filled: false,
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: TEXT_REGULAR_2X,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                )),
            const SizedBox(width: MARGIN_MEDIUM),
            Chip(
                padding: const EdgeInsets.all(MARGIN_MEDIUM),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MARGIN_SMALL),
                ),
                label: Container(
                  width: 20,
                  height: 35,
                  child: TextField(
                    controller: _otpController2,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                          1), //n is maximum number of characters you want in textfield
                    ],
                    style: const TextStyle(color: OTP_CODE_TEXT_COLOR),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      //contentPadding: EdgeInsets.symmetric(vertical: -1),

                      filled: false,
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: TEXT_REGULAR_2X,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                )),
            const SizedBox(width: MARGIN_MEDIUM),
            Chip(
                padding: const EdgeInsets.all(MARGIN_MEDIUM),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MARGIN_SMALL),
                ),
                label: Container(
                  width: 20,
                  height: 35,
                  child: TextField(
                    controller: _otpController3,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                          1), //n is maximum number of characters you want in textfield
                    ],
                    style: const TextStyle(color: OTP_CODE_TEXT_COLOR),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      //contentPadding: EdgeInsets.symmetric(vertical: -1),

                      filled: false,
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: TEXT_REGULAR_2X,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                )),
            const SizedBox(width: MARGIN_MEDIUM),
            Chip(
                padding: const EdgeInsets.all(MARGIN_MEDIUM),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MARGIN_SMALL),
                ),
                label: Container(
                  width: 20,
                  height: 35,
                  child: TextField(
                    controller: _otpController4,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                          1), //n is maximum number of characters you want in textfield
                    ],
                    style: const TextStyle(color: OTP_CODE_TEXT_COLOR),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      //contentPadding: EdgeInsets.symmetric(vertical: -1),

                      filled: false,
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: TEXT_REGULAR_2X,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                )),
            const SizedBox(width: MARGIN_MEDIUM),
            Chip(
                padding: const EdgeInsets.all(MARGIN_MEDIUM),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MARGIN_SMALL),
                ),
                label: Container(
                  width: 20,
                  height: 35,
                  child: TextField(
                    controller: _otpController5,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                          1), //n is maximum number of characters you want in textfield
                    ],
                    style: const TextStyle(color: OTP_CODE_TEXT_COLOR),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      //contentPadding: EdgeInsets.symmetric(vertical: -1),

                      filled: false,
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: TEXT_REGULAR_2X,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                )),
            const SizedBox(width: MARGIN_MEDIUM),
            Chip(
                padding: const EdgeInsets.all(MARGIN_MEDIUM),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MARGIN_SMALL),
                ),
                label: Container(
                  width: 20,
                  height: 35,
                  child: TextField(
                    controller: _otpController6,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                          1), //n is maximum number of characters you want in textfield
                    ],
                    style: const TextStyle(color: OTP_CODE_TEXT_COLOR),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      //contentPadding: EdgeInsets.symmetric(vertical: -1),

                      filled: false,
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: TEXT_REGULAR_2X,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                )),
          ],
        ),
        const SizedBox(height: MARGIN_XXLARGE),
        Align(
          alignment: Alignment.center,
          child: ResendOTPCodeTextView(),
        ),
        const SizedBox(height: MARGIN_XXLARGE),
        ConfirmOTPButtonView(() {
          setState(() {
            otp =
                "${_otpController1.text}${_otpController2.text}${_otpController3.text}${_otpController4.text}${_otpController5.text}${_otpController6.text}";
          });
          widget.onPressedConfirm(otp);
        }),
      ],
    );
  }
}

class ConfirmOTPButtonView extends StatefulWidget {
  final Function onPressedConfirm;
  ConfirmOTPButtonView(this.onPressedConfirm);

  @override
  State<ConfirmOTPButtonView> createState() => _ConfirmOTPButtonViewState();
}

class _ConfirmOTPButtonViewState extends State<ConfirmOTPButtonView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXxxLARGE,
      width: OTP_CODE_BUTTON_WIDTH,
      child: TextButton(
        onPressed: () => widget.onPressedConfirm(),
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
    return Text(
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_booking_app/pages/get_otp_page.dart';
import 'package:the_movie_booking_app/pages/location_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/login_logo_and_text_view.dart';

class LoginPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      body: Container(
        height: MediaQuery.of(context).size.height,
          padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height/2.3,
                child: LoginLogoAndTextView(
                    VERIFY_PHONE_NUMBER_TEXT, ANNOUNCE_TO_SEND_SMS_CODE),
              ),
              //const SizedBox(height: MARGIN_XXXLARGE),
              PhoneNumberSectionView(
                  countryCodeList, () => _navigateToGetOTPPge(context)),
              const SizedBox(height: MARGIN_xXLARGE),
              DividerView(),
              const SizedBox(height: MARGIN_xXLARGE),
              GoogleButtonTextView(()=>_navigateToLocationPage(context)),
               SizedBox(height: MediaQuery.of(context).size.height/10),
              PrivacyPolicyTextView(),

            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToLocationPage(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationPage()));

  Future<dynamic> _navigateToGetOTPPge(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GetOTPPage(),
        ),
      );
}

class PrivacyPolicyTextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(
        PRIVACY_POLICY_TEXT,
        style: GoogleFonts.dmSans(
          textStyle: Theme.of(context).textTheme.bodySmall,
          fontWeight: FontWeight.w700,
          fontSize: TEXT_SMALL,
          color: PRIVACY_POLICY_TEXT_COLOR,
        ),
      ),
    );
  }
}

class GoogleButtonTextView extends StatelessWidget {
  final Function onPressedGoogle;
  GoogleButtonTextView(this.onPressedGoogle);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3LX),
      height: MARGIN_XXXLARGE,
      child: TextButton(
        onPressed: ()=>onPressedGoogle(),
        style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(

            vertical: MARGIN_MEDIUM,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/google.png"),
              const SizedBox(width: MARGIN_MEDIUM_X),
              const Text(
                GOOLE_BUTTON_TEXT,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: TEXT_REGULAR_2X,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DividerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3LX),
      child: Stack(
        children: [
          const Positioned.fill(
            child: Divider(
              color: DASH_COLOR_2,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: MARGIN_MEDIUM_3,
              ),
              decoration: BoxDecoration(
                  color: PAGE_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.circular(MARGIN_XXXLARGE)),
              child: const Text(
                OR_TEXT,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: TEXT_REGULAR_2X,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PhoneNumberSectionView extends StatefulWidget {
  final List<String> countryCodeList;
  final Function onPressedButton;
  PhoneNumberSectionView(this.countryCodeList, this.onPressedButton);

  @override
  State<PhoneNumberSectionView> createState() => _PhoneNumberSectionViewState();
}

class _PhoneNumberSectionViewState extends State<PhoneNumberSectionView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3LX),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          CountryCodeTextView(),
          const SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: [
              CountryCodeDropDownView(widget.countryCodeList),
              const SizedBox(width: MARGIN_MEDIUM_2X),
              InputPhoneNumberTextFieldView(),
            ],
          ),
          const SizedBox(height: MARGIN_XxLARGE),
          VerifyPhoneNumberButtonView(() => widget.onPressedButton())
        ],
      ),
    );
  }
}

class CountryCodeTextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      COUNTRY_CODE_TEXT,
      style: GoogleFonts.inter(
        textStyle: Theme.of(context).textTheme.bodySmall,
        fontWeight: FontWeight.w400,
        fontSize: TEXT_SMALL,
        color: SMS_CODE_COLOR,
      ),

    );
  }
}

class CountryCodeDropDownView extends StatefulWidget {
  final List<String> countryCodeList;
  CountryCodeDropDownView(this.countryCodeList);
  String dropDownValue = "+95";

  @override
  State<CountryCodeDropDownView> createState() =>
      _CountryCodeDropDownViewState();
}

class _CountryCodeDropDownViewState extends State<CountryCodeDropDownView> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      elevation: 0,
      dropdownColor: APPBAR_COLOR,
      value: widget.dropDownValue,
      style: GoogleFonts.inter(
          textStyle: Theme.of(context).textTheme.bodySmall,
          color: Colors.white,
          fontSize: TEXT_REGULAR_2X,
          fontWeight: FontWeight.w400),
      onChanged: (String? newValue) {
        setState(() {
          widget.dropDownValue = newValue!;
        });
      },
      items: widget.countryCodeList
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
    );
  }
}

class InputPhoneNumberTextFieldView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_xXLARGE,
      width: MediaQuery.of(context).size.width / 1.4,
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            hintText: PHONE_NUMBER_HINT_TEXT,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: TEXT_REGULAR_2X,
              color: SMS_CODE_COLOR,
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            ))),
      ),
    );
  }
}

class VerifyPhoneNumberButtonView extends StatelessWidget {
  final Function onPressedButton;
  VerifyPhoneNumberButtonView(this.onPressedButton);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXxxLARGE,
      child: TextButton(
        onPressed: () => onPressedButton(),
        style: TextButton.styleFrom(
            backgroundColor: PRIMARY_COLOR_1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
            )),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MARGIN_XXXXXLARGE,
            vertical: MARGIN_MEDIUM,
          ),
          child: Text(
            PHONE_NUMBER_TEXT_BUTTON_TEXT,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: TEXT_REGULAR_2X,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

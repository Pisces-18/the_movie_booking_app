import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class LoginLogoAndTextView extends StatelessWidget {
  final String title;
  final String text;
  LoginLogoAndTextView(this.title, this.text);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            "assets/images/Logo.png",
          ),
        ),
         SizedBox(height: MediaQuery.of(context).size.height/10),
        Center(
          child: Text(
            title,
            style: GoogleFonts.dmSans(
              textStyle: Theme.of(context).textTheme.headlineSmall,
              fontWeight: FontWeight.w500,
              fontSize: TEXT_REGULAR_4X,
              color: Colors.white,
            ),

          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_X),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Text(text,
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  textStyle: Theme.of(context).textTheme.bodySmall,
                  fontWeight: FontWeight.w400,
                  fontSize: TEXT_REGULAR,
                  color: SMS_CODE_COLOR,
                )

                ),
          ),
        ),
      ],
    );
  }
}

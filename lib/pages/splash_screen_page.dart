import 'dart:async';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_booking_app/pages/login_page.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height / 1,
        padding: const EdgeInsets.only(top: 250),
        color: PAGE_BACKGROUND_COLOR,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,

              child: Padding(
                padding: const EdgeInsets.only(top: MARGIN_XXXLARGE),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/Logo.png",
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "C ",
                            style: GoogleFonts.inter(
                              textStyle: Theme.of(context).textTheme.bodySmall,
                              fontWeight: FontWeight.w600,
                              color: PRIMARY_COLOR_1,
                              fontSize: TEXT_REGULAR_3X,
                            )),
                        TextSpan(
                            text: "cinema",
                            style: GoogleFonts.inter(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontWeight: FontWeight.w600,
                              color: PRIMARY_COLOR_2,
                              fontSize: TEXT_REGULAR_3X,
                            ))
                      ]),
                    ),
                  ],
                ),
              ),


            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: MARGIN_MEDIUM_X),
                child: DotsIndicator(
                  dotsCount: 4,
                  position: 0,
                  decorator: const DotsDecorator(
                    activeColor: PRIMARY_COLOR_1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

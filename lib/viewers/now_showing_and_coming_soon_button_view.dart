import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class NowShowingAndComingSoonButtonView extends StatefulWidget {
  const NowShowingAndComingSoonButtonView({Key? key, required this.onPressedButton, required this.text}) : super(key: key);
  final Function(int) onPressedButton;
  final String text;

  @override
  State<NowShowingAndComingSoonButtonView> createState() => _NowShowingAndComingSoonButtonViewState();
}

class _NowShowingAndComingSoonButtonViewState extends State<NowShowingAndComingSoonButtonView> {

  int index=0;
  String testString=NS_BUTTON_TEXT;
  Color bgColor=Colors.transparent;

  @override
  void initState(){
    super.initState();
    setState(() {
      index = 0;
      widget.onPressedButton(index);
      testString=widget.text;
      (testString==widget.text) ? bgColor=PRIMARY_COLOR_1:Colors.transparent;
      // changeColorNS = true;
      // changeColorCS = false;
      // widget.changeColorCS(changeColorCs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        setState((){
          index = 0;
          widget.onPressedButton(index);
          testString=widget.text;
          (testString==widget.text) ? bgColor=PRIMARY_COLOR_1:Colors.transparent;
        });
      },
      style: TextButton.styleFrom(
        backgroundColor:bgColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MARGIN_XxLARGE),
        child: Text(
          widget.text,
          style: GoogleFonts.dmSans(
            textStyle: Theme.of(context).textTheme.headlineSmall,
            fontWeight: FontWeight.w700,
            fontSize: TEXT_REGULAR_2X,
            color: BUTTON_TEXT_COLOR_NS,
          ),
        ),
      ),
    );
  }
}

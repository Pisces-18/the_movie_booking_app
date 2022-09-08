import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class TicketConcelionPolicyDialogBoxView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: APPBAR_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
      ),
      title: const Text(
        TICKET_CACELATION_POLICY_TEXT,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: TEXT_REGULAR,
          color: Colors.white,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: MARGIN_CARD_MEDIUM_2,right: MARGIN_CARD_MEDIUM_2,bottom: MARGIN_CARD_MEDIUM_2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconAndTextView("assets/images/foodAndBeverage.png","100% Refund on F&B"),
              IconAndTextView("assets/images/ticket.png","Up to 75% Refund for Tickets"),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_xXLARGE),
                child: Column(
                  children: [
                    TermsTextView("-75% refund until 2 hours before show start time"),
                    const SizedBox(height: MARGIN_MEDIUM_X),
                    TermsTextView("-50% refund between 2 hours and 20 minutes before show start time"),
                  ],
                ),
              ),
              const SizedBox(height: MARGIN_XXLARGE),
              TermsRuleTextView("1. Refund not available for Convenience fees,Vouchers, Gift Cards, Taxes etc."),
              const SizedBox(height: MARGIN_MEDIUM_3),
              TermsRuleTextView("2. No cancelation within 20minute of show start time."),
              const SizedBox(height: MARGIN_XLARGE),
              CloseButtonView()
            ],
          ),
        ),
      ],
    );
  }
}

class CloseButtonView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ()=>Navigator.pop(context),
      style: TextButton.styleFrom(
          backgroundColor: PRIMARY_COLOR_1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM)
          )
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 115),
        child: Text(
          CLOSE_BUTTON_TEXT,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: TEXT_REGULAR_2X,
            color: APPBAR_COLOR,
          ),
        ),
      ),
    );
  }
}

class TermsRuleTextView extends StatelessWidget {
  final String text;
  TermsRuleTextView(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: TEXT_REGULAR,
        color: Colors.white,
      ),
    );
  }
}

class TermsTextView extends StatelessWidget {
 final String text;
 TermsTextView(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: TEXT_REGULAR,
        color: SMS_CODE_COLOR,
      ),
    );
  }
}

class IconAndTextView extends StatelessWidget {
 final String logo;
 final String text;
 IconAndTextView(this.logo,this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              logo,
              color: Colors.white,
              height: MARGIN_MEDIUM_2X,
            ),
            const SizedBox(width: MARGIN_MEDIUM_X),
             Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: TEXT_REGULAR_2X,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: MARGIN_CARD_MEDIUM_2L_X),
      ],
    );
  }
}

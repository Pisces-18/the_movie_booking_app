import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class ProfileListView extends StatelessWidget {
  final String text;
  final String logo;
  ProfileListView(this.text, this.logo);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: MARGIN_MEDIUM_2,
        right: MARGIN_MEDIUM_2,
        top: MARGIN_MEDIUM_2,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                logo,
                color: Colors.white,
                height: MARGIN_LARGE,
                width: MARGIN_LARGE,
              ),
              const SizedBox(width: MARGIN_MEDIUM_X),
              Text(
                text,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: TEXT_REGULAR,
                    color: Colors.white),
              ),
              const Spacer(),
              Image.asset(
                "assets/images/right_arrow.png",
                color: DASH_COLOR_2,
              )
            ],
          ),
          const SizedBox(height: MARGIN_MEDIUM_2),
          const Divider(
            color: PROFILE_DIVIDER_COLOR,
            thickness: 1,
          )
        ],
      ),
    );
  }
}

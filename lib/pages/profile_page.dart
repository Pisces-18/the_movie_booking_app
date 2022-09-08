import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/login_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/widgets/profile_list_view.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/bottom_navigation_bar_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height/1,
        padding: const EdgeInsets.only(
          top: MARGIN_xXLARGE,
        ),
        color: PAGE_BACKGROUND_COLOR,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: PROFIL_IMAGE_HEIGHT,
                child: ProfileImageAndLoginButtonSectionView(
                    () => _navigateToLoginPage(context)),
              ),
              const SizedBox(height: MARGIN_xxLARGE),
              ProfileListSectionView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarView(3),
    );
  }

  Future<dynamic> _navigateToLoginPage(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
}

class ProfileListSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileListView(PROFILE_PURCHASE_TEXT, PROFILE_PURCHASE_ICON),
        ProfileListView(PROFILE_OFFER_TEXT, PROFILE_OFFER_ICON),
        ProfileListView(PROFILE_GIFTCARD_TEXT, PROFILE_GIFTCARD_ICON),
        ProfileListView(PROFILE_LOCATION_TEXT, PROFILE_LOCATION_ICON),
        ProfileListView(PROFILE_PAYMENT_TEXT, PROFILE_PAYMENT_ICON),
        ProfileListView(PROFILE_HELP_TEXT, PROFILE_HELP_ICON),
        ProfileListView(PROFILE_LOGOUT_TEXT, PROFILE_LOGOUT_ICON),
      ],
    );
  }
}

class ProfileImageAndLoginButtonSectionView extends StatelessWidget {
  final Function onTapLogin;
  ProfileImageAndLoginButtonSectionView(this.onTapLogin);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: ProfileImageView(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: LoginImageAndButtonView(() => onTapLogin()),
        ),
      ],
    );
  }
}

class LoginImageAndButtonView extends StatelessWidget {
  final Function onTapLogin;
  LoginImageAndButtonView(this.onTapLogin);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: MARGIN_XXLARGE),
      child: Column(
        children: [
          Image.asset("assets/images/profileLogo.png"),
          TextButton(
            onPressed: () => onTapLogin(),
            style: TextButton.styleFrom(
                backgroundColor: LOGIN_BUTTON_COLOR,
                side: const BorderSide(
                  color: PRIMARY_COLOR_1,
                )),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MARGIN_XXLARGE,
              ),
              child: Text(
                LOGIN_TET,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: TEXT_REGULAR_2X,
                  color: PRIMARY_COLOR_1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileImageView extends StatelessWidget {
  const ProfileImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/profileImage.png",
      fit: BoxFit.cover,
    );
  }
}

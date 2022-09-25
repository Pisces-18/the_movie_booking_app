import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_booking_app/data/models/data_model.dart';
import 'package:the_movie_booking_app/data/models/data_model_impl.dart';
import 'package:the_movie_booking_app/pages/cinema_page.dart';
import 'package:the_movie_booking_app/pages/movie_page.dart';
import 'package:the_movie_booking_app/pages/profile_page.dart';
import 'package:the_movie_booking_app/pages/search_movie_page.dart';
import 'package:the_movie_booking_app/pages/ticket_page.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';

class HomePage extends StatefulWidget {
  String? Location;
  int movieIndex = 0;
  HomePage(this.Location);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? location;
  int _selectedIndex = 0;
  final PageController _myPage = PageController(initialPage: 0);
  DataModel dDataModel=DataModelImpl();

  @override
  void initState() {
    super.initState();
    setState((){
      dDataModel.getSnackCategory();
      debugPrint(DataModelImpl().mSnackCategoryRepository?[0].title);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
        controller: _myPage,
        physics: NeverScrollableScrollPhysics(),
        children: [
          MoviePage(widget.Location ?? ""),
          CinemaPage(widget.Location ?? ""),
          TicketPage(),
          ProfilePage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        //fixedColor: PRIMARY_COLOR_1,
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _myPage.jumpToPage(_selectedIndex);
          });
        },
        selectedIconTheme: const IconThemeData(color: PRIMARY_COLOR_1),
        unselectedIconTheme: const IconThemeData(
          color: SMS_CODE_COLOR,
        ),
        selectedItemColor: PRIMARY_COLOR_1,
        unselectedItemColor: SMS_CODE_COLOR,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: APPBAR_COLOR,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/movies.png")),
            label: "Movies",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/cinema.png")),
            label: "Cinema",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/ticket.png")),
            label: "Ticket",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/profile.png")),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

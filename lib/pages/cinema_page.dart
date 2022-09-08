import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/choose_seat_page.dart';
import 'package:the_movie_booking_app/pages/cinema_info_page.dart';
import 'package:the_movie_booking_app/pages/search_cinema_page.dart';
import 'package:the_movie_booking_app/resources/germs.dart';
import 'package:the_movie_booking_app/viewers/cinema_list_view.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewers/cinema_expansion_view.dart';
import '../widgets/bottom_navigation_bar_view.dart';

class CinemaPage extends StatelessWidget {
  const CinemaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: APPBAR_COLOR,

        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: MARGIN_MEDIUM_3LX,
            ),
            child: GestureDetector(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchCinemaPage())),
                child: Icon(
              Icons.search,
            )),
          ),
        ],
      ),
      body: Container(
        color: PAGE_BACKGROUND_COLOR,
        child: ListView.builder(
          itemCount: cinemaList.length,
            itemBuilder: (BuildContext context,int index){
          return CinemaListView(cinemaList[index], ()=>_navigateToCinemaInfoPage(context));
        }),
      ),
      bottomNavigationBar: BottomNavigationBarView(1),
    );
  }

  Future<dynamic> _navigateToCinemaInfoPage(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context)=>CinemaInfoPage()));

 // Future<dynamic> _navigateToChooseSeatPage(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseSeatPage()));

//  Future<dynamic> _navigateToCinemaInfoPage(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context)=>CinemaInfoPage()));
}

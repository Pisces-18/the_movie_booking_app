// import 'package:flutter/material.dart';
// import 'package:the_movie_booking_app/pages/cinema_info_page.dart';
// import 'package:the_movie_booking_app/pages/cinema_page.dart';
// import 'package:the_movie_booking_app/pages/movie_page.dart';
// import 'package:the_movie_booking_app/pages/profile_page.dart';
// import 'package:the_movie_booking_app/pages/search_cinema_page.dart';
// import 'package:the_movie_booking_app/pages/ticket_page.dart';
// import '../resources/colors.dart';
//
// class BottomNavigationBarView extends StatefulWidget {
//   int selectedIndex;
//   BottomNavigationBarView(this.selectedIndex);
//   @override
//   State<BottomNavigationBarView> createState() =>
//       _BottomNavigationBarViewState();
// }
//
// class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       //fixedColor: PRIMARY_COLOR_1,
//       elevation: 0,
//       currentIndex: widget.selectedIndex,
//       onTap: (index) {
//         setState(() {
//           widget.selectedIndex = index;
//         });
//         switch (index) {
//           case 0:
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => MoviePage("Yangon")));
//             break;
//           case 1:
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => CinemaPage()));
//             break;
//           case 2:
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => TicketPage()));
//             break;
//           case 3:
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => ProfilePage()));
//             break;
//         }
//       },
//       selectedIconTheme: const IconThemeData(color: PRIMARY_COLOR_1),
//       unselectedIconTheme: const IconThemeData(
//         color: SMS_CODE_COLOR,
//       ),
//       selectedItemColor: PRIMARY_COLOR_1,
//       unselectedItemColor: SMS_CODE_COLOR,
//       showUnselectedLabels: true,
//       type: BottomNavigationBarType.fixed,
//       backgroundColor: APPBAR_COLOR,
//       items: const [
//         BottomNavigationBarItem(
//           icon: ImageIcon(AssetImage("assets/images/movies.png")),
//           label: "Movies",
//         ),
//         BottomNavigationBarItem(
//           icon: ImageIcon(AssetImage("assets/images/cinema.png")),
//           label: "Cinema",
//         ),
//         BottomNavigationBarItem(
//           icon: ImageIcon(AssetImage("assets/images/ticket.png")),
//           label: "Ticket",
//         ),
//         BottomNavigationBarItem(
//           icon: ImageIcon(AssetImage("assets/images/profile.png")),
//           label: "Profile",
//         ),
//       ],
//     );
//   }
// }

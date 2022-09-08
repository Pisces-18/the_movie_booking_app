import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/resources/colors.dart';

class DateListViewTestPAge extends StatefulWidget {
  @override
  State<DateListViewTestPAge> createState() => _DateListViewTestPAgeState();
}

class _DateListViewTestPAgeState extends State<DateListViewTestPAge> {
  // final List<String> choices = <String>[
  //   'einmal',
  //   'zweimal',
  //   'dreimal',
  //   'viemal'
  // ];
  final List<Map<String, dynamic>> choices = [
    {
      "image": "assets/images/date1.png",
      "isSelected": true,
    },
    {
      "image": "assets/images/date2.png",
      "isSelected": false,
    },
    {
      "image": "assets/images/date3.png",
      "isSelected": false,
    },
    {
      "image": "assets/images/date4.png",
      "isSelected": false,
    },
  ];

  final String answer = "einmal";

  String selected = "";
  final bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: APPBAR_COLOR,
      ),
      body: Container(
       // padding: EdgeInsets.only(top: 40),
        color: Colors.amber,
        height: 110,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: choices.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selected = choices.elementAt(index)["image"];
                });
              },
              child: Container(
                width: 95,
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Image.asset("${choices.elementAt(index)["image"]}",fit: BoxFit.cover,
                  color: selected == choices.elementAt(index)["image"] ? Colors.black : Colors.green,),
                ),

              ),
            );
          },
        ),
      ),
    );
  }
}

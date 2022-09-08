// import 'package:flutter/cupertino.dart';
//
// import '../resources/colors.dart';
// import '../resources/dimens.dart';
// import '../widgets/available_timing_view.dart';
//
// class GridViewTest extends StatelessWidget {
//   const GridViewTest({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: PAGE_BACKGROUND_COLOR,
//       child: Column(
//         children: [
//           GridView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//
//                 crossAxisCount: 3,
//                 crossAxisSpacing: MARGIN_MEDIUM_3,
//                 mainAxisSpacing: MARGIN_XXLARGE,
//                 mainAxisExtent: 92,
//
//               ),
//               itemCount: 6,
//               itemBuilder: (BuildContext context,int index){
//             return  AvailableTimingView(
//                 "9:30 AM",
//                 "3D",
//                 "Screen 1",
//                 SMS_CODE_COLOR,
//                 PRIMARY_COLOR_3,
//                 SMS_CODE_COLOR,
//                 true,
//                 availableSeat: "21 Available");
//           }),
//         ],
//       ),
//     );
//   }
// }

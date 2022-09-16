import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';

import '../data/vos/movie_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
class MovieSectionView extends StatefulWidget {

  List<MovieVO>? movieList;
  final int dateVisibleIndex;
  final Function(int) onTapMovie;
  MovieSectionView(this.movieList,this.dateVisibleIndex,this.onTapMovie);


  @override
  State<MovieSectionView> createState() => _MovieSectionViewState();
}

class _MovieSectionViewState extends State<MovieSectionView> {
  //List<MovieVO>? movieList;
  @override
  Widget build(BuildContext context) {
    return  Container(

      margin: const EdgeInsets.symmetric(horizontal: MARGIN_SMALL,vertical: MARGIN_xXLARGE),

      child: (widget.movieList != null)?GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: MARGIN_MEDIUM_3L,
            mainAxisSpacing: MARGIN_MEDIUM_3L,
            mainAxisExtent: MOVIE_VIEW_HEIGHT,
          ),
          itemCount: widget.movieList?.length,
          itemBuilder: (BuildContext context, int index){
            return (widget.movieList != null)?ClipRRect(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
              child: SizedBox(
                height: MOVIE_VIEW_HEIGHT,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(MARGIN_MEDIUM),
                            topRight: Radius.circular(MARGIN_MEDIUM)),
                        child: Image.network(
                          "$IMAGE_BASE_URL${widget.movieList?[index].posterPath}",
                          width: 186,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          widget.onTapMovie(widget.movieList?[index].id ?? 0);
                        },
                        child: Container(
                          height: 254,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              //stops: [1,-1],
                              colors: [
                                Colors.transparent,
                                GRADIENT_START_COLOR,
                                GRADIENT_START_COLOR,
                                GRADIENT_END_COLOR,
                                GRADIENT_END_COLOR,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: (widget.dateVisibleIndex == 0) ? false : true,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: MARGIN_SMALL_LX, right: MARGIN_MEDIUM_x),
                          child: Container(
                            height: MOVIE_DATE_HEIGHT,
                            decoration: BoxDecoration(
                              color: PRIMARY_COLOR_1,
                              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: MARGIN_SMALL_LX,
                                  horizontal: MARGIN_MEDIUM_x),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "8th",
                                  ),
                                  Text("AUG"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: MARGIN_SMALL_LX,
                            right: MARGIN_SMALL_LX,
                            bottom: MARGIN_MEDIUM_3LX),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 4,
                                  child: Text(
                                    widget.movieList?[index].title?? "",
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: TEXT_SMALL,
                                        color: Colors.white),
                                  ),
                                ),

                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/imdb.png",
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      widget.movieList?[index].voteAverage.toString()??"",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: TEXT_SMALL,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                            const SizedBox(height: MARGIN_SMALL),
                            Row(
                              children: [
                                Text(
                                  widget.movieList?[index].productionCountries?.first.iso31661 ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: TEXT_SMALL,
                                      color: Colors.white),
                                ),
                                const SizedBox(width: MARGIN_MEDIUM),
                                DotsIndicator(
                                  dotsCount: 1,
                                  decorator:
                                  const DotsDecorator(activeColor: DOTS_COLOR),
                                ),
                                const SizedBox(width: MARGIN_MEDIUM_X),
                                const Expanded(
                                  child: Text(
                                    "2D, 3D, 3D IMAX",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: TEXT_xSMALL,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ):Center(
                child: CircularProgressIndicator());
          }
      ):Center(
          child: CircularProgressIndicator()),


    );
  }
}

// class MovieView extends StatefulWidget {
//   final MovieVO? mMovie;
//   final Function(int) onTapMovie;
//   final int dateVisibleIndex;
//   MovieView(this.mMovie,this.onTapMovie,this.dateVisibleIndex);
//
//   @override
//   State<MovieView> createState() => _MovieViewState();
// }
//
// class _MovieViewState extends State<MovieView> {
//   @override
//   Widget build(BuildContext context) {
//     return  ClipRRect(
//       borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
//       child: SizedBox(
//         height: MOVIE_VIEW_HEIGHT,
//         child: Stack(
//           children: [
//             Text(widget.mMovie?.title.toString()?? "",style: TextStyle(color: Colors.white),),
//             Align(
//               alignment: Alignment.topCenter,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(MARGIN_MEDIUM),
//                     topRight: Radius.circular(MARGIN_MEDIUM)),
//                 child: Image.network(
//                   "$IMAGE_BASE_URL${widget.mMovie?.posterPath}",
//                   width: 186,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Positioned.fill(
//               child: GestureDetector(
//                 onTap: () {
//                   widget.onTapMovie(widget.mMovie?.id ?? 0);
//                 },
//                 child: Container(
//                   height: 254,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       //stops: [1,-1],
//                       colors: [
//                         Colors.transparent,
//                         GRADIENT_START_COLOR,
//                         GRADIENT_START_COLOR,
//                         GRADIENT_END_COLOR,
//                         GRADIENT_END_COLOR,
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Visibility(
//               visible: (widget.dateVisibleIndex == 0) ? false : true,
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       top: MARGIN_SMALL_LX, right: MARGIN_MEDIUM_x),
//                   child: Container(
//                     height: MOVIE_DATE_HEIGHT,
//                     decoration: BoxDecoration(
//                       color: PRIMARY_COLOR_1,
//                       borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: MARGIN_SMALL_LX,
//                           horizontal: MARGIN_MEDIUM_x),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             "8th",
//                           ),
//                           Text("AUG"),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     left: MARGIN_SMALL_LX,
//                     right: MARGIN_SMALL_LX,
//                     bottom: MARGIN_MEDIUM_3LX),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       children: [
//                         Flexible(
//                           flex: 4,
//                           child: Text(
//                             widget.mMovie?.title?? "",
//                             softWrap: false,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: TEXT_SMALL,
//                                 color: Colors.white),
//                           ),
//                         ),
//                         const Spacer(),
//                         Image.asset(
//                           "assets/images/imdb.png",
//                           fit: BoxFit.fill,
//                         ),
//                         Text(
//                           widget.mMovie?.voteAverage.toString()??"",
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: TEXT_SMALL,
//                               color: Colors.white),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: MARGIN_SMALL),
//                     Row(
//                       children: [
//                         Text(
//                           widget.mMovie?.productionCountries?.first.iso31661?? "",
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: TEXT_SMALL,
//                               color: Colors.white),
//                         ),
//                         const SizedBox(width: MARGIN_MEDIUM),
//                         DotsIndicator(
//                           dotsCount: 1,
//                           decorator:
//                           const DotsDecorator(activeColor: DOTS_COLOR),
//                         ),
//                         const SizedBox(width: MARGIN_MEDIUM_X),
//                         const Expanded(
//                           child: Text(
//                             "2D, 3D, 3D IMAX",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: TEXT_xSMALL,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



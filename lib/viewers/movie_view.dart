import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class MovieView extends StatefulWidget {
  final List<Map<String, dynamic>> gridData;
  final Function onTapMovie;
  final Function(int) clickedIndex;
  // final bool isDateVisibility;
  final int dateVisibleIndex;
  MovieView(this.gridData, this.onTapMovie, this.dateVisibleIndex,this.clickedIndex);

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  @override
  Widget build(BuildContext context) {
    int i=0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: MARGIN_SMALL,vertical: MARGIN_xXLARGE),

        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: MARGIN_MEDIUM_3L,
            mainAxisSpacing: MARGIN_MEDIUM_3L,
            mainAxisExtent: MOVIE_VIEW_HEIGHT,
          ),
          itemCount: widget.gridData.length,
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
              child: Container(

                height: MOVIE_VIEW_HEIGHT,
                child: Stack(
                  children: [

                      Align(
                        alignment: Alignment.topCenter,
                        child:ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(MARGIN_MEDIUM),topRight: Radius.circular(MARGIN_MEDIUM)),
                        child: Image.asset(
                          "${widget.gridData.elementAt(index)['image']}",
                          width: 186,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {widget.onTapMovie();
                          setState((){
                            i=index;
                            widget.clickedIndex(i);
                          });},
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
                                  vertical: MARGIN_SMALL_LX, horizontal: MARGIN_MEDIUM_x),

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
                              children: [
                                Flexible(
                                  flex: 4,
                                  child: Text(
                                    "${widget.gridData.elementAt(index)['title']}",
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: TEXT_SMALL,
                                        color: Colors.white),
                                  ),
                                ),
                                const Spacer(),
                                Image.asset(
                                  "assets/images/imdb.png",
                                  fit: BoxFit.fill,
                                ),
                                Text(
                                  "${widget.gridData.elementAt(index)['rating']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: TEXT_SMALL,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: MARGIN_SMALL),
                            Row(
                              children: [
                                Text(
                                  "${widget.gridData.elementAt(index)['countryType']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: TEXT_SMALL,
                                      color: Colors.white),
                                ),
                                const SizedBox(width: MARGIN_MEDIUM),
                                DotsIndicator(
                                  dotsCount: 1,
                                  decorator: const DotsDecorator(
                                      activeColor: DOTS_COLOR),
                                ),
                                const SizedBox(width: MARGIN_MEDIUM_X),
                                Expanded(
                                  child: Text(
                                    "${widget.gridData.elementAt(index)['movieType']}",
                                    style: const TextStyle(
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
            );
          },
        ),

    );
  }
}

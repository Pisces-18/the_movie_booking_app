import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_booking_app/pages/about_movie_page.dart';
import 'package:the_movie_booking_app/pages/search_movie_page.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import '../resources/colors.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/banner_section_view.dart';
import '../viewers/movie_view.dart';


import '../widgets/bottom_navigation_bar_view.dart';

class HomePage extends StatefulWidget {
  int index = 0;
  String? location;

  HomePage(this.location);
  late int i = 0;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final int index=0;

  onTapSearch() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => (widget.index == 0)
              ? SearchMoviePage(nowShowingData, widget.index)
              : SearchMoviePage(comingSoonData, widget.index),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: APPBAR_COLOR,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: MARGIN_XxlLARGE),
          child: Icon(
            Icons.near_me,
            size: MARGIN_MEDIUM_2,
          ),
        ),
        title: (widget.location != null)
            ? Text(
                widget.location ?? "",
                style: GoogleFonts.inter(
                  textStyle: Theme.of(context).textTheme.labelMedium,
                  fontWeight: FontWeight.w700,
                  fontSize: TEXT_REGULAR_2X,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              )
            : Text(
                "Yangon",
                style: GoogleFonts.inter(
                  textStyle: Theme.of(context).textTheme.labelMedium,
                  fontWeight: FontWeight.w700,
                  fontSize: TEXT_REGULAR_2X,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
        actions: [
          GestureDetector(
              onTap: () => onTapSearch(),
              child: const Icon(
                Icons.search,
                size: MARGIN_MEDIUM_3LX,
              )),
          const SizedBox(width: MARGIN_MEDIUM_2),
          const Icon(Icons.notifications),
          Padding(
            padding: const EdgeInsets.only(right: MARGIN_MEDIUM_2X),
            child: Image.asset("assets/images/scanner.png"), //const
          )
        ],
      ),
      body: Container(
        color: APPBAR_COLOR,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: MARGIN_CARD_MEDIUM_2,
                    left: MARGIN_CARD_MEDIUM_2,
                    right: MARGIN_CARD_MEDIUM_2),
                child: BannerSectionView(),
              ),
              const SizedBox(height: MARGIN_xXLARGE),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_CARD_MEDIUM_2),
                child: ShowingMovieListSectionView(
                  () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (widget.index == 0)
                              ? AboutMoviePage(false, nowShowingData, widget.i)
                              : AboutMoviePage(
                                  true, comingSoonData, widget.i))),
                  gridData1: nowShowingData,
                  gridData2: comingSoonData,
                  onPressedButton: (index) {
                    setState(
                      () {
                        widget.index = index;
                      },
                    );
                  },
                  clickedIndex: (i) {
                    widget.i = i;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarView(0),
    );
  }
}

class ShowingMovieListSectionView extends StatefulWidget {
  const ShowingMovieListSectionView(
    this.onTapMovie, {
    Key? key,
    required this.gridData1,
    required this.gridData2,
    required this.onPressedButton,
    required this.clickedIndex,
  }) : super(key: key);
  final List<Map<String, dynamic>> gridData1;
  final List<Map<String, dynamic>> gridData2;
  final Function(int) onPressedButton;
  final Function onTapMovie;
  final Function(int) clickedIndex;

  @override
  State<ShowingMovieListSectionView> createState() =>
      _ShowingMovieListSectionViewState();
}

class _ShowingMovieListSectionViewState
    extends State<ShowingMovieListSectionView> {
  int index = 0;
  bool changeColorNS = true;
  bool changeColorCS = false;
  //int i=0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MARGIN_XXXlLARGEX,
          decoration: BoxDecoration(
            gradient: const RadialGradient(
              colors: [
                RADIAL_GRADIENT_COLOR_1,
                RADIAL_GRADIENT_COLOR_2,
                RADIAL_GRADIENT_COLOR_3,
              ],
              radius: MARGIN_lLARGE,
            ),
            borderRadius: BorderRadius.circular(MARGIN_SMALL_L),
          ),
          child: Padding(
            padding: const EdgeInsets.all( MARGIN_SMALL_Lx),
            child: Center(
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState((){
                        index = 0;
                        widget.onPressedButton(index);
                        changeColorNS=true;
                        changeColorCS=false;
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:changeColorNS ? PRIMARY_COLOR_1:Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: MARGIN_XxLARGE),
                      child: Text(
                        NS_BUTTON_TEXT,
                        style: GoogleFonts.dmSans(
                          textStyle: Theme.of(context).textTheme.headlineSmall,
                          fontWeight: FontWeight.w700,
                          fontSize: TEXT_REGULAR_2X,
                          color: BUTTON_TEXT_COLOR_NS,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      setState((){
                        index = 1;
                        widget.onPressedButton(index);
                        changeColorCS=true;
                        changeColorNS=false;
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:changeColorCS ? PRIMARY_COLOR_1:Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: MARGIN_XxLARGE),
                      child: Text(
                        CS_BUTTON_TEXT,
                        style: GoogleFonts.dmSans(
                          textStyle: Theme.of(context).textTheme.headlineSmall,
                          fontWeight: FontWeight.w700,
                          fontSize: TEXT_REGULAR_2X,
                          color: BUTTON_TEXT_COLOR_NS,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // const SizedBox(height: MARGIN_xXLARGE),
        MovieView((index == 0) ? widget.gridData1 : widget.gridData2,
            () => widget.onTapMovie(), index, (i) {
          setState(() {
            widget.clickedIndex(i);
          });
        })
      ],
    );
  }
}

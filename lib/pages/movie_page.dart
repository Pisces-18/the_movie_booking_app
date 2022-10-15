import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_booking_app/data/models/data_model.dart';
import 'package:the_movie_booking_app/pages/about_movie_page.dart';
import 'package:the_movie_booking_app/pages/search_movie_page.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import '../data/models/data_model_impl.dart';
import '../data/vos/banner_vo.dart';
import '../data/vos/movie_vo.dart';
import '../resources/colors.dart';
import '../resources/strings.dart';
import '../viewers/banner_section_view.dart';
import '../viewers/movie_section_view.dart';


class MoviePage extends StatefulWidget {

  int buttonIndex = 0;
  String? location;
  //late int i = 0;
  MoviePage(this.location);
  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  DataModel mMovieModel=DataModelImpl();

  List<MovieVO>? mNowShowingMovieList;
  List<MovieVO>? mComingSoonMovieList;
  List<BannerVO>? bannerList;

  @override
  void initState(){
    super.initState();

    ///Get Banners Network
    mMovieModel.getBanners()?.then((banners){
      setState((){
        bannerList=banners;
        //debugPrint(bannerList[0].title.toString())
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Get Banners Database
    mMovieModel.getBannersFromDatabase()?.then((banners){
      setState((){
        bannerList=banners;
       debugPrint("Banners from Database ==> ${bannerList?[0].title.toString()}");
      });
    }).catchError((error) {
      debugPrint("Banners database Error ===> $error");
    });

    ///Now Showing Movies Network
    mMovieModel.getNowPlayingMovies(1)?.then((movieList) {
      setState(() {
        mNowShowingMovieList = movieList;
        //debugPrint(mNowShowingMovieList?[0].productionCountries?[0].iso31661.toString());
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Now Showing Movies Database
    mMovieModel.getNowPlayingMoviesFromDatabase()?.then((movieList) {
      setState((){
        mNowShowingMovieList=movieList;
      });
    }).catchError((error){
      debugPrint("Now Playing Database Error ===> $error");
    });

    ///Coming Soon Movies NetWork
     mMovieModel.getUpcomingMovies(1)?.then((movieList) {
       setState((){
         mComingSoonMovieList=movieList;
        // debugPrint(mComingSoonMovieList?[0].title.toString());
       });
     })
    .catchError((error){
       debugPrint(error.toString());
     });

    ///Coming Soon Movies Database
    mMovieModel.getUpComingMoviesFromDatabase()?.then((movieList) {
      setState((){
        mComingSoonMovieList=movieList;
      });
    }).catchError((error){
      debugPrint("Coming Soon Database Error ===> $error");
    });
  }


  onTapSearch() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => (widget.buttonIndex == 0)
              ? SearchMoviePage(mNowShowingMovieList, widget.buttonIndex,widget.location?? "")
              : SearchMoviePage(mComingSoonMovieList, widget.buttonIndex,widget.location?? ""),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:APPBAR_COLOR ,
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
                widget.location?? "",
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
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                padding: const EdgeInsets.only(
                    top: MARGIN_CARD_MEDIUM_2,
                    left: MARGIN_CARD_MEDIUM_2,
                    right: MARGIN_CARD_MEDIUM_2),
                child: (bannerList!=null)?BannerSectionView(bannerList: bannerList,): const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              const SizedBox(height: MARGIN_xXLARGE),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_CARD_MEDIUM_2),
                child: ShowingMovieListSectionView(
                  (movieId) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (widget.buttonIndex == 0)
                              ? AboutMoviePage(false,movieId,widget.location?? "")
                              : AboutMoviePage(
                                  true,movieId,widget.location?? ""))),
                  mNowShowingMovieList: mNowShowingMovieList?? [],
                  mComingSoonMovieList: mComingSoonMovieList?? [],
                  onPressedButton: (index) {
                    setState(
                      () {
                        widget.buttonIndex = index;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBarView(0),
    );
  }
}

class ShowingMovieListSectionView extends StatefulWidget {
   ShowingMovieListSectionView(
    this.onTapMovie, {
    Key? key,
    required this.mNowShowingMovieList,
    required this.mComingSoonMovieList,
    required this.onPressedButton,

  }) : super(key: key);
  List<MovieVO>? mNowShowingMovieList;
  List<MovieVO>? mComingSoonMovieList;
  final Function(int) onPressedButton;
  final Function(int) onTapMovie;


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
      crossAxisAlignment: CrossAxisAlignment.start,
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

        MovieSectionView((index==0)?widget.mNowShowingMovieList:widget.mComingSoonMovieList,index,(index){
          widget.onTapMovie(index);
        })
        // const SizedBox(height: MARGIN_xXLARGE),
        // MovieView((index == 0) ? widget.mNowShowingMovieList : widget.mComingSoonMovieList,
        //     (index) => widget.onTapMovie(index),)
      ],
    );
  }
}



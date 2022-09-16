import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_booking_app/pages/movie_page.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';


class LocationPage extends StatefulWidget {

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: APPBAR_COLOR,
        title: Text(
          PICK_REGION_TEXT,
          style: GoogleFonts.dmSans(
              textStyle: Theme.of(context).textTheme.headlineSmall,
              fontWeight: FontWeight.w700,
              fontSize: TEXT_REGULAR_2X,
              color: PRIMARY_COLOR_1,
              shadows: [
                const Shadow(
                  color: PRIMARY_COLOR_1,
                  offset: Offset(0, 0),
                  blurRadius: MARGIN_MEDIUM_3,
                )
              ]),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_3,horizontal: MARGIN_MEDIUM_3LX),
                child: SearchLocationView(),
              ),
              LocationCitySectionView(
                cityList,
                (location) => _navigateToHomePage(context,location),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToHomePage(BuildContext context, String location) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(location,),
      ),
    );
  }
}

class LocationCitySectionView extends StatefulWidget {
  final List<String> cityList;
  final Function(String) onTapLocation;
  // final Function(String) searchLocation;
  LocationCitySectionView(
      this.cityList,  this.onTapLocation);

  @override
  State<LocationCitySectionView> createState() =>
      _LocationCitySectionViewState();
}

class _LocationCitySectionViewState extends State<LocationCitySectionView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Align(
          alignment: Alignment.topRight,
          child: CityImageView(),
        ),
        CityTitleTextView(),
        Container(
          height: MediaQuery.of(context).size.height / 1.5,
          child: ListView.builder(
            itemCount: widget.cityList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.onTapLocation(widget.cityList.elementAt(index));
                    //widget.searchLocation(widget.cityList.elementAt(index));
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: MARGIN_MEDIUM_3,
                    top: MARGIN_MEDIUM_3,
                    bottom: MARGIN_MEDIUM_3,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                      color: CITY_CONTAINER_COLOR,
                    )),
                    color: APPBAR_COLOR,
                  ),
                  child: Text(
                    widget.cityList.elementAt(index),
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.labelMedium,
                      fontWeight: FontWeight.w500,
                        fontSize: TEXT_REGULAR_2X,
                        color: Colors.white,
                    ),

                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class CityTitleTextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      color: CITY_CONTAINER_COLOR,
      padding: const EdgeInsets.only(
        left: MARGIN_MEDIUM_3,
        top: MARGIN_MEDIUM_XL,
        bottom: MARGIN_MEDIUM_XL,
      ),
      child: Text(
        CITY_TEXT,
        style: GoogleFonts.inter(
          textStyle: Theme.of(context).textTheme.displaySmall,
          fontWeight: FontWeight.w400,
          fontSize: TEXT_REGULAR_1X,
          color: CITY_TEXT_COLOR,
        ),

      ),
    );
  }
}

class CityImageView extends StatelessWidget {
  const CityImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/locationImage.png",
    );
  }
}

class SearchLocationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width/1.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              MARGIN_MEDIUM,
            ),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  LOCATION_SEARCH_GRADIENT_COLOR_1,
                  LOCATION_SEARCH_GRADIENT_COLOR_2,
                  LOCATION_SEARCH_GRADIENT_COLOR_2,
                ]),
            boxShadow: const [
              BoxShadow(
                  color: RADIAL_GRADIENT_COLOR_3,
                  offset: Offset(0, 0),
                  blurRadius: MARGIN_lLARGE,
                  spreadRadius: MARGIN_MEDIUM_X)
            ],
          ),
          child: TextField(
            style: const TextStyle(
              color: DASH_COLOR_2,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.search,
                  size: MARGIN_LARGE,
                  color: PRIMARY_COLOR_1,
                ),
                filled: true,
                hintText: SEARCH_LOCATION_HINT_TEXT,
                hintStyle: GoogleFonts.inter(
                  textStyle: Theme.of(context).textTheme.displaySmall,
                  color: SEARCH_LOCATION_HINT_TEXT_COLOR,
                  fontSize: TEXT_REGULAR,
                )),
          ),
        ),

        Container(
          width: MARGIN_XXXLARGE,
          height: MARGIN_XXXLARGE,
          decoration: BoxDecoration(
            color: PRIMARY_COLOR_1,
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM_XL),
          ),
          child: Image.asset(
            "assets/images/locationSign.png",
          ),
        )
      ],
    );
  }
}

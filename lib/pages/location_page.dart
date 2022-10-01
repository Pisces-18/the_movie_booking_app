import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_booking_app/data/models/data_model.dart';
import 'package:the_movie_booking_app/data/models/data_model_impl.dart';
import 'package:the_movie_booking_app/pages/movie_page.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import '../data/vos/city_vo.dart';
import '../resources/strings.dart';

class LocationPage extends StatefulWidget {
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  DataModel dDataModel = DataModelImpl();
  List<CityVO>? cityList;

  @override
  void initState() {
    super.initState();

    ///Get Cities
    dDataModel.getCities()?.then((cities) {
      setState(() {
        cityList = cities;
        debugPrint("Cities===>${cityList?[0].name}");
      });
    }).catchError((error) {
      debugPrint("Errors====>$error");
    });
  }

  _showToast(String msg) {
    showToast(
      msg,
      context: context,
      duration: const Duration(seconds: 3),
      animation: StyledToastAnimation.slideToRightFade,
      position: StyledToastPosition.bottom,
      backgroundColor: Colors.grey,
    );
  }

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
                padding: const EdgeInsets.symmetric(
                    vertical: MARGIN_MEDIUM_3, horizontal: MARGIN_MEDIUM_3LX),
                child: SearchLocationView(),
              ),
              LocationCitySectionView(
                cityList,
                (location, cityId) {
                  setState(() {
                    // dDataModel.setCity(cityId);
                    dDataModel.setCity(cityId)?.then((response) {
                      if (response.code == 200) {
                        _navigateToHomePage(context, location);
                      }else{
                        _showToast("Your Location was wrong!");
                      }
                    }).catchError((error) => debugPrint(error.toString()));
                  });
                },
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
        builder: (context) => HomePage(
          location,
        ),
      ),
    );
  }
}

class LocationCitySectionView extends StatefulWidget {
  final List<CityVO>? cityList;
  final Function(String, int) onTapLocation;
  // final Function(String) searchLocation;
  LocationCitySectionView(this.cityList, this.onTapLocation);

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
          child: (widget.cityList != null)
              ? ListView.builder(
                  itemCount: widget.cityList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.onTapLocation(
                              widget.cityList?[index].name ?? "",
                              widget.cityList?[index].id ?? 0);
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
                          widget.cityList?[index].name ?? "",
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
                )
              : const Center(child: CircularProgressIndicator()),
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
          width: MediaQuery.of(context).size.width / 1.35,
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

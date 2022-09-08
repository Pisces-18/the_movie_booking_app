import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_booking_app/pages/choose_time_and_cinema_page.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import '../resources/colors.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../widgets/censor_date_duration_view.dart';

class AboutMoviePage extends StatelessWidget {


  final List<Map<String, dynamic>> gridData;
  final int gridDataIndex;
  final bool isNotificationAndBookingVisibility;

  AboutMoviePage(this.isNotificationAndBookingVisibility, this.gridData,
      this.gridDataIndex);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: MARGIN_LARGE),
        color: PAGE_BACKGROUND_COLOR,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MovieInfoView(
                movieTypeList: movieTypeList,
                gridDataIndex: gridDataIndex,
                gridData: gridData,
              ),
              const SizedBox(height: MARGIN_MEDIUM_2),
              CensorDateDurationSectionView(gridData, gridDataIndex),
              ReleaseDateNotificationView(isNotificationAndBookingVisibility),
              const SizedBox(height: MARGIN_xXLARGE),
              StoryLineSectionView(),
              const SizedBox(height: MARGIN_xXLARGE),
              CastSectionView(castData: castData)
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !isNotificationAndBookingVisibility,
        child: BookingButtonView(
          () => _navigateToChooseTimeAndCinemaPage(context),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<dynamic> _navigateToChooseTimeAndCinemaPage(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseTimeAndCinemaPage(),
      ),
    );
  }
}

class BookingButtonView extends StatelessWidget {
  final Function onTapBooking;
  BookingButtonView(this.onTapBooking);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTapBooking(),
        child: Image.asset("assets/images/bookingButton.png"),);
  }
}

class ReleaseDateNotificationView extends StatelessWidget {
  final bool isNotificationVisibility;
  ReleaseDateNotificationView(this.isNotificationVisibility);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isNotificationVisibility,
      child: Container(
        margin: const EdgeInsets.only(
            left: MARGIN_MEDIUM_2x,
            right: MARGIN_MEDIUM_2x,
            top: MARGIN_xXLARGE),
        padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_CARD_MEDIUM_2, vertical: MARGIN_MEDIUM_2X),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MARGIN_MEDIUM_X),
          boxShadow: const [
            BoxShadow(
              color: RADIAL_GRADIENT_COLOR_3,
              blurRadius: MARGIN_lLARGE,
              spreadRadius: MARGIN_MEDIUM_X,
              offset: Offset(0, 4),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              ABOUT_MOVIE_GRADIENT_COLOR_1,
              ABOUT_MOVIE_GRADIENT_COLOR_2,
              ABOUT_MOVIE_GRADIENT_COLOR_3,
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReleaseSectionTitleTextView(),
                  const SizedBox(height: MARGIN_MEDIUM_X),
                  ReleaseSectionNotificationTextView(),
                  const SizedBox(height: MARGIN_MEDIUM_3),
                  SendNotificationButtonView()
                ],
              ),
            ),
            const SizedBox(width: MARGIN_xXLARGE),
            ReleaseSectionImageView(),
          ],
        ),
      ),
    );
  }
}

class ReleaseSectionImageView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/notiImage.png");
  }
}

class SendNotificationButtonView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_XXxLARGE),
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_X, vertical: MARGIN_MEDIUM),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        color: PRIMARY_COLOR_1,
      ),
      child: Row(
        children: [
          Image.asset("assets/images/notiIcon.png"),
          const SizedBox(width: MARGIN_MEDIUM_XL),
          const Text(
            ABOUT_MOVE_SET_NOTIFICICATION_TEXT,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: TEXT_REGULAR,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class ReleaseSectionNotificationTextView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return const Text(
      ABOUT_MOVE_NOTIFICICATION_TEXT,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: TEXT_REGULAR,
        color: TOTIFICATION_TEXT_COLOR,
      ),
    );
  }
}

class ReleaseSectionTitleTextView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return const Text(
      "Releasing in 5 days",
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: TEXT_REGULAR_2X,
        color: Colors.white,
      ),
    );
  }
}

class MovieInfoView extends StatefulWidget {
  const MovieInfoView(
      {Key? key,
      required this.movieTypeList,
      required this.gridData,
      required this.gridDataIndex})
      : super(key: key);
  final List<Map<String, dynamic>> gridData;
  final int gridDataIndex;
  final List<String> movieTypeList;
  @override
  State<MovieInfoView> createState() => _MovieInfoViewState();
}

class _MovieInfoViewState extends State<MovieInfoView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ABOUT_MOVIE_INFO_VIEW_HEIGHT,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: ABOUT_MOVIE_INFO_VIEW_BACKGROUND_HEIGHT,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: MoviePlayImageView(
                          "${widget.gridData.elementAt(widget.gridDataIndex)['videoImage']}"),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: BackButtonView(),
                    ),
                    const Align(
                      alignment: Alignment.topRight,
                      child: ShareButtonView(),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: PlayButtonView(),
                    )
                  ],
                ),
              ),
              const SizedBox(height: MARGIN_MEDIUM_2),
              MovieGenreInfoView(
                movieTypeList: widget.movieTypeList,
                gridData: widget.gridData,
                gridDataIndex: widget.gridDataIndex,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: MovieImageView(
                "${widget.gridData.elementAt(widget.gridDataIndex)['image']}"),
          ),
        ],
      ),
    );
  }
}

class MovieGenreInfoView extends StatelessWidget {
  const MovieGenreInfoView(
      {Key? key,
      required this.movieTypeList,
      required this.gridData,
      required this.gridDataIndex})
      : super(key: key);
  final List<Map<String, dynamic>> gridData;
  final int gridDataIndex;
  final List<String> movieTypeList;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 180),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MovieGenreInfoTitleView(gridData: gridData, gridDataIndex: gridDataIndex),
              const SizedBox(width: MARGIN_SMALL_LX),
              MovieGenreInfoImageView(),
              MovieGenreInfoMovieNameView(gridData: gridData, gridDataIndex: gridDataIndex),
            ],
          ),
          const SizedBox(height: MARGIN_MEDIUM_2x),
          MovieGenreInfoMovieTypeView(gridData: gridData, gridDataIndex: gridDataIndex),
          const SizedBox(height: MARGIN_MEDIUM_2X),
          Wrap(
            children:
                movieTypeList.map((type) => MovieTypeChipView(type)).toList(),
          ),
        ],
      ),
    );
  }
}

class MovieGenreInfoMovieTypeView extends StatelessWidget {
  const MovieGenreInfoMovieTypeView({
    Key? key,
    required this.gridData,
    required this.gridDataIndex,
  }) : super(key: key);

  final List<Map<String, dynamic>> gridData;
  final int gridDataIndex;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${gridData.elementAt(gridDataIndex)['movieType']}",
      style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: TEXT_REGULAR,
          color: Colors.white),
    );
  }
}

class MovieGenreInfoMovieNameView extends StatelessWidget {
  const MovieGenreInfoMovieNameView({
    Key? key,
    required this.gridData,
    required this.gridDataIndex,
  }) : super(key: key);

  final List<Map<String, dynamic>> gridData;
  final int gridDataIndex;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${gridData.elementAt(gridDataIndex)['rating']}",
      style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: TEXT_REGULAR_2X,
          color: Colors.white,
          fontStyle: FontStyle.italic),
    );
  }
}

class MovieGenreInfoImageView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/imdb.png");
  }
}

class MovieGenreInfoTitleView extends StatelessWidget {
  const MovieGenreInfoTitleView({
    Key? key,
    required this.gridData,
    required this.gridDataIndex,
  }) : super(key: key);

  final List<Map<String, dynamic>> gridData;
  final int gridDataIndex;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        "${gridData.elementAt(gridDataIndex)['title']}",
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: TEXT_REGULAR_2X,
            color: Colors.white),
      ),
    );
  }
}

class MovieImageView extends StatelessWidget {
  final String image;
  MovieImageView(this.image);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: MARGIN_MEDIUM_2x, bottom: MARGIN_MEDIUM_3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MARGIN_SMALL),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          width: ABOUT_MOVIE_IMAGE_WIDTH,
          height: ABOUT_MOVIE_IMAGE_HEIGHT,
        ),
      ),
    );
  }
}

class ShareButtonView extends StatelessWidget {
  const ShareButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: MARGIN_MEDIUM_3),
      child: Icon(
        Icons.share,
        color: Colors.white,
        size: MARGIN_MEDIUM_3,
      ),
    );
  }
}

class PlayButtonView extends StatelessWidget {
  const PlayButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/playButton.png");
  }
}

class BackButtonView extends StatelessWidget {
  const BackButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: MARGIN_MEDIUM_3),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_xXLARGE,
        ),
      ),
    );
  }
}

class MoviePlayImageView extends StatelessWidget {
  final String playImage;
  MoviePlayImageView(this.playImage);
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      playImage,
      fit: BoxFit.cover,
    );
  }
}

class MovieTypeChipView extends StatelessWidget {
  final String type;
  MovieTypeChipView(this.type);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Chip(
          padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM, vertical: MARGIN_SMALL_L),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM_X),
          ),
          shadowColor: ABOUT_MOVIE_TYPE_CHIP_SHADOW_COLOR,
          backgroundColor: PRIMARY_COLOR_1,
          label: Text(
            type,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: TEXT_SMALL,
              color: APPBAR_COLOR,
            ),
          ),
        ),
        const SizedBox(width: MARGIN_MEDIUM),
      ],
    );
  }
}

class CastSectionView extends StatelessWidget {
  const CastSectionView({
    Key? key,
    required this.castData,
  }) : super(key: key);

  final List<Map<String, dynamic>> castData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
          child: CastSectionTitleView(),
        ),
        const SizedBox(height: MARGIN_MEDIUM_3L),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                ABOUT_MOVIE_CAST_GRADIENT_COLOR_1,
                ABOUT_MOVIE_CAST_GRADIENT_COLOR_2,
              ])),
          height: ABOUT_MOVIE_CAST_LISTVIEW_HEIGHT,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) {
                return CasterView(castData: castData, index: index,);
              }),
        )
      ],
    );
  }
}

class CasterView extends StatelessWidget {
  const CasterView({
    Key? key,
    required this.castData, required this.index,
  }) : super(key: key);

  final List<Map<String, dynamic>> castData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM_3),
      width: ABOUT_MOVIE_CAST_LISTVIEW_WIDTH,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CasterImageView(castData: castData, index: index),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          Padding(
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM),
            child: CasterNameView(castData: castData, index: index),
          ),
        ],
      ),
    );
  }
}

class CasterNameView extends StatelessWidget {
  const CasterNameView({
    Key? key,
    required this.castData,
    required this.index,
  }) : super(key: key);

  final List<Map<String, dynamic>> castData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${castData.elementAt(index)['name']}",
      style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: TEXT_SMALL,
          color: Colors.white),
    );
  }
}

class CasterImageView extends StatelessWidget {
  const CasterImageView({
    Key? key,
    required this.castData,
    required this.index,
  }) : super(key: key);

  final List<Map<String, dynamic>> castData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
        "${castData.elementAt(index)['image']}");
  }
}

class CastSectionTitleView extends StatelessWidget {
  const CastSectionTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      CAST_TITLE_TEXT,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: TEXT_REGULAR,
          color: Colors.white),
    );
  }
}

class StoryLineSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StoryLineSectionTitleView(),
          const SizedBox(height: MARGIN_MEDIUM_X),
          StoryLineSectionTextView()
        ],
      ),
    );
  }
}

class StoryLineSectionTextView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Text(
      "In the 1970s, young Gru tries to join a group of supervillains called the Vicious 6 after they oust their leader -- the legendary fighter Wild Knuckles. When the interview turns disastrous, Gru and his Minions go on the run with the Vicious 6 hot on their tails. Luckily, he finds an unlikely source for guidance -- Wild Knuckles himself -- and soon discovers that even bad guys need a little help from their friends.",
      style: GoogleFonts.dmSans(
          textStyle: Theme.of(context).textTheme.headlineSmall,
          fontWeight: FontWeight.w500,
          fontSize: TEXT_REGULAR,
          color: Colors.white),
    );
  }
}

class StoryLineSectionTitleView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Text(
      STORY_LINE_TEXT,
      style: GoogleFonts.dmSans(
          textStyle: Theme.of(context).textTheme.headlineSmall,
          fontWeight: FontWeight.w600,
          fontSize: TEXT_REGULAR,
          color: Colors.white),
    );
  }
}

class CensorDateDurationSectionView extends StatelessWidget {
  final List<Map<String, dynamic>> gridData;
  final int gridDataIndex;
  CensorDateDurationSectionView(this.gridData, this.gridDataIndex);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CensorDateDurationView(CENSOR_RATING_TEXT,
              "${gridData.elementAt(gridDataIndex)['countryType']}"),
          CensorDateDurationView(RELEASE_DATE_TEXT, "May 8th, 2022"),
          CensorDateDurationView(DURATION_TEXT, "2hr 15min"),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_booking_app/data/models/data_model.dart';
import 'package:the_movie_booking_app/data/models/data_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/actor_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/pages/choose_time_and_cinema_page.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import '../data/vos/movie_vo.dart';
import '../resources/colors.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../widgets/censor_date_duration_view.dart';

class AboutMoviePage extends StatefulWidget {
  final int movieId;
  final bool isNotificationAndBookingVisibility;
  final String location;

  AboutMoviePage(
      this.isNotificationAndBookingVisibility, this.movieId, this.location);

  @override
  State<AboutMoviePage> createState() => _AboutMoviePageState();
}

class _AboutMoviePageState extends State<AboutMoviePage> {

  DataModel mMovieModel = DataModelImpl();

  MovieVO? mMovie;
  List<ActorVO>? actorList;

  @override
  void initState() {
    super.initState();
    ///Get Movie Details
    mMovieModel.getMovieDetails(widget.movieId)?.then((movie) {
      setState(() {
        mMovie = movie;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Get Actor
    mMovieModel.getCreditsByMovie(widget.movieId)?.then((creditList) {
      setState(() {
        actorList = creditList;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: MARGIN_LARGE),
        child: (mMovie != null)
            ? SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MovieInfoView(
                mMovie: mMovie,
              ),
              const SizedBox(height: MARGIN_MEDIUM_2),
              CensorDateDurationSectionView(mMovie),
              ReleaseDateNotificationView(
                  widget.isNotificationAndBookingVisibility),
              const SizedBox(height: MARGIN_xXLARGE),
              StoryLineSectionView(mMovie?.overview ?? ""),
              const SizedBox(height: MARGIN_xXLARGE),
              CastSectionView(actorList: actorList)
            ],
          ),
        )
            : const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !widget.isNotificationAndBookingVisibility,
        child: BookingButtonView(
              () => _navigateToChooseTimeAndCinemaPage(context, widget.location,widget.movieId),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<dynamic> _navigateToChooseTimeAndCinemaPage(
      BuildContext context, location,movieId) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseTimeAndCinemaPage(location,movieId),
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
      child: Image.asset("assets/images/bookingButton.png"),
    );
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
  MovieInfoView({
    Key? key,
    required this.mMovie,
  }) : super(key: key);
  MovieVO? mMovie;

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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: ABOUT_MOVIE_INFO_VIEW_BACKGROUND_HEIGHT,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: MoviePlayImageView(
                          "$IMAGE_BASE_URL${widget.mMovie?.backDropPath}"),
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
                mMovie: widget.mMovie,
                movieTypeList: widget.mMovie?.genres
                    ?.map((genre) => genre.name ?? "")
                    .toList(),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child:
            MovieImageView("$IMAGE_BASE_URL${widget.mMovie?.posterPath}"),
          ),
        ],
      ),
    );
  }
}

class MovieGenreInfoView extends StatelessWidget {
  MovieGenreInfoView({
    Key? key,
    required this.mMovie,
    required this.movieTypeList,
  }) : super(key: key);
  MovieVO? mMovie;
  final List<String>? movieTypeList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 180),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            children: [
              MovieGenreInfoTitleView(
                title: mMovie?.title ?? "",
              ),
              const SizedBox(width: MARGIN_SMALL_LX),
              MovieGenreInfoImageView(),
              MovieGenreInfoRatingView(
                rating: mMovie?.voteAverage.toString() ?? "",
              ),
            ],
          ),
          const SizedBox(height: MARGIN_MEDIUM_2x),
          MovieGenreInfoMovieTypeView(
            movieTypeList: "2D ,3D ",
          ),
          const SizedBox(height: MARGIN_MEDIUM_2X),
          Wrap(
            children: movieTypeList
                ?.map((type) => MovieTypeChipView(type))
                .toList() ??
                [],
          ),
        ],
      ),
    );
  }
}

class MovieGenreInfoMovieTypeView extends StatelessWidget {
  const MovieGenreInfoMovieTypeView({
    Key? key,
    required this.movieTypeList,
  }) : super(key: key);

  final String movieTypeList;

  @override
  Widget build(BuildContext context) {
    return Text(
      movieTypeList,
      style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: TEXT_REGULAR,
          color: Colors.white),
    );
  }
}

class MovieGenreInfoRatingView extends StatelessWidget {
  const MovieGenreInfoRatingView({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final String rating;

  @override
  Widget build(BuildContext context) {
    return Text(
      rating,
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
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: TEXT_REGULAR_2X,
          color: Colors.white),
    );
  }
}

class MovieImageView extends StatelessWidget {
  final String image;
  MovieImageView(this.image);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(left: MARGIN_MEDIUM_2x, bottom: MARGIN_CARD_MEDIUM_2L_X),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MARGIN_SMALL),
        child: Image.network(
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
    return Image.network(
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
    required this.actorList,
  }) : super(key: key);

  final List<ActorVO>? actorList;

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
              itemCount: actorList?.length,
              itemBuilder: (BuildContext context, int index) {
                return CasterView(actor: actorList?[index]);
              }),
        )
      ],
    );
  }
}

class CasterView extends StatelessWidget {
  const CasterView({
    Key? key,
    required this.actor,
  }) : super(key: key);

  final ActorVO? actor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM_3),
      width: ABOUT_MOVIE_CAST_LISTVIEW_WIDTH,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(MARGIN_XXXLARGE),
            child: CasterImageView(
              image: "$IMAGE_BASE_URL${actor?.profilePath}",
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          Padding(
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM),
            child: CasterNameView(
              name: actor?.name.toString() ?? "",
            ),
          ),
        ],
      ),
    );
  }
}

class CasterNameView extends StatelessWidget {
  const CasterNameView({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
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
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      fit: BoxFit.cover,
      width: MARGIN_XXXLARGE,
      height: MARGIN_XXXLARGE,
    );
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
  final String overview;
  StoryLineSectionView(this.overview);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StoryLineSectionTitleView(),
          const SizedBox(height: MARGIN_MEDIUM_X),
          StoryLineSectionTextView(overview)
        ],
      ),
    );
  }
}

class StoryLineSectionTextView extends StatelessWidget {
  final String overview;
  StoryLineSectionTextView(this.overview);
  @override
  Widget build(BuildContext context) {
    return Text(
      overview,
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
  MovieVO? mMovie;

  CensorDateDurationSectionView(this.mMovie);
  @override
  Widget build(BuildContext context) {
    String month =
    DateFormat.MMM().format(DateTime.parse(mMovie?.releaseDate ?? ""));
    String day =
    DateFormat.d().format(DateTime.parse(mMovie?.releaseDate ?? ""));
    String year =
    DateFormat.y().format(DateTime.parse(mMovie?.releaseDate ?? ""));
    int time = mMovie?.runtime ?? 0;
    int hour = time ~/ 60;
    int minute = (time - hour * 60);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CensorDateDurationView(CENSOR_RATING_TEXT,
              "U/A"),
          CensorDateDurationView(RELEASE_DATE_TEXT, "$month ${day}th, $year"),
          CensorDateDurationView(DURATION_TEXT, "${hour}hr ${minute}min"),
        ],
      ),
    );
  }
}

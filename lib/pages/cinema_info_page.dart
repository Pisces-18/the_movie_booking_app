import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/data_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/facility_vo.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:video_player/video_player.dart';
import '../data/models/data_model.dart';
import '../data/vos/cinema_vo.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/available_service_icon_and_text_view.dart';

class CinemaInfoPage extends StatefulWidget {
  final String location;
  final int cinemaId;
  CinemaInfoPage(this.location, this.cinemaId);

  @override
  State<CinemaInfoPage> createState() => _CinemaInfoPageState();
}

class _CinemaInfoPageState extends State<CinemaInfoPage> {
  DataModel dDataModel=DataModelImpl();
  CinemaVO? cinema;
  void initState(){
    super.initState();
    dDataModel.getCinemaDetailsFromDatabase(widget.cinemaId)?.then((value){
      setState((){
        cinema=value;
        debugPrint("Video File===>${cinema?.promoVdoUrl}");
      });
    }).catchError((error){
      debugPrint("Cinema Info Database Error==>$error");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: APPBAR_COLOR,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            "assets/images/leftIcon.png",
            width: MARGIN_LARGE,
            height: MARGIN_LARGE,
          ),
        ),
        title: const Text(
          CINEMA_INFO_PAGE_TITLE_TEXT,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: TEXT_REGULAR_4X,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
            child: Image.asset(
              "assets/images/starIcon.png",
              width: MARGIN_LARGE,
              height: MARGIN_LARGE,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height/1,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              cinemaVideoView(cinema?.promoVdoUrl?? ""),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_xLARGE),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CinemaNameAndLocationView(cinema?.name?? "",cinema?.address?? ""),
                    const SizedBox(height: MARGIN_XXLARGE),
                    FacilitiesSectionView(cinema?.facilities),
                    const SizedBox(height: MARGIN_XXLARGE),
                    SafetySectionView(safetyList: cinema?.safety)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

class SafetySectionView extends StatelessWidget {
  const SafetySectionView({
    Key? key,
    required this.safetyList,
  }) : super(key: key);

  final List<String>? safetyList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          SAFETY_TEXT,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: TEXT_REGULAR_2Xx,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_3L),
        Container(
          width: MediaQuery.of(context).size.width / 1,
          child: Wrap(
            spacing: MARGIN_SMALL_L,
            runSpacing: MARGIN_CARD_MEDIUM_2,
            children: safetyList?.map((type) => SafetyTypeView(type)).toList()?? [],
          ),
        )
      ],
    );
  }
}

class SafetyTypeView extends StatelessWidget {
  final String type;
  SafetyTypeView(this.type);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_X,
        vertical: MARGIN_XSMALL,
      ),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR_1,
        borderRadius: BorderRadius.circular(MARGIN_SMALL),
      ),
      child: Text(
        type,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: TEXT_REGULAR,
          color: APPBAR_COLOR,
        ),
      ),
    );
  }
}

class FacilitiesSectionView extends StatefulWidget {
  final List<FacilityVO>?facilityList;
  FacilitiesSectionView(this.facilityList);

  @override
  State<FacilitiesSectionView> createState() => _FacilitiesSectionViewState();
}

class _FacilitiesSectionViewState extends State<FacilitiesSectionView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          CINEMA_FACILIRIES_TEXT,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: TEXT_REGULAR_2Xx,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        Wrap(
          runSpacing: MARGIN_MEDIUM_2x,
            spacing: MARGIN_CARD_MEDIUM_2L_X,
          children: widget.facilityList?.map((facility) => AvailableServiceIconAndTextView(facility.title?? "", facility.img?? "",PRIMARY_COLOR_1)).toList()?? [],
        )

      ],
    );
  }
}

class CinemaNameAndLocationView extends StatelessWidget {
  final String cinemaName;
  final String cinemaLocation;
  CinemaNameAndLocationView(this.cinemaName,this.cinemaLocation);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          cinemaName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: TEXT_REGULAR_2X,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: MARGIN_CARD_MEDIUM_2L_X),
        Row(
          children: [
             Flexible(
              child: Text(
                cinemaLocation,
                style: const TextStyle(
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.w600,
                  fontSize: TEXT_REGULAR_2Xx,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: MARGIN_XXXLLARGE),
            Image.asset("assets/images/cinemaLocationIcon.png"),
          ],
        )
      ],
    );
  }
}

class cinemaVideoView extends StatefulWidget {
  final String videoUrl;
  cinemaVideoView(this.videoUrl);
  @override
  State<cinemaVideoView> createState() => _cinemaVideoViewState();
}

class _cinemaVideoViewState extends State<cinemaVideoView> {
  late FlickManager flickManager;
  @override
  void initState(){
    super.initState();

      flickManager=FlickManager(videoPlayerController: VideoPlayerController.network(widget.videoUrl));

  }

  @override
  void dispose(){
    flickManager.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {

    return Container(
      height: CINEMA_INFO_IMAGE_HEIGHT,
      child: FlickVideoPlayer(
        flickManager: flickManager,
      ),
    );
  }
}

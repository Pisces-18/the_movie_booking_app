import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:the_movie_booking_app/data/vos/check_out_vo.dart';
import 'package:the_movie_booking_app/data/vos/time_slot_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/pages/movie_page.dart';
import '../data/models/data_model.dart';
import '../data/models/data_model_impl.dart';
import '../data/vos/cinema_and_show_time_slots_vo.dart';
import '../data/vos/cinema_vo.dart';
import '../data/vos/movie_vo.dart';
import '../data/vos/snack_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/ticket_info_view.dart';

class TicketConfirmationPage extends StatefulWidget {
  final String location;
  final CinemaVO? cinema;
  final CheckOutVO? checkoutData;
  TicketConfirmationPage(this.location, this.cinema,this.checkoutData);

  @override
  State<TicketConfirmationPage> createState() => _TicketConfirmationPageState();
}

class _TicketConfirmationPageState extends State<TicketConfirmationPage> {
  DataModel dDataModel = DataModelImpl();

  MovieVO? mMovie;
  List<SnackVO>? snackVO;


  bool? _isLoading;
  @override
  void initState() {
    super.initState();

   // debugPrint("Movie Id ${DataModelImpl().mCheckOutRepository?.movieId}");
    //checkoutData = DataModelImpl().mCheckOutRepository;

    ///Get Movie
    dDataModel.getMovieDetails(widget.checkoutData?.movieId ?? 0)?.then((movie) {
      setState(() {
        mMovie = movie;
        //debugPrint(mMovie?.title.toString());
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    //debugPrint("QR Code${checkoutData?.qrCode?.substring(7) ?? ""}");

    _submit();
  }

  void _submit() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (mMovie!=null)?LoadingOverlayPro(
        isLoading: _isLoading ?? false,
        backgroundColor: TICKET_CONFRMATION_OVERLAY_COLOR,
        progressIndicator: ZoomOut(
          duration: const Duration(seconds: 4),
          child: Center(
            child: Container(
              height: TICKET_CONFIRMATION_SPLASH_SCREEN_HEIGHT,
              child: Stack(
                children: const [
                  Positioned.fill(
                    child: BallonImageView(),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: HomeCinemaImageView(),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextView(),
                  )
                ],
              ),
            ),
          ),
        ),
        child: JelloIn(
            duration: Duration(seconds: 2),
            child: TicketConfirmationSection(widget.cinema, mMovie, snackVO,
                widget.checkoutData, () => _navigateToHomePage(context)))):const Center(child: CircularProgressIndicator(),);
  }

  Future<dynamic> _navigateToHomePage(BuildContext context) {
    return Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomePage(widget.location)));
  }
}

class TextView extends StatelessWidget {
  const TextView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          TICKET_CONFIRMATION_TEXT1,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w800,
            fontSize: TEXT_REGULAR_3X,
            color: Colors.white,
          ),
        ),
        Text(
          TICKET_CONFIRMATION_TEXT2,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w800,
            fontSize: TEXT_REGULAR_3X,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

class HomeCinemaImageView extends StatelessWidget {
  const HomeCinemaImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/homeCinema.png",
    );
  }
}

class BallonImageView extends StatelessWidget {
  const BallonImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/ballon.png",
      height: BALLON_IMAGE_HEIGHT,
    );
  }
}

class TicketConfirmationSection extends StatefulWidget {
  //late Function onTapTicket;
  final CinemaVO? cinema;
  final MovieVO? mMovie;
  final List<SnackVO>? snackVO;
  final CheckOutVO? checkoutData;
  final Function onTapDone;

  TicketConfirmationSection(this.cinema, this.mMovie, this.snackVO,
      this.checkoutData, this.onTapDone);
  //TicketConfirmationPage(this.location);
  @override
  State<TicketConfirmationSection> createState() =>
      _TicketConfirmationSectionState();
}

class _TicketConfirmationSectionState extends State<TicketConfirmationSection>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PAGE_BACKGROUND_COLOR,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: APPBAR_COLOR,
          title: const Text(
            TICKET_CONFIRMATION_PAGE_TITLE,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: TEXT_REGULAR_3X,
                color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.only(
            top: MARGIN_xXLARGE,
          ),
          child: Column(
            children: [
              TicketInfoView(widget.mMovie, widget.cinema, widget.checkoutData,
                  () => this),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              QrAndPinView(
                  "$CINEMA_BASE_URL_DIO/${widget.checkoutData?.qrCode ?? ""}"),
              SizedBox(height: MediaQuery.of(context).size.height / 12),
              DoneButtonView(() => widget.onTapDone())
            ],
          ),
        ));
  }
}

class DoneButtonView extends StatelessWidget {
  final Function onTapDone;
  DoneButtonView(this.onTapDone);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onTapDone(),
      style: TextButton.styleFrom(backgroundColor: PRIMARY_COLOR_1),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Text(
          TICKET_CONFIRMATION_BUTTON_TEXT,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: TEXT_REGULAR_3X,
              color: APPBAR_COLOR),
        ),
      ),
    );
  }
}

class QrAndPinView extends StatefulWidget {
  final String image;
  QrAndPinView(this.image);
  @override
  State<QrAndPinView> createState() => _QrAndPinViewState();
}

class _QrAndPinViewState extends State<QrAndPinView> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.image,
      width: QR_AND_PIN_WIDTH,
      height: QR_AND_PIN_HEIGHT,
    );
  }
}

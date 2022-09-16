import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/about_movie_page.dart';
import 'package:the_movie_booking_app/widgets/drop_down_list_view.dart';
import '../data/vos/movie_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/movie_section_view.dart';

class SearchMoviePage extends StatefulWidget {
  List<MovieVO>? movieList;
  final int index;
  final String location;

  SearchMoviePage(this.movieList, this.index,this.location);
  //late int i = 0;

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  String genresDropDownValue = genresDropDownItem[0];

  String formatDropDownValue = formatDropDownItem[0];

  String monthDropDownValue = monthDropDownItem[0];

  // onTapMovie() => Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => (widget.index == 0)
  //             ? AboutMoviePage(
  //                 false, widget.movieList, widget.i, widget.location)
  //             : AboutMoviePage(
  //                 true, widget.movieList, widget.i, widget.location)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: APPBAR_COLOR,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: MARGIN_MEDIUM_3LX),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: MARGIN_xXLARGE,
            ),
          ),
        ),
        title: const TextField(
          cursorColor: Colors.white,
          style: TextStyle(
            color: DASH_COLOR_2,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              size: MARGIN_MEDIUM_3LX,
              color: Colors.white,
            ),
            hintText: SEARCH_HINT_TEXT,
            hintStyle: TextStyle(color: DASH_COLOR_2),
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: MARGIN_MEDIUM_3LX),
            child: Icon(
              Icons.filter_list_alt,
              color: PRIMARY_COLOR_1,
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 1,
        padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_3LX, vertical: MARGIN_MEDIUM),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SearchTypeView(
                  genresDropDownValue,
                  genresDropDownItem,
                  formatDropDownValue,
                  formatDropDownItem,
                  monthDropDownValue,
                  monthDropDownItem,
                  widget.index),
              const SizedBox(height: MARGIN_xXLARGE),
              MovieSectionView(
                  widget.movieList,
                  widget.index,
                  (movieId) => _navigateToAboutMoviePage(context,movieId))
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToAboutMoviePage(BuildContext context,int movieId) {
    return Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => (widget.index == 0)
                            ? AboutMoviePage(false,
                                movieId, widget.location)
                            : AboutMoviePage(true, movieId,
                                widget.location)));
  }
}

class SearchTypeView extends StatelessWidget {
  final String dropdownValue;
  final String dropdownValue1;
  final String dropdownValue2;

  final List<String> dropDownItem;
  final List<String> dropDownItem1;
  final List<String> dropDownItem2;

  final int index;
  SearchTypeView(this.dropdownValue, this.dropDownItem, this.dropdownValue1,
      this.dropDownItem1, this.dropdownValue2, this.dropDownItem2, this.index);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropDownListView(dropdownValue, dropDownItem),
        const SizedBox(width: MARGIN_MEDIUM_2),
        DropDownListView(dropdownValue1, dropDownItem1),
        const SizedBox(width: MARGIN_MEDIUM_2),
        Visibility(
            visible: (index == 0) ? false : true,
            child: DropDownListView(dropdownValue2, dropDownItem2)),
      ],
    );
  }
}

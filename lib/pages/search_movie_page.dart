import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/about_movie_page.dart';
import 'package:the_movie_booking_app/widgets/drop_down_list_view.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/movie_view.dart';


class SearchMoviePage extends StatefulWidget {
  final List<Map<String, dynamic>> gridData;
  final int index;

  SearchMoviePage(this.gridData, this.index);
  late int i=0;

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  String genresdropdownValue = genresDropDownItem[0];

  String formatdropDownValue = formatDropDownItem[0];

  String monthdropDownValue = monthDropDownItem[0];




  onTapMovie() => Navigator.push(context,
      MaterialPageRoute(builder: (context) => (widget.index==0)?AboutMoviePage(false,widget.gridData,widget.i):AboutMoviePage(true,widget.gridData,widget.i)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        color: PAGE_BACKGROUND_COLOR,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SearchTypeView(genresdropdownValue, genresDropDownItem, formatdropDownValue,
                  formatDropDownItem, monthdropDownValue, monthDropDownItem, widget.index),
              const SizedBox(height: MARGIN_xXLARGE),
             MovieView(widget.gridData, () => onTapMovie(), widget.index,(i){
               widget.i=i;
             })
            ],
          ),
        ),
      ),
    );
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

import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class DropDownListView extends StatefulWidget {
  DropDownListView(this.dropdownValue, this.dropDownItem, {Key? key})
      : super(key: key);
  late String dropdownValue;
  final List<String> dropDownItem;
  @override
  State<DropDownListView> createState() => _DropDownListViewState();
}

class _DropDownListViewState extends State<DropDownListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: SEARCH_MOVIE_DROP_DOWN_LIST_WIDTH,
      height: SEARCH_MOVIE_DROP_DOWN_LIST_HEIGHT,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_X,
          vertical: MARGIN_SMALL_L,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            elevation: 0,
            value: widget.dropdownValue,
            icon: Padding(
              padding: const EdgeInsets.only(left: MARGIN_SMALL_L),
              child: Image.asset(
                "assets/images/select.png",
                width: MARGIN_LARGE,
                height: MARGIN_LARGE,
              ),
            ),
            style: const TextStyle(
                color: APPBAR_COLOR,
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w400),
            onChanged: (String? newValue) {
              setState(() {
                widget.dropdownValue = newValue!;
              });
            },
            items: widget.dropDownItem
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
          ),
        ),
      ),
    );
  }
}

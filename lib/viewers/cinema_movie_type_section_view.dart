import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class MovieTypeSectionView extends StatefulWidget {
  const MovieTypeSectionView({
    Key? key,
    required this.movieTypeList,
  }) : super(key: key);

  final List<String> movieTypeList;

  @override
  State<MovieTypeSectionView> createState() => _MovieTypeSectionViewState();
}

class _MovieTypeSectionViewState extends State<MovieTypeSectionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      padding:  EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Wrap(
        children: widget.movieTypeList
            .map((type) => MovieTypeChipView(type))
            .toList(),
      ),
    );
  }
}

class MovieTypeChipView extends StatefulWidget {
  final String type;
  MovieTypeChipView(this.type);

  @override
  State<MovieTypeChipView> createState() => _MovieTypeChipViewState();
}

class _MovieTypeChipViewState extends State<MovieTypeChipView> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Chip(
          padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_CARD_MEDIUM_2L, vertical: MARGIN_SMALL_L),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MARGIN_SMALL_L),
          ),
          side: const BorderSide(
            width: 1,
            color: Colors.white,
          ),
          backgroundColor: BUTTON_TEXT_COLOR_NS,
          label: Text(
            widget.type,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: TEXT_REGULAR_2X,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: MARGIN_MEDIUM_3LX),
      ],
    );
  }
}
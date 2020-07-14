// ignore_for_file:  lines_longer_than_80_chars

import 'package:flutter/widgets.dart';

const double _activityHorizontalMargin = 22;
const double _activityVerticalMargin = 16;
const double _itemSpacing = 12;
const double _verticalTextSpacing = 4;
const double _horizontalTextSpacing = 3;

const activityMargin = EdgeInsets.only(
  left: _activityHorizontalMargin,
  right: _activityHorizontalMargin,
  bottom: _activityVerticalMargin,
);
const activityHorizontalMargin = EdgeInsets.symmetric(
  horizontal: _activityHorizontalMargin,
);
const activityMarginBottom = EdgeInsets.only(bottom: _activityVerticalMargin);

const itemSpacing = EdgeInsets.all(_itemSpacing);
const itemSpacingTop = EdgeInsets.only(top: _itemSpacing);
const itemSpacingBottom = EdgeInsets.only(bottom: _itemSpacing);
const itemSpacingVertical = EdgeInsets.symmetric(vertical: _itemSpacing);
const itemSpacingHorizontal = EdgeInsets.symmetric(horizontal: _itemSpacing);
const itemSpacingStart = EdgeInsets.only(left: _itemSpacing);
const itemSpacingEnd = EdgeInsets.only(right: _itemSpacing);

const halfItemSpacing = EdgeInsets.all(_itemSpacing / 2);
const halfItemSpacingStart = EdgeInsets.only(left: _itemSpacing / 2);
const halfItemSpacingEnd = EdgeInsets.only(right: _itemSpacing / 2);
const halfItemSpacingTop = EdgeInsets.only(top: _itemSpacing / 2);

const halfItemSpacingVertical =
    EdgeInsets.symmetric(vertical: _itemSpacing / 2);
const halfItemSpacingHorizontal =
    EdgeInsets.symmetric(horizontal: _itemSpacing / 2);

const textSpacingTop = EdgeInsets.only(
  top: _verticalTextSpacing,
);
const textSpacingVertical =
    EdgeInsets.symmetric(vertical: _verticalTextSpacing);
const textSpacingHorizontal = EdgeInsets.symmetric(
  horizontal: _horizontalTextSpacing,
);
const halfTextSpacingVertical = EdgeInsets.symmetric(
  vertical: _verticalTextSpacing / 2,
);
const textSpacingStart = EdgeInsets.only(left: _horizontalTextSpacing);
const textSpacingEnd = EdgeInsets.only(right: _horizontalTextSpacing);

const wideSpacingTop = EdgeInsets.only(top: 24);

const minTapSize = 42.0;

const shortAnimationDuration = Duration(milliseconds: 300);
const mediumAnimationDuration = Duration(milliseconds: 600);

const listPreferredItemHeight = 64.0;
const listPreferredItemHeightSmall = 48.0;
const listPreferredItemHeightLarge = 80.0;


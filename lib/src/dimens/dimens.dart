import 'package:flutter/widgets.dart';

@Deprecated("Activity Margin should be replaced by breakpoint")
const double kActivityHorizontalMargin = 22;

@Deprecated("Activity Margin should be replaced by breakpoint")
const double kActivityVerticalMargin = 16;

@Deprecated("Activity Margin should be replaced by breakpoint")
const activityMargin = EdgeInsets.only(
  left: kActivityHorizontalMargin,
  right: kActivityHorizontalMargin,
  bottom: kActivityVerticalMargin,
);

@Deprecated("Activity Margin should be replaced by breakpoint")
const activityHorizontalMargin = EdgeInsets.symmetric(
  horizontal: kActivityHorizontalMargin,
);

@Deprecated("Activity Margin should be replaced by breakpoint")
const activityMarginBottom = EdgeInsets.only(bottom: kActivityVerticalMargin);

/// https://m3.material.io/foundations/layout/applying-layout/compact#4b2b6814-c64a-4bc0-a07d-6652a91737e6
const double kCompatMargin = 16;
const double kItemSpacing = 12;
const double _verticalTextSpacing = 4;
const double _horizontalTextSpacing = 3;

const spacingHorizontal = EdgeInsets.symmetric(horizontal: kCompatMargin);
const itemSpacing = EdgeInsets.all(kItemSpacing);
const itemSpacingTop = EdgeInsets.only(top: kItemSpacing);
const itemSpacingBottom = EdgeInsets.only(bottom: kItemSpacing);
const itemSpacingVertical = EdgeInsets.symmetric(vertical: kItemSpacing);
const itemSpacingHorizontal = EdgeInsets.symmetric(horizontal: kItemSpacing);
const itemSpacingStart = EdgeInsets.only(left: kItemSpacing);
const itemSpacingEnd = EdgeInsets.only(right: kItemSpacing);

const halfItemSpacing = EdgeInsets.all(kItemSpacing / 2);
const halfItemSpacingStart = EdgeInsets.only(left: kItemSpacing / 2);
const halfItemSpacingEnd = EdgeInsets.only(right: kItemSpacing / 2);
const halfItemSpacingTop = EdgeInsets.only(top: kItemSpacing / 2);

const halfItemSpacingVertical =
    EdgeInsets.symmetric(vertical: kItemSpacing / 2);
const halfItemSpacingHorizontal =
    EdgeInsets.symmetric(horizontal: kItemSpacing / 2);

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
const wideSpacingVertical = EdgeInsets.symmetric(vertical: 24);

const minTapSize = 42.0;

const shortAnimationDuration = Duration(milliseconds: 300);
const mediumAnimationDuration = Duration(milliseconds: 600);

const listPreferredItemHeight = 64.0;
const listPreferredItemHeightSmall = 48.0;
const listPreferredItemHeightLarge = 80.0;

/// https://m3.material.io/foundations/layout/understanding-layout/parts-of-layout#31a74707-af70-4d25-88f9-2fa51b091bea
const paneFixedWidth = 360.0;

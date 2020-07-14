import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../dimens.dart';

EdgeInsets safePadding(BuildContext context) {
  final padding = MediaQuery.of(context).padding;
  return _max(padding, activityMargin);
}

EdgeInsets safePaddingTop(BuildContext context) {
  final padding = MediaQuery.of(context).padding;
  return EdgeInsets.only(
    top: padding.top,
  );
}

EdgeInsets safePaddingVertical(BuildContext context) {
  final padding = MediaQuery.of(context).padding;
  const margin = activityMarginBottom;
  return EdgeInsets.only(
    top: max(padding.top, margin.top),
    bottom: max(padding.bottom, margin.bottom),
  );
}

EdgeInsets safePaddingBottom(BuildContext context) {
  final padding = MediaQuery.of(context).padding;
  return EdgeInsets.only(
    bottom: max(padding.bottom, activityMarginBottom.bottom),
  );
}

EdgeInsets _max(EdgeInsets a, EdgeInsets b) {
  return EdgeInsets.only(
    left: max(a.left, b.left),
    right: max(a.right, b.right),
    top: max(a.top, b.top),
    bottom: max(a.bottom, b.bottom),
  );
}

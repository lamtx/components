import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../dimens.dart';

EdgeInsets safePaddingTop(BuildContext context) {
  final padding = MediaQuery.of(context).padding;
  return EdgeInsets.only(
    top: padding.top,
    right: padding.right,
    left: padding.left,
  );
}

EdgeInsets safePaddingVertical(BuildContext context) {
  final padding = MediaQuery.of(context).padding;
  return EdgeInsets.only(
    top: padding.top,
    bottom: max(padding.bottom, kItemSpacing),
    right: padding.right,
    left: padding.left,
  );
}

EdgeInsets safePaddingBottom(BuildContext context) {
  final padding = MediaQuery.of(context).padding;
  return EdgeInsets.only(
    bottom: max(padding.bottom, kItemSpacing),
    right: padding.right,
    left: padding.left,
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

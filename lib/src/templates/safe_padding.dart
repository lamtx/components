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

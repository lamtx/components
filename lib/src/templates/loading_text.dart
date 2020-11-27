import 'package:flutter/material.dart';

import '../../components.dart';
import '../../dimens.dart';

class LoadingText extends StatelessWidget {
  const LoadingText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: itemSpacing,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              PlatformActivityIndicator(),
              Padding(
                padding: textSpacingStart,
                child: Text(text),
              )
            ],
          ),
        ),
      ),
    );
  }
}

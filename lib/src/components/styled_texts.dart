import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

/// Make Flutter text style (released 2014) is compatible with
/// Material design specs (released 2018)
/// See <a href="https://api.flutter.dev/flutter/material/TextTheme-class.html">more</a>

class Body1 extends StatelessWidget {
  const Body1(
    this.text, {
    this.textAlign,
    this.style,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final TextAlign? textAlign;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodyText1!.merge(style),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

class Subtitle1 extends StatelessWidget {
  const Subtitle1(
    this.text, {
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  final String text;
  final int? maxLines;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.subtitle1!.merge(style),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}

class Subtitle2 extends StatelessWidget {
  const Subtitle2(this.text, {this.maxLines, this.textAlign, this.style});

  final String text;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.subtitle2!.merge(style),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}

class Caption extends StatelessWidget {
  const Caption(
    this.text, {
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.style,
  });

  final String text;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.caption!.merge(style),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}

class Overline extends StatelessWidget {
  const Overline(this.text, {this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.overline!.merge(style),
    );
  }
}

class Headline6 extends StatelessWidget {
  const Headline6(this.text, {this.maxLines});

  final String text;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6,
      maxLines: maxLines,
    );
  }
}

class Headline5 extends StatelessWidget {
  const Headline5(this.text, {this.maxLines, this.style});

  final String text;
  final int? maxLines;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline5!.merge(style),
      maxLines: maxLines,
    );
  }
}

class Headline4 extends StatelessWidget {
  const Headline4(this.text, {this.style, this.maxLines});

  final String text;
  final TextStyle? style;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline4!.merge(style),
      maxLines: maxLines,
    );
  }
}

class Headline3 extends StatelessWidget {
  const Headline3(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline3,
    );
  }
}

class Headline2 extends StatelessWidget {
  const Headline2(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline2,
    );
  }
}

class Headline1 extends StatelessWidget {
  const Headline1(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

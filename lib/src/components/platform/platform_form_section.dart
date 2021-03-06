import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dimens.dart';
import '../misc.dart';

class PlatformFormSection extends StatelessWidget {
  const PlatformFormSection({
    Key? key,
    this.header,
    this.footer,
    required this.children,
  }) : super(key: key);

  final Widget? header;
  final Widget? footer;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (isCupertino) {
      return CupertinoFormSection(
        footer: footer,
        header: header,
        children: children,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (header != null)
          Padding(
            padding: activityHorizontalMargin + itemSpacingTop,
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.overline!,
              child: header!,
            ),
          ),
        ...children,
        if (footer != null)
          Padding(
            padding: activityHorizontalMargin,
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.caption!,
              child: footer!,
            ),
          ),
      ],
    );
  }
}

class PlatformFormRow extends StatelessWidget {
  const PlatformFormRow({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return isCupertino ? CupertinoFormRow(child: child) : child;
  }
}

class PlatformTextFormFieldRow extends StatelessWidget {
  const PlatformTextFormFieldRow({
    Key? key,
    this.controller,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.placeholder,
    this.suffixIcon,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final String? placeholder;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    if (isCupertino) {
      final textField = CupertinoTextFormFieldRow(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction,
        placeholder: placeholder,
        // TODO: where clear button
      );
      if (suffixIcon == null ) {
        return textField;
      } else {
        return Row(
          children: [
            Expanded(child: textField),
            suffixIcon!,
          ],
        );
      }
     } else {
      return Padding(
        padding: activityHorizontalMargin + itemSpacingTop,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            labelText: placeholder,
            suffixIcon: suffixIcon,
          ),
        ),
      );
    }
  }
}

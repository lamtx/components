import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dimens.dart';
import '../misc.dart';
import '../styled_texts.dart';

class PlatformUnderlineTextField extends StatelessWidget {
  const PlatformUnderlineTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.helperText,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.textAlignVertical = TextAlignVertical.center,
    this.onSubmitted,
    this.focusNode,
    this.obscureText = false,
    this.style,
    this.onChanged,
    this.maxLines = 1,
    this.minLines,
    this.enabled,
    this.showClearButtonOniOS = true,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding = itemSpacingVertical,
    this.textInputAction,
    this.readOnly = false,
    this.autocorrect = true,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final TextAlignVertical textAlignVertical;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextStyle? style;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final bool showClearButtonOniOS;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets contentPadding;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final bool autocorrect;

  @override
  Widget build(BuildContext context) {
    // TODO: check color null
    final color =
        Theme.of(context).inputDecorationTheme.enabledBorder?.borderSide.color;

    if (isCupertino) {
      final textField = CupertinoTextField(
        placeholder: hintText ?? labelText,
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        autofocus: autofocus,
        textAlignVertical: textAlignVertical,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        obscureText: obscureText,
        style: style,
        onChanged: onChanged,
        maxLines: maxLines,
        minLines: minLines,
        enabled: enabled,
        clearButtonMode: showClearButtonOniOS
            ? OverlayVisibilityMode.editing
            : OverlayVisibilityMode.never,
        padding: contentPadding,
        decoration: color == null
            ? null
            : BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: color,
                  ),
                ),
              ),
        prefix: prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(8),
                child: prefixIcon,
              ),
        textInputAction: textInputAction,
        suffix: suffixIcon,
        readOnly: readOnly,
        autocorrect:
            autocorrect && keyboardType != TextInputType.visiblePassword,
      );
      if (labelText != null || helperText != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (labelText != null) Caption(labelText!),
            textField,
            if (helperText != null)
              Padding(
                padding: textSpacingTop,
                child: Caption(helperText!),
              )
          ],
        );
      } else {
        return textField;
      }
    } else {
      return TextField(
        style: style,
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        decoration: color == null
            ? const InputDecoration()
            : InputDecoration(
                border: const UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: color,
                  ),
                ),
                contentPadding: itemSpacingVertical,
                hintText: hintText,
                helperText: helperText,
                labelText: labelText,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
              ),
        autofocus: autofocus,
        textAlignVertical: textAlignVertical,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        obscureText: obscureText,
        onChanged: onChanged,
        maxLines: maxLines,
        minLines: minLines,
        enabled: enabled,
        textInputAction: textInputAction,
        readOnly: readOnly,
        autocorrect: autocorrect,
      );
    }
  }
}

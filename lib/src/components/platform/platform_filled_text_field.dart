import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dimens.dart';
import '../misc.dart';

class PlatformFilledTextField extends StatelessWidget {
  const PlatformFilledTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.textAlignVertical,
    this.onSubmitted,
    this.focusNode,
    this.obscureText = false,
    this.style,
    this.onChanged,
    this.maxLines = 1,
    this.minLines,
    this.enabled,
    this.isDense = false,
    this.autocorrect = true,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @required
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final TextAlignVertical? textAlignVertical;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextStyle? style;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final bool isDense;
  final bool autocorrect;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    if (isCupertino) {
      return CupertinoTextField(
        placeholder: hintText,
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
        clearButtonMode: suffixIcon == null
            ? OverlayVisibilityMode.editing
            : OverlayVisibilityMode.never,
        padding: itemSpacing,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: const Border(),
        ),
        autocorrect:
            autocorrect && keyboardType != TextInputType.visiblePassword,
        prefix: prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(8),
                child: prefixIcon,
              ),
        suffix: suffixIcon,
      );
    } else {
      const border = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide.none,
      );
      return TextField(
        controller: controller,
        autofocus: autofocus,
        focusNode: focusNode,
        decoration: InputDecoration(
          isDense: isDense,
          contentPadding:
              itemSpacingHorizontal + const EdgeInsets.symmetric(vertical: 8),
          enabledBorder: border,
          border: border,
          filled: true,
          hintText: hintText,
          fillColor: Theme.of(context).canvasColor,
          hintMaxLines: 1,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        keyboardType: TextInputType.multiline,
        textCapitalization: TextCapitalization.sentences,
        maxLines: maxLines,
        minLines: minLines,
        enabled: enabled,
        autocorrect: autocorrect,
      );
    }
  }
}

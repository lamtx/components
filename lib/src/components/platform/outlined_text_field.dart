import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../misc.dart';

abstract class OutlinedTextField extends StatelessWidget {
  factory OutlinedTextField({
    Key? key,
    required TextEditingController? controller,
    String? hintText,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool autofocus = false,
    TextAlignVertical textAlignVertical = TextAlignVertical.center,
    ValueChanged<String>? onSubmitted,
    FocusNode? focusNode,
    bool obscureText = false,
    TextStyle? style,
    ValueChanged<String>? onChanged,
    int? maxLines = 1,
    int? minLines,
    bool? enabled,
    bool showClearButtonOniOS = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputAction? textInputAction,
    bool readOnly = false,
    bool autocorrect = true,
    VoidCallback? onTap,
  }) {
    if (isCupertino) {
      return _IOSOutlinedTextField(
        key: key,
        controller: controller,
        hintText: hintText,
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
        showClearButtonOniOS: showClearButtonOniOS,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        textInputAction: textInputAction,
        readOnly: readOnly,
        autocorrect: autocorrect,
        onTap: onTap,
      );
    } else {
      return _AndroidOutlinedTextField(
        key: key,
        controller: controller,
        hintText: hintText,
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
        showClearButtonOniOS: showClearButtonOniOS,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        textInputAction: textInputAction,
        readOnly: readOnly,
        autocorrect: autocorrect,
        onTap: onTap,
      );
    }
  }

  const OutlinedTextField._({
    Key? key,
    required this.controller,
    this.hintText,
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
    this.textInputAction,
    this.readOnly = false,
    this.autocorrect = true,
    this.onTap,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
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
  final TextInputAction? textInputAction;
  final bool readOnly;
  final bool autocorrect;
  final VoidCallback? onTap;
}

class _AndroidOutlinedTextField extends OutlinedTextField {
  const _AndroidOutlinedTextField({
    Key? key,
    required TextEditingController? controller,
    String? hintText,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool autofocus = false,
    TextAlignVertical textAlignVertical = TextAlignVertical.center,
    ValueChanged<String>? onSubmitted,
    FocusNode? focusNode,
    bool obscureText = false,
    TextStyle? style,
    ValueChanged<String>? onChanged,
    int? maxLines,
    int? minLines,
    bool? enabled,
    bool showClearButtonOniOS = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputAction? textInputAction,
    bool readOnly = false,
    bool autocorrect = true,
    VoidCallback? onTap,
  }) : super._(
          key: key,
          controller: controller,
          hintText: hintText,
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
          showClearButtonOniOS: showClearButtonOniOS,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          textInputAction: textInputAction,
          readOnly: readOnly,
          autocorrect: autocorrect,
          onTap: onTap,
        );

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: style,
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: false,
        hintText: hintText,
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
      onTap: onTap,
    );
  }
}

class _IOSOutlinedTextField extends OutlinedTextField {
  const _IOSOutlinedTextField({
    Key? key,
    required TextEditingController? controller,
    String? hintText,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool autofocus = false,
    TextAlignVertical textAlignVertical = TextAlignVertical.center,
    ValueChanged<String>? onSubmitted,
    FocusNode? focusNode,
    bool obscureText = false,
    TextStyle? style,
    ValueChanged<String>? onChanged,
    int? maxLines,
    int? minLines,
    bool? enabled,
    bool showClearButtonOniOS = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputAction? textInputAction,
    bool readOnly = false,
    bool autocorrect = true,
    VoidCallback? onTap,
  }) : super._(
          key: key,
          controller: controller,
          hintText: hintText,
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
          showClearButtonOniOS: showClearButtonOniOS,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          textInputAction: textInputAction,
          readOnly: readOnly,
          autocorrect: autocorrect,
          onTap: onTap,
        );

  @override
  Widget build(BuildContext context) {
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
      autocorrect: autocorrect && keyboardType != TextInputType.visiblePassword,
      prefix: prefixIcon,
      suffix: suffixIcon,
    );
  }
}

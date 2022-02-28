import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../dimens.dart';

abstract class FilledTextField extends StatelessWidget {
  factory FilledTextField({
    Key? key,
    required TextEditingController? controller,
    String? hintText,
    String? labelText,
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
    bool optimizePrefixIconOnIOS = true,
  }) {
    if (isCupertino) {
      return _IOSFilledTextField(
        key: key,
        controller: controller,
        hintText: hintText,
        labelText: labelText,
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
        optimizePrefixIconOnIOS: optimizePrefixIconOnIOS,
      );
    } else {
      return _AndroidFieldTextField(
        key: key,
        controller: controller,
        hintText: hintText,
        labelText: labelText,
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

  const FilledTextField._({
    Key? key,
    required this.controller,
    this.hintText,
    this.labelText,
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
    this.optimizePrefixIconOnIOS = true,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
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
  final bool optimizePrefixIconOnIOS;
}

class _AndroidFieldTextField extends FilledTextField {
  const _AndroidFieldTextField({
    Key? key,
    required TextEditingController? controller,
    String? hintText,
    String? labelText,
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
          labelText: labelText,
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
        border: const UnderlineInputBorder(),
        filled: true,
        hintText: hintText,
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
      onTap: onTap,
    );
  }
}

class _IOSFilledTextField extends FilledTextField {
  const _IOSFilledTextField({
    Key? key,
    required TextEditingController? controller,
    String? hintText,
    String? labelText,
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
    bool optimizePrefixIconOnIOS = true,
  }) : super._(
          key: key,
          controller: controller,
          hintText: hintText,
          labelText: labelText,
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
          optimizePrefixIconOnIOS: optimizePrefixIconOnIOS,
        );

  @override
  Widget build(BuildContext context) {
    final effectivePrefix = (prefixIcon == null || !optimizePrefixIconOnIOS)
        ? prefixIcon
        : ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 44,
              minWidth: 44,
            ),
            child: prefixIcon,
          );
    final textField = CupertinoTextField(
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
      prefix: effectivePrefix,
      suffix: suffixIcon ?? SizedBox.fromSize(size: const Size.square(44)),
      decoration: const BoxDecoration(
        color: CupertinoColors.tertiarySystemFill,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
    if (labelText == null) {
      return textField;
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Caption(labelText!),
          ),
          Padding(
            padding: textSpacingTop,
            child: textField,
          ),
        ],
      );
    }
  }
}

import 'package:flutter/material.dart';

class OutlinedTextField extends StatelessWidget {
  const OutlinedTextField({
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

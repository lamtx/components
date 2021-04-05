import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cupertino_highlight.dart';
import 'cupertino_radio.dart';
import 'misc.dart';
import 'styled_texts.dart';

export 'platform/platform_app.dart';
export 'platform/platform_app_bar.dart';
export 'platform/platform_expand_icon.dart';
export 'platform/platform_filled_text_field.dart';
export 'platform/platform_icon_button.dart';
export 'platform/platform_scaffold.dart';
export 'platform/platform_tab_scaffold.dart';
export 'platform/platform_underline_text_field.dart';
// ignore_for_file: non_constant_identifier_names

Widget PlatformAlertDialog({
  Widget? title,
  Widget? content,
  List<Widget> actions = const <Widget>[],
  ShapeBorder? shape,
}) {
  if (isCupertino) {
    return CupertinoAlertDialog(
      title: title,
      content: content,
      actions: actions,
    );
  } else {
    return AlertDialog(
      title: title,
      content: content,
      actions: actions,
      shape: shape,
    );
  }
}

Widget PlatformInkWell({
  Widget? child,
  VoidCallback? onTap,
  VoidCallback? onLongPress,
}) {
  if (isCupertino) {
    return CupertinoHighlight(
      onTap: onTap,
      onLongPress: onLongPress,
      child: child,
    );
  } else {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: child,
    );
  }
}

Widget FilledButton({
  VoidCallback? onPressed,
  required Widget child,
}) {
  if (isCupertino) {
    return CupertinoButton.filled(
      onPressed: onPressed,
      child: child,
    );
  } else {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

Widget Button({
  required VoidCallback? onPressed,
  required Widget child,
  EdgeInsets? padding,
}) {
  if (isCupertino) {
    return CupertinoButton(
      padding: padding,
      onPressed: onPressed,
      child: child,
    );
  } else {
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

Widget DialogButton({
  VoidCallback? onPressed,
  required Widget child,
  bool isDefaultAction = false,
  bool isDestructiveAction = false,
}) {
  if (isCupertino) {
    return CupertinoDialogAction(
      onPressed: onPressed,
      isDefaultAction: isDefaultAction,
      isDestructiveAction: isDestructiveAction,
      child: child,
    );
  } else {
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

Future<T?> showPlatformDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool useRootNavigator = true,
  bool? barrierDismissible,
}) {
  if (isCupertino) {
    return showCupertinoDialog(
      context: context,
      builder: builder,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible ?? false,
    );
  } else {
    return showDialog(
      context: context,
      builder: builder,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible ?? true,
    );
  }
}

Widget PlatformTextField({
  required TextEditingController? controller,
  TextInputType? keyboardType,
  TextCapitalization textCapitalization = TextCapitalization.none,
  InputDecoration? decoration = const InputDecoration(),
  bool autofocus = false,
  TextAlignVertical? textAlignVertical,
  ValueChanged<String>? onSubmitted,
  FocusNode? focusNode,
  bool obscureText = false,
  TextStyle? style,
  ValueChanged<String>? onChanged,
  int? maxLines = 1,
  int? minLines,
  bool? enabled,
  TextInputAction? textInputAction,
  bool autocorrect = true,
}) {
  if (isCupertino) {
    final textField = CupertinoTextField(
      placeholder: decoration?.hintText,
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
      clearButtonMode: OverlayVisibilityMode.editing,
      textInputAction: textInputAction,
      suffix: decoration?.suffixIcon,
      prefix: decoration?.prefixIcon,
      autocorrect: autocorrect && keyboardType != TextInputType.visiblePassword,
    );
    if (decoration != null) {
      final labelText = decoration.labelText;
      final helperText = decoration.helperText;
      if (labelText != null || helperText != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (labelText != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Caption(labelText),
              ),
            textField,
            if (helperText != null)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Caption(helperText),
              )
          ],
        );
      }
    }
    return textField;
  } else {
    return TextField(
      style: style,
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      decoration: decoration,
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
      autocorrect: autocorrect,
    );
  }
}

PageRoute<T> PlatformPageRoute<T>({
  required WidgetBuilder builder,
  required String? title,
  bool fullscreenDialog = false,
  RouteSettings? settings,
}) {
  if (isCupertino) {
    return CupertinoPageRoute(
      builder: builder,
      fullscreenDialog: fullscreenDialog,
      title: title,
      settings: settings,
    );
  } else {
    return MaterialPageRoute(
      builder: builder,
      fullscreenDialog: fullscreenDialog,
      settings: settings,
    );
  }
}

Widget PlatformRadio<T>({
  required T value,
  required T? groupValue,
  required ValueChanged<T?> onChanged,
}) {
  if (isCupertino) {
    return CupertinoRadio<T>(
      value: value,
      groupValue: groupValue,
    );
  } else {
    return Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}

Widget PlatformSwitch({
  required bool value,
  required ValueChanged<bool>? onChanged,
}) {
  if (isCupertino) {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
    );
  } else {
    return Switch(
      value: value,
      onChanged: onChanged,
    );
  }
}

Widget PlatformCheckbox({
  required bool value,
  required ValueChanged<bool?> onChanged,
}) {
  if (isCupertino) {
    return CupertinoRadio<bool>(
      value: value,
      groupValue: true,
    );
  } else {
    return Checkbox(
      value: value,
      onChanged: onChanged,
    );
  }
}

Widget PlatformSlider({
  ValueChanged<double>? onChanged,
  double max = 1,
  double min = 0,
  required double value,
  Color? inactiveColor,
  Color? activeColor,
  int? divisions,
  bool avoidPadding = false,
}) {
  assert(max >= min);
  assert(min <= value && value <= max);
  if (isCupertino) {
    final invalid = max != min;
    final child = CupertinoSlider(
      max: invalid ? max : 1,
      min: invalid ? min : 0,
      divisions: invalid ? divisions : null,
      activeColor: activeColor,
      value: invalid ? value : 0,
      onChanged: invalid ? onChanged : null,
    );
    if (avoidPadding) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: child,
      );
    } else {
      return child;
    }
  } else {
    return Slider(
      max: max,
      min: min,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      value: value,
      onChanged: onChanged,
      divisions: divisions,
    );
  }
}

Widget PlatformActivityIndicator() {
  if (isCupertino) {
    return const CupertinoActivityIndicator();
  } else {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
    );
  }
}

class PlatformCloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (isCupertino) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.of(context).maybePop();
        },
        child: const Text('Close'),
      );
    } else {
      return const CloseButton();
    }
  }
}

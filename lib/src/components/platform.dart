import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cupertino_highlight.dart';
import 'cupertino_radio.dart';
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
  Widget title,
  Widget content,
  List<Widget> actions,
  ShapeBorder shape,
}) {
  if (Platform.isIOS) {
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
  Widget child,
  VoidCallback onTap,
  VoidCallback onLongPress,
}) {
  if (Platform.isIOS) {
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
  VoidCallback onPressed,
  Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoButton.filled(
      onPressed: onPressed,
      child: child,
    );
  } else {
    return RaisedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

Widget Button({
  @required VoidCallback onPressed,
  @required Widget child,
  EdgeInsets padding,
}) {
  if (Platform.isIOS) {
    return CupertinoButton(
      padding: padding,
      onPressed: onPressed,
      child: child,
    );
  } else {
    return FlatButton(
      padding: padding,
      onPressed: onPressed,
      child: child,
    );
  }
}

Widget DialogButton({
  VoidCallback onPressed,
  Widget child,
  bool isDefaultAction = false,
  bool isDestructiveAction = false,
}) {
  if (Platform.isIOS) {
    return CupertinoDialogAction(
      onPressed: onPressed,
      isDefaultAction: isDefaultAction,
      isDestructiveAction: isDestructiveAction,
      child: child,
    );
  } else {
    return FlatButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

Future<T> showPlatformDialog<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
  bool useRootNavigator = true,
  bool barrierDismissible,
}) {
  if (Platform.isIOS) {
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
  @required TextEditingController controller,
  TextInputType keyboardType,
  TextCapitalization textCapitalization = TextCapitalization.none,
  InputDecoration decoration = const InputDecoration(),
  bool autofocus = false,
  TextAlignVertical textAlignVertical,
  ValueChanged<String> onSubmitted,
  FocusNode focusNode,
  bool obscureText = false,
  TextStyle style,
  ValueChanged<String> onChanged,
  int maxLines = 1,
  int minLines,
  bool enabled,
}) {
  if (Platform.isIOS) {
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
    );
  }
}

PageRoute<T> PlatformPageRoute<T>({
  @required WidgetBuilder builder,
  @required String title,
  bool fullscreenDialog = false,
  RouteSettings settings,
}) {
  if (Platform.isIOS) {
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
  @required T value,
  @required T groupValue,
  @required ValueChanged<T> onChanged,
}) {
  if (Platform.isIOS) {
    return CupertinoRadio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
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
  bool value,
  ValueChanged<bool> onChanged,
}) {
  if (Platform.isIOS) {
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
  bool value,
  ValueChanged<bool> onChanged,
}) {
  if (Platform.isIOS) {
    return CupertinoRadio<bool>(
      value: value,
      groupValue: true,
      onChanged: onChanged,
    );
  } else {
    return Checkbox(
      value: value,
      onChanged: onChanged,
    );
  }
}

Widget PlatformSlider({
  ValueChanged<double> onChanged,
  double max = 1,
  double min = 0,
  @required double value,
  Color inactiveColor,
  Color activeColor,
  int divisions,
  bool avoidPadding = false,
}) {
  assert(min != null);
  assert(max != null);
  assert(value != null);
  assert(max >= min);
  assert(min <= value && value <= max);
  if (Platform.isIOS) {
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
  if (Platform.isIOS) {
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
    if (Platform.isIOS) {
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

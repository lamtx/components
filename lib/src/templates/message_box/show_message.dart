import 'dart:async';
import 'dart:convert';

import 'package:ext/ext.dart';
import 'package:flutter/material.dart';

import '../../../components2.dart';
import '../../../dimens.dart';
import '../template_messages.dart';

enum DialogButtonType { positive, negative, neutral }

enum DialogButtonStyle { normal, cancellation, destructive }

final class ActionButton {
  const ActionButton({
    required this.text,
    required this.type,
    this.style = DialogButtonStyle.normal,
  });

  ActionButton.positive(
    String text, {
    DialogButtonStyle style = DialogButtonStyle.normal,
  }) : this(
          text: (_) => text,
          type: DialogButtonType.positive,
          style: style,
        );

  ActionButton.negative(
    String text, {
    DialogButtonStyle style = DialogButtonStyle.cancellation,
  }) : this(
          text: (_) => text,
          type: DialogButtonType.negative,
          style: style,
        );

  ActionButton.neutral(
    String text, {
    DialogButtonStyle style = DialogButtonStyle.normal,
  }) : this(
          text: (_) => text,
          type: DialogButtonType.neutral,
          style: style,
        );

  final String Function(BuildContext) text;
  final DialogButtonType type;
  final DialogButtonStyle style;

  static const ActionButton ok = ActionButton(
    type: DialogButtonType.positive,
    text: _okText,
  );

  static String _okText(BuildContext context) => "OK";
}

/// Uses FutureOr to allow the caller to ignore the result.
/// The return value is always Future<ActionButton?>
FutureOr<ActionButton?> showMessage(
  BuildContext context, {
  String? message,
  Widget? content,
  String? title,
  List<ActionButton> actions = const [ActionButton.ok],
}) {
  final titleUI = title == null ? null : Text(title);

  return showPlatformDialog(
    context: context,
    builder: (context) => PlatformAlertDialog(
      title: titleUI,
      content: _buildContent(content, message),
      actions: actions.map((e) {
        return DialogButton(
          onPressed: () {
            Navigator.of(context).pop(e);
          },
          isDefaultAction: e.style == DialogButtonStyle.cancellation,
          isDestructiveAction: e.style == DialogButtonStyle.destructive,
          child: Text(e.text(context)),
        );
      }).toList(),
    ),
  );
}

Future<bool> askMessage(
  BuildContext context, {
  required String message,
  String? title,
  String? action,
  String? negativeAction,
  bool isDeletion = false,
}) async {
  final val = await showMessage(
    context,
    message: message,
    title: title,
    actions: [
      ActionButton.negative(
          negativeAction ?? TemplateMessages.of(context).cancel),
      ActionButton.positive(
        action ?? TemplateMessages.of(context).yes,
        style: isDeletion
            ? DialogButtonStyle.destructive
            : DialogButtonStyle.normal,
      )
    ],
  );
  return val?.type == DialogButtonType.positive;
}

Widget _buildContent(Widget? content, String? message) {
  assert((message == null) != (content == null),
      "Only message or content provided");
  if (content != null) {
    return content;
  } else {
    if (message!.contains("\n")) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const LineSplitter().convert(message).indexed.mapToList(
              (e) => e.$1 == 0
                  ? Text(e.$2)
                  : Padding(
                      padding: textSpacingTop,
                      child: Text(e.$2),
                    ),
            ),
      );
    } else {
      return Text(message);
    }
  }
}

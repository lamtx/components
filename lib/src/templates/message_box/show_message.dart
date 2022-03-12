import 'package:flutter/material.dart';

import '../../../components.dart';
import '../template_messages.dart';

enum DialogButtonType { positive, negative, neutral }

enum DialogButtonStyle { normal, cancellation, destructive }

class ActionButton {
  const ActionButton({
    required this.text,
    required this.type,
    this.style = DialogButtonStyle.normal,
  });

  ActionButton.positive(String text,
      {DialogButtonStyle style = DialogButtonStyle.normal})
      : this(
          text: (_) => text,
          type: DialogButtonType.positive,
          style: style,
        );

  ActionButton.negative(String text,
      {DialogButtonStyle style = DialogButtonStyle.cancellation})
      : this(
          text: (_) => text,
          type: DialogButtonType.negative,
          style: style,
        );

  ActionButton.neutral(String text,
      {DialogButtonStyle style = DialogButtonStyle.normal})
      : this(
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

Future<ActionButton?> showMessage(
  BuildContext context, {
  String? message,
  Widget? content,
  String? title,
  List<ActionButton> actions = const [ActionButton.ok],
}) {
  final titleUI = title == null ? null : Text(title);
  final contentUI = content ?? Text(message!);
  return showPlatformDialog(
    context: context,
    builder: (context) => PlatformAlertDialog(
      title: titleUI,
      content: contentUI,
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
    useRootNavigator: true,
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

import 'package:flutter/material.dart';

import '../../../components.dart';
import '../template_messages.dart';

enum ButtonType { positive, negative, neutral }
enum ButtonStyle { normal, cancellation, destructive }

class ActionButton {
  const ActionButton({
    required this.text,
    required this.type,
    this.style = ButtonStyle.normal,
  });

  ActionButton.positive(String text, {ButtonStyle style = ButtonStyle.normal})
      : this(
          text: (_) => text,
          type: ButtonType.positive,
          style: style,
        );

  ActionButton.negative(String text,
      {ButtonStyle style = ButtonStyle.cancellation})
      : this(
          text: (_) => text,
          type: ButtonType.negative,
          style: style,
        );

  ActionButton.neutral(String text, {ButtonStyle style = ButtonStyle.normal})
      : this(
          text: (_) => text,
          type: ButtonType.neutral,
          style: style,
        );

  final String Function(BuildContext) text;
  final ButtonType type;
  final ButtonStyle style;

  static const ActionButton ok = ActionButton(
    type: ButtonType.positive,
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      actions: actions.map((e) {
        return DialogButton(
          onPressed: () {
            Navigator.of(context).pop(e);
          },
          isDefaultAction: e.style == ButtonStyle.cancellation,
          isDestructiveAction: e.style == ButtonStyle.destructive,
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
        style: isDeletion ? ButtonStyle.destructive : ButtonStyle.normal,
      )
    ],
  );
  return val?.type == ButtonType.positive;
}

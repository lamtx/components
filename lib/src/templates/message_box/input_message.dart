import 'dart:io';

import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../dimens.dart';
import '../template_messages.dart';

Future<String?> inputMessage(
  BuildContext context, {
  required String title,
  String? action,
  String? defaultValue,
  TextInputType keyboardType = TextInputType.text,
  TextCapitalization textCapitalization = TextCapitalization.words,
}) {
  final controller = TextEditingController(text: defaultValue);

  return showPlatformDialog(
    context: context,
    builder: (context) {
      return PlatformAlertDialog(
        title: Text(title),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        content: Padding(
          padding: itemSpacingTop,
          child: PlatformTextField(
            controller: controller,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 6),
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(),
              isDense: true,
            ),
            autofocus: true,
          ),
        ),
        actions: [
          if (Platform.isIOS)
            DialogButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              isDefaultAction: true,
              child: Text(TemplateMessages.of(context).cancel),
            ),
          DialogButton(
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
            child: Text(action ?? "OK"),
          )
        ],
      );
    },
  );
}

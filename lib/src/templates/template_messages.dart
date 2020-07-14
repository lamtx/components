import 'package:flutter/material.dart';

class TemplateMessages {
  const TemplateMessages();

  static const LocalizationsDelegate<TemplateMessages> delegate =
      _MessagesDelegate();

  String get noItems => "Nothing to show here.";

  String get yes => "Yes";

  String get cancel => "Cancel";

  static TemplateMessages of(BuildContext context) {
    final widget = Localizations.of(context, TemplateMessages);
    if (widget == null) {
      throw StateError("TemplateMessages not found in the widget tree");
    }
    return widget;
  }
}

class _ViTemplateMessages implements TemplateMessages {
  const _ViTemplateMessages();

  @override
  String get cancel => "Huỷ";

  @override
  String get noItems => "Không có dữ liệu.";

  @override
  String get yes => "Có";
}

class _MessagesDelegate extends LocalizationsDelegate<TemplateMessages> {
  const _MessagesDelegate();

  @override
  bool isSupported(Locale locale) =>
      const ["en", "vi"].contains(locale.languageCode);

  @override
  Future<TemplateMessages> load(Locale locale) async {
    if (locale.languageCode == "vi") {
      return const _ViTemplateMessages();
    }
    return const TemplateMessages();
  }

  @override
  bool shouldReload(LocalizationsDelegate<TemplateMessages> old) => false;
}

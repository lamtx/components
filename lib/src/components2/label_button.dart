import 'package:flutter/material.dart';

class LabelButton extends StatelessWidget {
  const LabelButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  const factory LabelButton.outlined({
    required VoidCallback? onPressed,
    required Widget child,
    Key key,
  }) = _LabelOutlinedButton;

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(
          Theme.of(context).textTheme.labelMedium,
        ),
        minimumSize: WidgetStateProperty.all(const Size(48, 0)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 4, horizontal: 6)),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

class _LabelOutlinedButton extends LabelButton {
  const _LabelOutlinedButton({
    required super.onPressed,
    required super.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(
          Theme.of(context).textTheme.labelMedium,
        ),
        minimumSize: WidgetStateProperty.all(const Size(48, 0)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 4, horizontal: 6)),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

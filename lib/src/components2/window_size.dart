import 'package:flutter/material.dart';

enum WindowSize {
  compact,
  medium,
  expanded;

  static WindowSize fromMaxWidth(double maxWidth) => switch (maxWidth) {
        < 600.0 => WindowSize.compact,
        < 840.0 => WindowSize.medium,
        _ => WindowSize.expanded,
      };

  static WindowSize fromConstraints(BoxConstraints constraints) =>
      fromMaxWidth(constraints.maxWidth);

  static WindowSize fromMediaQuery(BuildContext context) =>
      fromMaxWidth(MediaQuery.of(context).size.width);
}

extension CanonicalLayout on WindowSize {
  /// https://m3.material.io/foundations/layout/applying-layout/window-size-classes#9e672e77-6d02-4f2b-841e-34c9136a702b
  int get panes => switch (this) {
        WindowSize.compact || WindowSize.medium => 1,
        WindowSize.expanded => 2,
      };

  /// Should not use Full-screen dialog.
  bool get shouldUseSimpleDialog => this != WindowSize.compact;

  /// Different spacing between this window size and [WindowSize.compact].
  double get additionalSpacing => switch (this) {
        WindowSize.compact => 0,
        WindowSize.medium || WindowSize.expanded => 8,
      };
}

extension WindowSizeOperators on WindowSize {
  /// Whether this [WindowSize] is larger than [other].
  bool operator >(WindowSize other) => index > other.index;

  /// Whether this [WindowSize] is larger than or equal to [other].
  bool operator >=(WindowSize other) => index >= other.index;

  /// Whether this [WindowSize] is smaller than [other].
  bool operator <(WindowSize other) => index < other.index;

  /// Whether this [WindowSize] is smaller than or equal to [other].
  bool operator <=(WindowSize other) => index <= other.index;
}

class WindowSizeBuilder extends StatelessWidget {
  const WindowSizeBuilder({
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext context, WindowSize windowSize) builder;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => builder(
          context,
          WindowSize.fromConstraints(constraints),
        ),
      );
}

class WindowSizeProvider extends StatelessWidget {
  const WindowSizeProvider({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _WindowsSizeScope(
      windowSize: WindowSize.fromMediaQuery(context),
      child: child,
    );
  }

  static WindowSize of(BuildContext context) {
    final data =
        context.dependOnInheritedWidgetOfExactType<_WindowsSizeScope>() ??
            (throw FlutterError(
              'WindowSizeProvider.of() was called with a context that does not '
              'contain a WindowSizeProvider widget.\n'
              'The context used was:\n'
              '  $context',
            ));
    return data.windowSize;
  }
}

class _WindowsSizeScope extends InheritedWidget {
  const _WindowsSizeScope({required this.windowSize, required super.child});

  final WindowSize windowSize;

  @override
  bool updateShouldNotify(_WindowsSizeScope oldWidget) {
    return windowSize != oldWidget.windowSize;
  }
}

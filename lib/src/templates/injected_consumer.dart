import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class InjectedConsumer<T extends ChangeNotifier> extends StatelessWidget {
  const InjectedConsumer({
    required this.builder,
    this.param1,
    this.param2,
    super.key,
    this.child,
  });

  final Widget Function(
    BuildContext context,
    T value,
    Widget? child,
  ) builder;
  final Object? param1;
  final Object? param2;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GetIt.instance.get<T>(param1: param1, param2: param2),
      child: Consumer<T>(
        builder: builder,
        child: child,
      ),
    );
  }
}

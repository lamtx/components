import 'package:flutter/material.dart';

class LoadingInfo extends StatelessWidget {
  const LoadingInfo();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}

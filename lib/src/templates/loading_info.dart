import 'package:flutter/material.dart';

import '../../components.dart';

class LoadingInfo extends StatelessWidget {
  const LoadingInfo();

  @override
  Widget build(BuildContext context) {
    return Center(child: PlatformActivityIndicator());
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabSegmentedControl extends StatefulWidget {
  const TabSegmentedControl({Key? key, required this.children})
      : super(key: key);

  final List<Widget> children;

  @override
  _TabSegmentedControlState createState() => _TabSegmentedControlState();
}

class _TabSegmentedControlState extends State<TabSegmentedControl> {
  TabController? _controller;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<int>(
      onValueChanged: (value) {
        if (value != null) {
          DefaultTabController.of(context)!.index = value;
        }
      },
      groupValue: _currentIndex,
      children: widget.children.asMap(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabController();
  }

  bool get _controllerIsValid => _controller?.animation != null;

  void _updateTabController() {
    final newController = DefaultTabController.of(context);
    if (newController == _controller) {
      return;
    }
    if (_controllerIsValid) {
      _controller!.removeListener(_handleTabControllerTick);
    }
    _controller = newController;
    if (_controller != null) {
      _controller!.addListener(_handleTabControllerTick);
      _currentIndex = _controller!.index;
    }
  }

  void _handleTabControllerTick() {
    _currentIndex = _controller!.index;
    setState(() {});
  }
}

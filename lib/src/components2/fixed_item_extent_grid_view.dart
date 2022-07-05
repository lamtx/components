import 'package:flutter/material.dart';

class FixedItemExtentGridView extends StatelessWidget {
  const FixedItemExtentGridView.builder({
    required this.itemExtent,
    required this.columnCount,
    required this.itemCount,
    required this.itemBuilder,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    super.key,
  });

  final EdgeInsets? padding;
  final double itemExtent;
  final int columnCount;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final ScrollPhysics? physics;

  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final padding = this.padding ?? EdgeInsets.zero;
    final size = MediaQuery.of(context).size;
    final itemWidth = (size.width - padding.left - padding.right) / columnCount;
    return GridView.builder(
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        childAspectRatio: itemWidth / itemExtent,
      ),
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );
  }
}

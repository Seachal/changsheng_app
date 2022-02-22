import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


//// 骨架屏列表
class SPClassSkeletonList extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final int length;
  final IndexedWidgetBuilder builder;

  const SPClassSkeletonList({
    this.padding = const EdgeInsets.all(7),
    this.length = 6,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isDark = theme.brightness == Brightness.dark;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Shimmer.fromColors(
        period: Duration(milliseconds: 1200),
        baseColor: isDark ? Colors.grey[700]! : Colors.grey[350]!,
        highlightColor: isDark ? Colors.grey[500]! : Colors.grey[200]!,
        child: Padding(
          padding: padding,
          child: Column(
            children: List.generate(length, (index) => builder(context, index)),
          ),
        ),
      ),
    );
  }
}
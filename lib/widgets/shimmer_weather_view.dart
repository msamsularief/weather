import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWeatherView extends StatelessWidget {
  const ShimmerWeatherView({
    super.key,
    required this.isLoading,
    required this.child,
    this.childWhenLoading,
    this.borderRadius,
  });

  final bool isLoading;
  final Widget child;
  final Widget? childWhenLoading;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    if (isLoading && childWhenLoading == null) {
      return child;
    } else if (isLoading && childWhenLoading != null) {
      return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey.shade200,
        child: childWhenLoading!,
      );
    } else {
      return child;
    }
  }
}

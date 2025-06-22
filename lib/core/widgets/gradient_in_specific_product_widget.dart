import 'package:flutter/material.dart';
import 'package:nourex/core/utils/app_constants.dart';

class GradientInSpecificProductWidget extends StatelessWidget {
  const GradientInSpecificProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppConstants.borderRadius),
            topRight: Radius.circular(AppConstants.borderRadius),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withAlpha((0.16 * 255).toInt()),
              Colors.black.withAlpha((0.0 * 255).toInt()),
            ],
            stops: [0.0, 1.0],
          ),
        ),
      ),
    );
  }
}

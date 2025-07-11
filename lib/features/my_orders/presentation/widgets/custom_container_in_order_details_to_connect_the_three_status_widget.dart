import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContainerInOrderDetailsToConnectTheThreeStatusWidget
    extends StatelessWidget {
  const CustomContainerInOrderDetailsToConnectTheThreeStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svgs/progress_bar_icon.svg',
      fit: BoxFit.scaleDown,
    );
  }
}
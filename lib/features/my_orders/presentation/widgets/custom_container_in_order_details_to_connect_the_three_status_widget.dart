import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContainerInOrderDetailsToConnectTheThreeStatusWidget
    extends StatelessWidget {
  final Color? color;

  const CustomContainerInOrderDetailsToConnectTheThreeStatusWidget(
      {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svgs/progress_bar_icon.svg',
      fit: BoxFit.scaleDown,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            ),
    );
  }
}

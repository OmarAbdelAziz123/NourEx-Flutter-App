import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/button/custom_button_widget.dart';

class CustomBottomNavBarHaveButtonsWidget extends StatelessWidget {
  const CustomBottomNavBarHaveButtonsWidget({
    super.key,
    this.haveText,
    this.widgetUpOfButton,
    required this.buttonTitle, required this.onPressed,
  });

  final bool? haveText;
  final String buttonTitle;
  final VoidCallback onPressed;
  final Widget? widgetUpOfButton;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          haveText == true ? widgetUpOfButton! : SizedBox.shrink(),
          18.verticalSpace,
          CustomButtonWidget(
            text: buttonTitle,
            color: AppColors.primaryColor700,
            textColor: AppColors.neutralColor100,
            borderRadius: AppConstants.borderRadius,
            onPressed: onPressed,
          ),
          18.verticalSpace,
        ],
      ),
    );
  }
}

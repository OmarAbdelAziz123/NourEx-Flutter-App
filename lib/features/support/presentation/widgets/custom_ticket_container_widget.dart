import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/features/profile/presentation/widgets/custom_arrow_in_containers_widget.dart';
import 'package:nourex/features/support/data/models/solved_orders_data_model.dart';

class CustomTicketContainerWidget extends StatelessWidget {
  const CustomTicketContainerWidget({
    super.key, required this.solvedOrdersDataModel,
  });

  final SolvedOrdersDataModel solvedOrdersDataModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 18.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.w,
          color: AppColors.primaryColor700,
        ),
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius + 4.r,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: 4.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'trackingNumber'.tr(),
                style: Styles.highlightSemiBold,
              ),
              Text(
                solvedOrdersDataModel.orderNumber,
                style: Styles.captionRegular.copyWith(
                    color: AppColors.neutralColor600
                ),
              ),
            ],
          ),

          CustomArrowInContainersWidget(
            iconColor: AppColors.primaryColor700,
          ),
        ],
      ),
    );
  }
}

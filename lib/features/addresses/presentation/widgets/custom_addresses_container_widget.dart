import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/text/custom_text_rich_widget.dart';
import 'package:nourex/features/addresses/data/models/addresses_data_model.dart';
import 'package:nourex/features/my_orders/data/models/order_data_model.dart';
import 'package:nourex/features/profile/presentation/widgets/custom_arrow_in_containers_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomAddressesContainerWidget extends StatelessWidget {
  const CustomAddressesContainerWidget({
    super.key,
    required this.onPressedDelete,
    required this.addressesDataModel,
  });

  final AddressModel addressesDataModel;
  final VoidCallback onPressedDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 18.w),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: AppColors.primaryColor700),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius + 4.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: 4.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                addressesDataModel.name ?? 'No Name',
                style: Styles.highlightSemiBold.copyWith(),
              ),
              Text(
                '${addressesDataModel.city} - ${addressesDataModel.zone} - ${addressesDataModel.street}',
                style: Styles.captionRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
            ],
          ),

          Row(
            spacing: 4.w,
            children: [
              IconButton(
                onPressed: onPressedDelete,
                icon: Icon(Icons.delete_outline, color: AppColors.redColor100),
              ),
              CustomArrowInContainersWidget(
                iconColor: AppColors.primaryColor700,
              ),
              4.horizontalSpace,
            ],
          ),
        ],
      ),
    );
  }
}


class CustomAddressesContainerSkeletonizerWidget extends StatelessWidget {
  const CustomAddressesContainerSkeletonizerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        margin: EdgeInsets.symmetric(horizontal: 18.w),
        decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: AppColors.neutralColor300),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius + 4.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 4.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No Name',
                  style: Styles.highlightSemiBold.copyWith(),
                ),
                Text(
                  'No City - No Zone - No Street',
                  style: Styles.captionRegular.copyWith(
                    color: AppColors.neutralColor600,
                  ),
                ),
              ],
            ),

            Row(
              spacing: 4.w,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete_outline, color: AppColors.redColor100),
                ),
                CustomArrowInContainersWidget(
                  iconColor: AppColors.primaryColor700,
                ),
                4.horizontalSpace,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

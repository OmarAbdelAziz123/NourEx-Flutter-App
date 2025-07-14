import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/text/custom_text_rich_widget.dart';
import 'package:nourex/features/addresses/data/models/addresses_data_model.dart';
import 'package:nourex/features/my_orders/data/models/order_data_model.dart';
import 'package:nourex/features/profile/presentation/widgets/custom_arrow_in_containers_widget.dart';

class CustomAddressesContainerWidget extends StatelessWidget {
  const CustomAddressesContainerWidget({
    super.key, required this.addressesDataModel,
  });

  final AddressesDataModel addressesDataModel;

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
                addressesDataModel.addressesName,
                style: Styles.highlightSemiBold.copyWith(
                )
              ),
              Text(
                addressesDataModel.addressesData.join('- '),
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

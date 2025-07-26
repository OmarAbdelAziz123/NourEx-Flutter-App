import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/helper_functions/validation.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/addresses/business_logic/addresses_cubit.dart';

class AddNewAddressFormWidget extends StatelessWidget {
  const AddNewAddressFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressesCubit, AddressesState>(
      builder: (context, state) {
        final cubit = context.read<AddressesCubit>();

        return Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              18.verticalSpace,

              Text('fullNameRequired'.tr(), style: Styles.highlightEmphasis),
              8.verticalSpace,

              /// Full Name Field
              CustomTextFormFieldWidget(
                controller: cubit.fullNameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: 'enterFullName'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                validator: (value) => AppValidator.validateUsername(value!),
              ),
              16.verticalSpace,

              Text('phoneNumberRequired'.tr(), style: Styles.highlightEmphasis),
              8.verticalSpace,

              /// Phone Field
              CustomTextFormFieldWidget(
                controller: cubit.phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                hintText: 'enterPhoneNumber'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                validator:
                    (value) => AppValidator.validateEgyptPhoneNumber(value!),
              ),
              16.verticalSpace,

              Text('cityRequired'.tr(), style: Styles.highlightEmphasis),
              8.verticalSpace,

              /// City Field
              CustomTextFormFieldWidget(
                controller: cubit.cityController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: 'enterCity'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                validator: (value) => AppValidator.validateUsername(value!),
              ),
              16.verticalSpace,

              Text('zoneRequired'.tr(), style: Styles.highlightEmphasis),
              8.verticalSpace,

              /// Zone Field
              CustomTextFormFieldWidget(
                controller: cubit.zoneController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: 'enterZone'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                validator: (value) => AppValidator.validateUsername(value!),
              ),
              16.verticalSpace,

              Text('streetRequired'.tr(), style: Styles.highlightEmphasis),
              8.verticalSpace,

              /// Street Field
              CustomTextFormFieldWidget(
                controller: cubit.streetController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: 'enterStreet'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                validator: (value) => AppValidator.validateUsername(value!),
              ),
              32.verticalSpace,

              /// Is Main Address Section with Enhanced UX
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.neutralColor100, // Light background
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius,
                  ),
                  border: Border.all(
                    color:
                        cubit.isMain
                            ? AppColors.primaryColor700
                            : AppColors.neutralColor300,
                    width: 1.w,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Main checkbox row
                    InkWell(
                      onTap: () {
                        cubit.toggleIsMain();
                      },
                      child: Row(
                        spacing: 8.w,
                        children: [
                          Transform.scale(
                            scale: 1.2,
                            child: Checkbox(
                              value: cubit.isMain,
                              onChanged: (value) {
                                cubit.toggleIsMain();
                              },
                              activeColor: AppColors.primaryColor700,
                              checkColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.borderRadius - 4.w,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              spacing: 4.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'isMainAddress'.tr(),
                                  style: Styles.highlightEmphasis.copyWith(
                                    color:
                                        cubit.isMain
                                            ? AppColors.primaryColor700
                                            : AppColors.neutralColor800,
                                  ),
                                ),
                                Text(
                                  'mainAddressDescription'.tr(),
                                  style: Styles.contentRegular.copyWith(
                                    color: AppColors.neutralColor600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Optional: Show additional info when selected
                    if (cubit.isMain) ...[
                      12.verticalSpace,
                      Container(
                        padding: EdgeInsets.all(12.sp),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor700.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppConstants.borderRadius - 2.w),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'mainAddressNote'.tr(),
                                style: Styles.contentRegular.copyWith(
                                  color: AppColors.primaryColor700,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              16.verticalSpace,

              Text('notes'.tr(), style: Styles.highlightEmphasis),
              8.verticalSpace,

              CustomTextFormFieldWidget(
                borderRadius: AppConstants.borderRadius,
                borderWidth: 1.w,
                maxLines: 5,
                controller: TextEditingController(),
                backgroundColor: Colors.transparent,
                hintText: 'enterNotes'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

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
import 'package:nourex/features/addresses/data/models/addresses_data_model.dart';

class AddressDetailsFormWidget extends StatefulWidget {
  const AddressDetailsFormWidget({super.key, required this.addressModel});

  final AddressModel addressModel;

  @override
  State<AddressDetailsFormWidget> createState() => _AddressDetailsFormWidgetState();
}

class _AddressDetailsFormWidgetState extends State<AddressDetailsFormWidget> {
  @override
  void initState() {
    final cubit = context.read<AddressesCubit>();
    cubit.isMain = widget.addressModel?.type == 'Main';
    super.initState();
  }

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
                hintText: widget.addressModel.name ?? 'enterFullName'.tr(),
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
                hintText: '+${widget.addressModel.phoneNo}' ?? 'enterPhoneNumber'.tr(),
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
                hintText: widget.addressModel.city ?? 'enterCity'.tr(),
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
                hintText: widget.addressModel.zone ?? 'enterZone'.tr(),
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
                hintText: widget.addressModel.street ?? 'enterStreet'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                validator: (value) => AppValidator.validateUsername(value!),
              ),
              32.verticalSpace,

              /// Is Main Address Section with Enhanced UX
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 12.h),
              //   decoration: BoxDecoration(
              //     color: AppColors.neutralColor100, // Light background
              //     borderRadius: BorderRadius.circular(
              //       AppConstants.borderRadius,
              //     ),
              //     border: Border.all(
              //       color:
              //           addressModel.type == 'Main'
              //               ? AppColors.primaryColor700
              //               : AppColors.neutralColor300,
              //       width: 1.w,
              //     ),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       /// Main checkbox row
              //       InkWell(
              //         onTap: () {
              //           cubit.toggleIsMain(
              //             addressModel.type == 'Main' ? true : false,
              //           );
              //         },
              //         child: Row(
              //           spacing: 8.w,
              //           children: [
              //             Transform.scale(
              //               scale: 1.2,
              //               child: Checkbox(
              //                 value: cubit.isMain,
              //                 // value: addressModel.type == 'Main' ? true : false,
              //                 onChanged: (value) {
              //                   cubit.toggleIsMain();
              //                   // cubit.toggleIsMain(value ?? false);
              //                 },
              //                 activeColor:
              //                     addressModel.type == 'Main'
              //                         ? AppColors.primaryColor700
              //                         : AppColors.neutralColor100,
              //                 checkColor: Colors.white,
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(
              //                     AppConstants.borderRadius - 4.w,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Expanded(
              //               child: Column(
              //                 spacing: 4.h,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     'isMainAddress'.tr(),
              //                     style: Styles.highlightEmphasis.copyWith(
              //                       color:
              //                           addressModel.type == 'Main'
              //                               ? AppColors.primaryColor700
              //                               : AppColors.neutralColor800,
              //                     ),
              //                   ),
              //                   Text(
              //                     'mainAddressDescription'.tr(),
              //                     style: Styles.contentRegular.copyWith(
              //                       color: AppColors.neutralColor600,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //
              //       /// Optional: Show additional info when selected
              //       if (addressModel.type == 'Main') ...[
              //         12.verticalSpace,
              //         Container(
              //           padding: EdgeInsets.all(12.sp),
              //           decoration: BoxDecoration(
              //             color: AppColors.primaryColor700.withOpacity(0.1),
              //             borderRadius: BorderRadius.circular(
              //               AppConstants.borderRadius - 2.w,
              //             ),
              //           ),
              //           child: Row(
              //             children: [
              //               Expanded(
              //                 child: Text(
              //                   'mainAddressNote'.tr(),
              //                   style: Styles.contentRegular.copyWith(
              //                     color: AppColors.primaryColor700,
              //                     fontSize: 12.sp,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ],
              //   ),
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.neutralColor100,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  border: Border.all(
                    color: cubit.isMain ? AppColors.primaryColor700 : AppColors.neutralColor300,
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
                              activeColor: cubit.isMain
                                  ? AppColors.primaryColor700
                                  : AppColors.neutralColor100,
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
                                    color: cubit.isMain
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

                    /// Optional: Show note if selected as main
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
                controller: cubit.notesController,
                backgroundColor: Colors.transparent,
                hintText: widget.addressModel.notes ?? 'enterNotes'.tr(),
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

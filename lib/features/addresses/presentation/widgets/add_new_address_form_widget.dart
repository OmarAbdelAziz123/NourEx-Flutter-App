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

              Text(
                'الإسم بالكامل*',
                style: Styles.highlightEmphasis,
              ),
              8.verticalSpace,

              /// Full Name Field
              CustomTextFormFieldWidget(
                controller: cubit.fullNameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: 'قم بإدخال الإسم بالكامل هنا',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                validator: (value) => AppValidator.validateUsername(value!),
              ),
              16.verticalSpace,

              Text(
                'رقم الجوال*',
                style: Styles.highlightEmphasis,
              ),
              8.verticalSpace,

              /// Phone Field
              CustomTextFormFieldWidget(
                controller: cubit.phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                hintText: 'قم بإدخال رقم الجوال هنا',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                validator: (value) => AppValidator.validateEgyptPhoneNumber(value!),
              ),
              16.verticalSpace,

              Text(
                'البلد*',
                style: Styles.highlightEmphasis,
              ),
              8.verticalSpace,

              /// Country Field
              CustomTextFormFieldWidget(
                controller: cubit.countryController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: 'قم بإدخال إسم البلد هنا',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                validator: (value) => AppValidator.validateUsername(value!),
              ),
              16.verticalSpace,

              Text(
                'المدينة*',
                style: Styles.highlightEmphasis,
              ),
              8.verticalSpace,

              /// City Field
              CustomTextFormFieldWidget(
                controller: cubit.cityController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: 'قم بإدخال إسم المدينة هنا',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                validator: (value) => AppValidator.validateUsername(value!),
              ),
              16.verticalSpace,

              Text(
                'الشارع*',
                style: Styles.highlightEmphasis,
              ),
              8.verticalSpace,

              /// Street Field
              CustomTextFormFieldWidget(
                controller: cubit.streetController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: 'قم بإدخالإسم الشارع هنا',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                validator: (value) => AppValidator.validateUsername(value!),
              ),
              16.verticalSpace,

              Row(
                spacing: 16.w,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'رقم الشقة',
                          style: Styles.highlightEmphasis,
                        ),
                        8.verticalSpace,
                        CustomTextFormFieldWidget(
                          controller: cubit.apartmentController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          hintText: 'قم بإدخال رقم الشقة',
                          hintStyle: Styles.contentRegular.copyWith(
                            color: AppColors.neutralColor600,
                          ),
                          validator: (value) => AppValidator.validateUsername(value!),
                        ),
                        16.verticalSpace,
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'رقم المبنى',
                          style: Styles.highlightEmphasis,
                        ),
                        8.verticalSpace,
                        CustomTextFormFieldWidget(
                          controller: cubit.buildingNumberController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          hintText: 'قم بإدخال رقم المبني',
                          hintStyle: Styles.contentRegular.copyWith(
                            color: AppColors.neutralColor600,
                          ),
                          validator: (value) => AppValidator.validateUsername(value!),
                        ),
                        16.verticalSpace,
                      ],
                    ),
                  ),
                ],
              ),
              16.verticalSpace,

              Text(
                'ملاحضات',
                style: Styles.highlightEmphasis,
              ),
              8.verticalSpace,

              CustomTextFormFieldWidget(
                borderRadius: AppConstants.borderRadius,
                borderWidth: 1.w,
                maxLines: 5,
                controller: TextEditingController(),
                backgroundColor: Colors.transparent,
                hintText: 'قم بإدخال الملاحضات الخاصة بك هنا',
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/button/custom_button_widget.dart';
import 'package:nourex/core/widgets/container/custom_rating_filter_item_widget.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/search/business_logic/search_cubit.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchCubit = BlocProvider.of<SearchCubit>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'تصفية',
          isSubScreen: true,
          haveOnlyNotification: true,
          onTapBack: () {
            context.pop();
          },
          onTapSearch: () {},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Price Range Filter From
              Text(
                'السعر من',
                style: Styles.contentEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
              ),
              8.verticalSpace,
              CustomTextFormFieldWidget(
                controller: searchCubit.priceRangeFromController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textStyle: Styles.contentEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
                backgroundColor: Colors.transparent,
                cursorColor: AppColors.primaryColor700,
                hintText: 'قم بإدخال السعر من هنا',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
              18.verticalSpace,

              /// Price Range Filter To
              Text(
                'السعر إلى',
                style: Styles.contentEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
              ),
              8.verticalSpace,
              CustomTextFormFieldWidget(
                controller: searchCubit.priceRangeToController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                backgroundColor: Colors.transparent,
                textStyle: Styles.contentEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
                cursorColor: AppColors.primaryColor700,
                hintText: 'قم بإدخال السعر إلى هنا',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
              18.verticalSpace,

              /// Review Filter
              Text(
                'التقيمات',
                style: Styles.contentEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
              ),
              8.verticalSpace,
              BlocBuilder<SearchCubit, SearchState>(
                buildWhen: (previous, current) => current is ToggleSelectedRating,
                builder: (context, state) {
                  final selected = context.read<SearchCubit>().selectedRating;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: List.generate(5, (index) {
                      final rating = index + 1;

                      return CustomRatingFilterItem(
                        rating: rating,
                        selectedRating: selected,
                        onTap: () => context.read<SearchCubit>().toggleRating(rating),
                        selectedColor: AppColors.primaryColor700,
                        unselectedColor: Colors.white,
                        selectedTextStyle: Styles.contentEmphasis.copyWith(color: Colors.white),
                        unselectedTextStyle: Styles.contentEmphasis.copyWith(color: AppColors.primaryColor700),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 18.w,
          right: 18.w,
          bottom: 28.h,
          top: 18.h,
        ),
        // padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 52.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: AppColors.neutralColor100,
              width: 1.w,
            ),
          ),
        ),
        child: Row(
          spacing: 16.w,
          children: [
            Expanded(
              child: CustomButtonWidget(
                text: 'تصفية',
                color: AppColors.primaryColor700,
                onPressed: () {
                  print('Filter');
                  print(context.read<SearchCubit>().priceRangeFromController.text);
                  print(context.read<SearchCubit>().priceRangeToController.text);
                  print(context.read<SearchCubit>().selectedRating);
                },
              ),
            ),
            Expanded(
              child: CustomButtonWidget(
                text: 'إلغاء',
                textColor: AppColors.primaryColor700,
                borderSide: BorderSide(
                  color: AppColors.primaryColor700,
                  width: 1.w,
                ),
                borderRadius: AppConstants.borderRadius - 2.w,
                color: Colors.white,
                onPressed: () {
                  context.pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

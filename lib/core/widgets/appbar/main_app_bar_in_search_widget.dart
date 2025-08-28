import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/search/business_logic/search_cubit.dart';

class MainAppBarInSearchWidget extends StatelessWidget {
  const MainAppBarInSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();
        final searchController = cubit.searchController;

        return Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor700,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 74.h,
            leadingWidth: 0,
            leading: SizedBox.shrink(),
            title: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(right: context.locale.languageCode == 'en' ? 0 : 18.w),
                  child: InkWell(
                    onTap: () {
                      context.pop();
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Transform.rotate(
                      angle: context.locale.languageCode == 'en' ? 3.14159 : 0.0,
                      child: SvgPicture.asset(
                        'assets/svgs/back_button_icon.svg',
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.scaleDown,
                      ),
                    )
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: CustomTextFormFieldWidget(
                      backgroundColor: Colors.transparent,
                      textColor: AppColors.neutralColor100,
                      controller: searchController,
                      hintText: 'search'.tr(),
                      showCursor: true,
                      cursorColor: AppColors.neutralColor100,
                      hintStyle: Styles.contentEmphasis.copyWith(
                        color: AppColors.neutralColor100,
                      ),
                      onChanged: (value) {
                        cubit.onChangeSearchText(
                          value,
                        );
                        if (value != null && value.isNotEmpty) {
                          cubit.getInitialProductsBySearch();
                        }
                      },
                      borderRadius: AppConstants.borderRadius + 4.r,
                      suffixIcon: InkWell(
                        highlightColor: Colors.transparent,
                        onTap: () {
                          context
                              .pushNamed(Routes.filterScreen,
                                  arguments: cubit.searchController.text)
                              .then((value) {
                            cubit.getInitialProductsBySearch(
                              maxRate: cubit.selectedRating.toDouble(),
                              search: cubit.searchController.text,
                            );
                          });
                        },
                        child: SvgPicture.asset(
                          'assets/svgs/filter_icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      prefixIcon: SvgPicture.asset(
                        'assets/svgs/search_icon2.svg',
                        fit: BoxFit.scaleDown,
                      ),
                      borderColor: AppColors.neutralColor100,
                    ),
                  ),
                ),

                /// Clear Button
                if (searchController.text.isNotEmpty)
                  SizedBox(
                    height: 50.h,
                    width: 50.w,
                    child: Center(
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        onTap: () {
                          context.read<SearchCubit>().onChangeSearchText(
                                '',
                              );
                        },
                        child: SvgPicture.asset(
                          'assets/svgs/close_container_icon.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            centerTitle: true,
          ),
        );
      },
    );
  }
}

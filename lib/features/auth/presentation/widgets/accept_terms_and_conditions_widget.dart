import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/text/custom_text_rich_widget.dart';
import 'package:nourex/features/auth/business_logic/auth_cubit.dart';

class AcceptTermsAndConditionsWidget extends StatelessWidget {
  const AcceptTermsAndConditionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) => current is UserToggleCheckIconState,
      builder: (context, state) {
        return GestureDetector(
          onTap: () => context.read<AuthCubit>().userToggleCheckIcon(),
          child: Row(
            spacing: 8.w,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: 24.h,
                width: 24.h,
                padding: EdgeInsets.all(0.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius - 4.r,
                  ),
                  border: Border.all(
                    width: 1.w,
                    color:
                        context.read<AuthCubit>().showCheckIcon
                            ? AppColors.neutralColor100
                            : AppColors.neutralColor600,
                  ),
                  color:
                      context.read<AuthCubit>().showCheckIcon
                          ? AppColors.primaryColor700
                          : Colors.transparent,
                ),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: context.read<AuthCubit>().showCheckIcon ? 1.0 : 0.0,
                  child: Center(
                    child: Icon(
                      Icons.check,
                      size: 18.sp,
                      color: AppColors.neutralColor100,
                    ),
                  ),
                ),
              ),
              CustomRichText(
                text1: 'accept'.tr(),
                text2: 'privacyPolicy'.tr(),
                text3: 'and'.tr(),
                text4: 'termsOfService'.tr(),
                textStyle1: Styles.captionRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                textStyle2: Styles.captionRegular.copyWith(
                  color: AppColors.secondaryColor500,
                ),
                textStyle3: Styles.captionRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                textStyle4: Styles.captionRegular.copyWith(
                  color: AppColors.secondaryColor500,
                ),
                textAlign: TextAlign.start,
                textOverflow: TextOverflow.clip,
              ),
            ],
          ),
        );
      },
    );
  }
}

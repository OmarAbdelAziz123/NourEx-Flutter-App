import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/button/custom_button_widget.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/wallet/business_logic/wallet_cubit.dart';

class ConvertPointsToBalanceScreen extends StatefulWidget {
  const ConvertPointsToBalanceScreen({super.key});

  @override
  State<ConvertPointsToBalanceScreen> createState() => _ConvertPointsToBalanceScreenState();
}

class _ConvertPointsToBalanceScreenState extends State<ConvertPointsToBalanceScreen> {
  late WalletCubit cubit;

  bool showPreviewButton = false;

  @override
  void initState() {
    cubit = context.read<WalletCubit>();
    cubit.numberOfPointsController.addListener(() {
      final hasInput = cubit.numberOfPointsController.text.trim().isNotEmpty;
      if (mounted) {
        setState(() {
          showPreviewButton = hasInput;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    cubit.numberOfPointsController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'convertPoints'.tr(),
          isSubScreen: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          final cubit = context.read<WalletCubit>();

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
            child: Column(
              spacing: 8.h,
              children: [
                Row(
                  spacing: 8.w,
                  children: [
                    Expanded(
                      child: Text(
                        'points'.tr(),
                        style: Styles.highlightEmphasis,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.transparent,
                      size: 20.sp,
                    ),
                    Expanded(
                      child: Text(
                        'balance'.tr(),
                        style: Styles.highlightEmphasis,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 8.w,
                  children: [
                    Expanded(
                      child: CustomTextFormFieldWidget(
                        controller: cubit.numberOfPointsController,
                        hintText: 'points2'.tr(),
                        hintStyle: Styles.captionRegular.copyWith(
                          color: AppColors.neutralColor600,
                        ),
                        borderRadius: AppConstants.borderRadius - 2.r,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.neutralColor1000,
                      size: 20.sp,
                    ),
                    Expanded(
                      child: CustomTextFormFieldWidget(
                        readOnly: true,
                        controller: cubit.redeemedAmountController,
                        hintText: '00',
                        hintStyle: Styles.captionRegular.copyWith(
                          color: AppColors.neutralColor600,
                        ),
                        borderRadius: AppConstants.borderRadius - 2.r,
                      ),
                    ),
                  ],
                ),
                if (showPreviewButton) // 👈 Conditionally rendered
                  Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: CustomButtonWidget(
                      text: 'preview'.tr(), // or 'معاينة'
                      color: AppColors.primaryColor700,
                      onPressed: () {
                        cubit.makePreviewRedeemPoints();
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocConsumer<WalletCubit, WalletState>(
  listener: (context, state) {
    // TODO: implement listener
    if(state is RedeemPointsSuccessState) {
      context.pushNamedAndRemoveUntil(Routes.mainLayoutScreen, arguments: 3);
    }
  },
  builder: (context, state) {
    return Container(
        padding: EdgeInsets.only(
          left: 18.w,
          right: 18.w,
          bottom: 28.h,
          top: 18.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.neutralColor100,
          border: Border(
            top: BorderSide(
              color: AppColors.neutralColor100,
              width: 1.w,
            ),
          ),
        ),
        child: CustomButtonWidget(
          text: 'convert'.tr(),
          color: AppColors.primaryColor700,
          onPressed: () {
            print('click');
            print(cubit.numberOfPointsController.text);
            print(cubit.redeemedAmountController.text);
            cubit.redeemPoints();
          },
        ),
      );
  },
),
    );
  }
}

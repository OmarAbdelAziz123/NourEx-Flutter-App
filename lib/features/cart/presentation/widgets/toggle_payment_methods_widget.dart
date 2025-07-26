import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/features/cart/business_logic/cart_cubit.dart';

class TogglePaymentMethodsWidget extends StatelessWidget {
  const TogglePaymentMethodsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('paymentMethod'.tr(), style: Styles.featureBold),
        8.verticalSpace,

        BlocBuilder<CartCubit, CartState>(
          buildWhen: (previous, current) => current is ChangePaymentMethodState,
          builder: (context, state) {
            final cartCubit = context.read<CartCubit>();
            final selected = cartCubit.selectedMethod;

            return Row(
              spacing: 12.w,
              children: [
                GestureDetector(
                  onTap: () {
                    cartCubit.togglePaymentMethod(PaymentMethod.wallet);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadius + 2.r,
                      ),
                      border: Border.all(
                        width: 1.w,
                        color: selected == PaymentMethod.wallet
                            ? AppColors.primaryColor700
                            : AppColors.neutralColor200,
                      ),
                    ),
                    child: Row(
                      spacing: 10.w,
                      children: [
                        SvgPicture.asset(
                          selected == PaymentMethod.wallet
                              ? 'assets/svgs/enable_checkbox.svg'
                              : 'assets/svgs/disable_checkbox.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        Text('wallet'.tr(), style: Styles.contentEmphasis),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cartCubit.togglePaymentMethod(
                      PaymentMethod.cashOnDelivery,
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadius + 2.r,
                      ),
                      border: Border.all(
                        width: 1.w,
                        color:
                        selected == PaymentMethod.cashOnDelivery
                            ? AppColors.primaryColor700
                            : AppColors.neutralColor200,
                      ),
                    ),
                    child: Row(
                      spacing: 10.w,
                      children: [
                        SvgPicture.asset(
                          selected == PaymentMethod.cashOnDelivery
                              ? 'assets/svgs/enable_checkbox.svg'
                              : 'assets/svgs/disable_checkbox.svg',
                          fit: BoxFit.scaleDown,
                        ),

                        Text(
                          'received'.tr(),
                          style: Styles.contentEmphasis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
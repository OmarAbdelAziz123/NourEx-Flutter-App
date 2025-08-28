import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_shared_show_bottom_sheet.dart';
import 'package:nourex/core/widgets/button/custom_button_widget.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/addresses/presentation/widgets/custom_addresses_container_skeletonizer_widget.dart';
import 'package:nourex/features/addresses/presentation/widgets/custom_addresses_container_widget.dart';
import 'package:nourex/features/cart/business_logic/cart_cubit.dart';
import 'package:nourex/features/cart/presentation/widgets/toggle_payment_methods_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CompletePayScreen extends StatelessWidget {
  const CompletePayScreen({super.key, required this.totalPrice});

  final int? totalPrice;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(74.h),
            child: MainAppBar2Widget(
              title: 'cart'.tr(),
              isSubScreen: true,
              onTapBack: () {
                context.pop();
              },
              onTapNotification: () {},
            ),
          ),
          body:
          state is GetMainAddressLoadingState || cartCubit.mainAddressDataModel == null   ?
            Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor700,
              ),
            )
          : cartCubit.mainAddressDataModel!.result == null
              ? Center(
            child: CustomButtonWidget(
              onPressed: () {
                context.pushNamed(Routes.addNewAddressScreen);
              },
              text: 'addAddress'.tr(),
              color: AppColors.primaryColor700,
            ),
          ) : BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is ApplyCouponSuccessState) {}
            },
            builder: (context, state) {
              final cartCubit = context.read<CartCubit>();

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 18.w, right: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      18.verticalSpace,

                      /// Total Price
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 16.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppConstants.borderRadius,
                          ),
                          border: Border.all(
                            width: 1.w,
                            color: AppColors.neutralColor300,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'totalPrice2'.tr(),
                              style: Styles.highlightEmphasis.copyWith(
                                color: AppColors.neutralColor600,
                              ),
                            ),
                            Text('${totalPrice ?? '0'} ${'currency'.tr()}',
                                style: Styles.heading4),
                          ],
                        ),
                      ),
                      18.verticalSpace,

                      /// Discount
                      if (state is ApplyCouponSuccessState)
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 16.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.borderRadius,
                                ),
                                border: Border.all(
                                  width: 1.w,
                                  color: AppColors.neutralColor300,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "discount".tr(),
                                    style: Styles.highlightEmphasis.copyWith(
                                      color: AppColors.redColor100,
                                    ),
                                  ),
                                  Text(
                                    '${state.discountAmount} ${'currency'.tr()} (-${state.discountName} ${'currency'.tr()})',
                                    style: Styles.highlightEmphasis.copyWith(
                                      color: AppColors.redColor100,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            18.verticalSpace,
                          ],
                        ),

                      /// Price After Discount
                      /// Not Exist
                      if (state is ApplyCouponSuccessState)
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 16.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.borderRadius,
                                ),
                                border: Border.all(
                                  width: 1.w,
                                  color: AppColors.neutralColor300,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'priceAfterDiscount'.tr(),
                                    style: Styles.highlightEmphasis.copyWith(
                                      color: AppColors.neutralColor600,
                                    ),
                                  ),
                                  Text('${state.newTotal} ${'currency'.tr()}',
                                      style: Styles.highlightEmphasis),
                                ],
                              ),
                            ),
                            18.verticalSpace,
                          ],
                        ),

                      /// Activate Coupon
                      Row(
                        spacing: 12.w,
                        children: [
                          Expanded(
                            flex: 5,
                            child: CustomTextFormFieldWidget(
                              controller: cartCubit.couponController,
                              backgroundColor: AppColors.neutralColor100,
                              textInputAction: TextInputAction.done,
                              hintText: 'discountCode'.tr(),
                              hintStyle: Styles.captionRegular.copyWith(
                                color: AppColors.neutralColor600,
                              ),
                              prefixIcon: SvgPicture.asset(
                                'assets/svgs/discount.svg',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: CustomButtonWidget(
                              text: 'activate'.tr(),
                              color: AppColors.primaryColor700,
                              onPressed: () {
                                cartCubit.applyCoupon(
                                    cartTotal: totalPrice.toString());
                              },
                            ),
                          ),
                        ],
                      ),
                      18.verticalSpace,

                      /// Main Address
                      cartCubit.mainAddressDataModel == null ||
                              cartCubit.mainAddressDataModel!.result == null
                          ? CustomAddressesContainerSkeletonizerWidget()
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.borderRadius + 4.r,
                                ),
                                border: Border.all(
                                  width: 1.w,
                                  color: AppColors.primaryColor700,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      spacing: 4.h,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartCubit.mainAddressDataModel?.result
                                                  ?.name ??
                                              'No Name',
                                          style: Styles.highlightSemiBold
                                              .copyWith(),
                                        ),
                                        Text(
                                          '${cartCubit.mainAddressDataModel?.result?.city} - ${cartCubit.mainAddressDataModel?.result?.zone} - ${cartCubit.mainAddressDataModel?.result?.street}',
                                          style: Styles.captionRegular.copyWith(
                                            color: AppColors.neutralColor600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      12.verticalSpace,

                      Text('notesInOrder'.tr(),
                          style: Styles.highlightEmphasis),
                      8.verticalSpace,

                      CustomTextFormFieldWidget(
                        controller: cartCubit.notesController,
                        borderRadius: AppConstants.borderRadius,
                        borderWidth: 1.w,
                        maxLines: 5,
                        backgroundColor: Colors.transparent,
                        hintText: 'notesInOrderDescription'.tr(),
                        hintStyle: Styles.contentRegular.copyWith(
                          color: AppColors.neutralColor600,
                        ),
                      ),
                      18.verticalSpace,

                      TogglePaymentMethodsWidget(),
                    ],
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {
              if (state is MakeOrderSuccessState) {
                final cartCubit = context.read<CartCubit>();

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: false,
                  enableDrag: false,
                  builder: (context) {
                    return CustomSharedShowBottomSheet(
                        headingName:
                            '${'orderNumber'.tr()} ${cartCubit.orderSeq}',
                        imagePath:
                            'assets/svgs/green_icon_in_bottom_sheet_icon.svg',
                        text1: 'orderNumberDescription'.tr(),
                        text2: 'accountCreatedSuccess'.tr(),
                        description: 'orderNumberDescription2'.tr(),
                        haveOneButton: false,
                        haveTextSpan: true,
                        buttonText1: 'next'.tr(),
                        buttonText2: 'myOrders'.tr(),
                        onTap1: () {
                          context.pushNamedAndRemoveUntil(
                            Routes.mainLayoutScreen,
                            arguments: 1,
                          );
                        },
                        onTap2: () {
                          context.pushNamedAndRemoveUntil(
                            Routes.mainLayoutScreen,
                            arguments: 2,
                          );
                        });
                  },
                );
              }
            },
            builder: (context, state) {
              final cartCubit = context.read<CartCubit>();

              return CustomBottomNavBarMakeButtonOnly(
                buttonTitle: 'buyNow'.tr(),
                onPressed: () {
                  cartCubit.makeOrder(
                    paymentMethod: cartCubit.selectedMethod.toString() ==
                            'PaymentMethod.cod'
                        ? 'cod'
                        : 'wallet',
                    address: cartCubit.mainAddressDataModel!.result!.id ?? '',
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

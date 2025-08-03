import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/extensions/log_util.dart';
import 'package:nourex/features/cart/business_logic/cart_cubit.dart';
import 'package:nourex/features/cart/presentation/widgets/custom_product_card_item_in_cart.dart';
import 'package:nourex/features/products/data/models/product_data_model.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/button/custom_button_widget.dart';
import 'package:nourex/core/widgets/divider/custom_divider_in_bottom_sheet.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/cart/presentation/screens/complete_pay_screenn.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int totalPrice = 0;
    // final products = [
    //   ProductDataModel(
    //     productName: 'تيشرت بولو',
    //     productImage: 'assets/pngs/shirt.png',
    //     productRate: '3',
    //     countOfNumber: '200',
    //     productPriceBefore: '2000',
    //     productPriceAfter: '1500',
    //   ),
    //   ProductDataModel(
    //     productName: 'تيشرت بولو',
    //     productImage: 'assets/pngs/shirt.png',
    //     productRate: '5',
    //     countOfNumber: '200',
    //     productPriceBefore: '2000',
    //     productPriceAfter: '1500',
    //   ),
    //   ProductDataModel(
    //     productName: 'تيشرت بولو',
    //     productImage: 'assets/pngs/shirt.png',
    //     productRate: '3',
    //     countOfNumber: '200',
    //     productPriceBefore: '2000',
    //     productPriceAfter: '1500',
    //   ),
    //   ProductDataModel(
    //     productName: 'تيشرت بولو',
    //     productImage: 'assets/pngs/shirt.png',
    //     productRate: '5',
    //     countOfNumber: '200',
    //     productPriceBefore: '2000',
    //     productPriceAfter: '1500',
    //   ),
    // ];

    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is RemoveProductFromCartSuccessState) {
          context.read<CartCubit>().getCart();
        }
        if (state is UpdatePlusCartSuccessState) {
          context.read<CartCubit>().getCart();
        }
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
              onTapSearch: () {},
              onTapNotification: () {},
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 18.w, right: 18.w),
            child: cartCubit.cartDataModel == null ||
                cartCubit.cartDataModel!.result == null ||
                cartCubit.cartDataModel!.result!.products == []
                ? Center(
              child: CircularProgressIndicator(),
            )
                : cartCubit.cartDataModel!.result!.products!.isEmpty
                ? Center(
              child: Text(
                'no_products_in_cart'.tr(),
                style: TextStyle(
                  color: AppColors.primaryColor700,
                  fontSize: 16.sp,
                ),
              ),
            )
                : SingleChildScrollView(
              child: Column(
                children: [
                  18.verticalSpace,
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: cartCubit
                        .cartDataModel!.result!.products!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                    20.verticalSpace,
                    itemBuilder: (context, index) {
                      totalPrice = cartCubit.cartDataModel!.result!.totalPrice!;

                      return CustomProductCardItemInCartWidget(
                        cartProduct: cartCubit
                            .cartDataModel!.result!.products![index],
                        onTapRemoveItem: () {
                          cartCubit.removeProductFromCart(
                            productId: cartCubit.cartDataModel!.result!
                                .products![index].productId!,
                            variantSku: cartCubit.cartDataModel!.result!
                                .products![index].variantSku!,
                          );
                          logSuccess(cartCubit.cartDataModel!.result!
                              .products![index].productId!);
                          logSuccess(cartCubit.cartDataModel!.result!
                              .products![index].variantSku!);
                        },
                        onTapPlusItem: () {
                          final product = cartCubit
                              .cartDataModel!.result!.products![index];
                          final currentAmount = product.quantity ?? 1;

                          cartCubit.updatePlusCart(
                            productId: product.productId!,
                            variantSku: product.variantSku!,
                            amount: 1,
                          );
                        },
                        onTapMinusItem: () {
                          final product = cartCubit
                              .cartDataModel!.result!.products![index];
                          // prevent decrementing below 1
                          cartCubit.updatePlusCart(
                            productId: product.productId!,
                            variantSku: product.variantSku!,
                            amount: -1,
                          );
                        },
                      );
                    }),
                  18.verticalSpace,
                  Row(children: [
                    Text('details'.tr(), style: Styles.featureBold)
                  ]),
                  12.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'productValue'.tr(),
                        style: Styles.contentEmphasis.copyWith(
                          color: AppColors.neutralColor600,
                        ),
                      ),
                      Text(
                          '${cartCubit.cartDataModel?.result?.totalPrice ??
                              0} ${'currency'.tr()}',
                          style: Styles.contentEmphasis),
                    ],
                  ),
                  16.verticalSpace,
                ],
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavBarMakeButtonOnly(
            buttonTitle: 'complete'.tr(),

            onPressed: () {
              context.pushNamed(
                Routes.completePayScreen,
                arguments: totalPrice,
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final products = [
      ProductDataModel(
        productName: 'تيشرت بولو',
        productImage: 'assets/pngs/shirt.png',
        productRate: '3',
        countOfNumber: '200',
        productPriceBefore: '2000',
        productPriceAfter: '1500',
      ),
      ProductDataModel(
        productName: 'تيشرت بولو',
        productImage: 'assets/pngs/shirt.png',
        productRate: '5',
        countOfNumber: '200',
        productPriceBefore: '2000',
        productPriceAfter: '1500',
      ),
      ProductDataModel(
        productName: 'تيشرت بولو',
        productImage: 'assets/pngs/shirt.png',
        productRate: '3',
        countOfNumber: '200',
        productPriceBefore: '2000',
        productPriceAfter: '1500',
      ),
      ProductDataModel(
        productName: 'تيشرت بولو',
        productImage: 'assets/pngs/shirt.png',
        productRate: '5',
        countOfNumber: '200',
        productPriceBefore: '2000',
        productPriceAfter: '1500',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'السلة',
          onTapSearch: () {},
          onTapNotification: () {},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 18.w, right: 18.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              18.verticalSpace,
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: products.length,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => 20.verticalSpace,
                itemBuilder:
                    (context, index) => CustomProductCardItemInCartWidget(
                      product: products[index],
                    ),
              ),
              18.verticalSpace,
              Row(children: [Text('التفاصيل', style: Styles.featureBold)]),
              12.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'قيمة المنتجات',
                    style: Styles.contentEmphasis.copyWith(
                      color: AppColors.neutralColor600,
                    ),
                  ),
                  Text('565 ل.س', style: Styles.contentEmphasis),
                ],
              ),
              16.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'التخفيض',
                    style: Styles.contentEmphasis.copyWith(
                      color: AppColors.neutralColor600,
                    ),
                  ),
                  Text(
                    '-113 ل.س',
                    style: Styles.contentEmphasis.copyWith(
                      color: AppColors.redColor100,
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              CustomDividerInBottomSheet(),
              16.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'السعر الكلي',
                    style: Styles.highlightEmphasis.copyWith(
                      color: AppColors.neutralColor600,
                    ),
                  ),
                  Text('467 ل.س', style: Styles.heading4),
                ],
              ),
              18.verticalSpace,
              Row(
                spacing: 12.w,
                children: [
                  Expanded(
                    flex: 5,
                    child: CustomTextFormFieldWidget(
                      controller: TextEditingController(),
                      backgroundColor: AppColors.neutralColor100,
                      textInputAction: TextInputAction.done,
                      hintText: 'كود الخصم',
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
                      text: 'تفعيل',
                      color: AppColors.primaryColor700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarMakeButtonOnly(
        buttonTitle: 'استكمال الطلب',
        onPressed: () {
          context.pushNamedWithSwipe(
            Routes.completePayScreen,
          );
        },
      ),
    );
  }
}

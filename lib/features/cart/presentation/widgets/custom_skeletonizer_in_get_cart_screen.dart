import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/features/cart/data/models/cart_data_model.dart';
import 'package:nourex/features/cart/presentation/widgets/custom_product_card_item_in_cart.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomSkeletonizerInGetCartScreen extends StatelessWidget {
  const CustomSkeletonizerInGetCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            18.verticalSpace,
            ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => 20.verticalSpace,
                itemBuilder: (context, index) {
                  return CustomProductCardItemInCartWidget(
                    cartProduct: CartProduct(
                      id: 'eadqwfswsedf',
                      productId: 'eadqwfswsedf',
                      variantSku: 'eadqwfswsedf',
                      quantity: 1,
                      name: 'product'.tr(),
                      mainImageURL: 'https://via.placeholder.com/150',
                      finalPrice: 0,
                      itemTotal: 0,
                    ),
                    onTapRemoveItem: () {},
                    onTapPlusItem: () {},
                    onTapMinusItem: () {},
                    isLoaded: false,
                  );
                }),
            18.verticalSpace,
            Row(children: [Text('details'.tr(), style: Styles.featureBold)]),
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
                Text('${'currency'.tr()}', style: Styles.contentEmphasis),
              ],
            ),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}

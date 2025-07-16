import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/features/products/data/models/product_data_model.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/features/categories/business_logic/categories_cubit.dart';
import 'package:nourex/features/products/presentation/widgets/category_item_in_row_widget.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_widget.dart';

class BestSellerScreen extends StatelessWidget {
  const BestSellerScreen({super.key});

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
    final categories = [
      'ملابس رجالية',
      'إكسسوارات',
      'العطور',
      'حقائب',
      'منتجات العناية بالبشرة',
      'أحذية',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'الأكثر مبيعاً',
          isSubScreen: true,
          onTapBack: () {
            context.pop();
          },
          onTapSearch: () {},
        ),
      ),
      body: BlocProvider(
        create: (context) => CategoriesCubit(),
        child: Column(
          children: [
            /// Categories Row
            // BlocBuilder<CategoriesCubit, CategoriesState>(
            //   builder: (context, state) {
            //     final categoriesCubit = context.read<CategoriesCubit>();
            //
            //     return Container(
            //       height: 36.h,
            //       margin: EdgeInsets.only(top: 18.h),
            //       child: ListView.separated(
            //         shrinkWrap: true,
            //         scrollDirection: Axis.horizontal,
            //         padding: EdgeInsets.zero,
            //         itemBuilder: (context, index) {
            //           final isSelected =
            //               categoriesCubit.selectedCategoryIndex == index;
            //
            //           return CategoryItemInRowWidget(
            //             title: categories[index],
            //             isSelected: isSelected,
            //             isFirst: index == 0,
            //             isLast: index == categories.length - 1,
            //             onTap: () {
            //               categoriesCubit.changeCategoryIndex(index);
            //             },
            //           );;
            //         },
            //         separatorBuilder: (context, index) => 10.horizontalSpace,
            //         itemCount: categories.length,
            //       ),
            //     );
            //   },
            // ),
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                final categoriesCubit = context.read<CategoriesCubit>();

                return Padding(
                  padding: EdgeInsets.only(top: 18.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(categories.length, (index) {
                          final isSelected =
                              categoriesCubit.selectedCategoryIndex == index;

                          return Padding(
                            padding: EdgeInsets.only(
                              left:
                                  index == categories.length - 1
                                      ? 0.w
                                      : 10.w,
                            ),
                            child: CategoryItemInRowWidget(
                              title: categories[index],
                              isSelected: isSelected,
                              isFirst: index == 0,
                              isLast: index == categories.length - 1,
                              onTap: () {
                                categoriesCubit.changeCategoryIndex(index);
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                );
              },
            ),
            18.verticalSpace,

            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: 18.h, left: 18.w, right: 18.w),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return CustomProductCardItemWidget(
                        product: products[index],
                      );
                    },
                    separatorBuilder: (context, index) => 12.verticalSpace,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


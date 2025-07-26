import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/services/di/di.dart';
import 'package:nourex/features/products/business_logic/products_cubit.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/features/categories/business_logic/categories_cubit.dart';
import 'package:nourex/features/products/presentation/widgets/category_item_in_row_widget.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_skeletonizer_widget.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_widget.dart';

class BestOffersScreen extends StatelessWidget {
  const BestOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          title: 'bestSellers'.tr(),
          isSubScreen: true,
          onTapBack: () {
            context.pop();
          },
          onTapSearch: () {},
        ),
      ),
      body: BlocProvider(
        create: (context) => CategoriesCubit(getIt()),
        child: Column(
          children: [
            /// Categories Row
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

            BlocBuilder<ProductsCubit, ProductsState>(
              buildWhen: (previous, current) =>
              current is GetAllProductsLoadingState ||
                  current is GetAllProductsSuccessState ||
                  current is GetAllProductsErrorState ||
                  current is GetAllProductsPaginationLoadingState,
              builder: (context, state) {
                final cubit = context.read<ProductsCubit>();
                final products = cubit.allProducts;

                if (state is GetAllProductsLoadingState && products.isEmpty) {
                  /// 🔄 Loading shimmer state
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 18.h, left: 18.w, right: 18.w),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 6,
                          itemBuilder: (context, index) => CustomProductCardItemSkeletonizerWidget(),
                          separatorBuilder: (context, index) => 12.verticalSpace,
                        ),
                      ),
                    ),
                  );
                } else if (products.isEmpty) {
                  /// ❌ Empty state
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Text('noProducts'.tr()),
                    ),
                  );
                }

                /// ✅ Success state
                return Expanded(
                  child: SingleChildScrollView(
                    controller: cubit.scrollController,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 18.h, left: 18.w, right: 18.w),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                Routes.productDetailsScreen,
                                arguments: products[index],
                              );
                            },
                            child: CustomProductCardItemWidget(
                              product: products[index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => 12.verticalSpace,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nourex/core/extensions/navigation_extension.dart';
// import 'package:nourex/core/routing/routes_name.dart';
// import 'package:nourex/core/services/di/di.dart';
// import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
// import 'package:nourex/features/categories/business_logic/categories_cubit.dart';
// import 'package:nourex/features/products/business_logic/products_cubit.dart';
// import 'package:nourex/features/products/presentation/widgets/category_item_in_row_widget.dart';
// import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_skeletonizer_widget.dart';
// import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_widget.dart';
// import 'package:skeletonizer/skeletonizer.dart';
//
// class BestSellerScreen extends StatelessWidget {
//   const BestSellerScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(74.h),
//         child: MainAppBar2Widget(
//           title: 'bestSellers'.tr(),
//           isSubScreen: true,
//           onTapBack: () {
//             context.pop();
//           },
//           onTapSearch: () {},
//         ),
//       ),
//       body: MultiBlocProvider(
//         providers: [
//           BlocProvider(
//             create: (context) => CategoriesCubit(getIt())..getInitialCategories(),
//           ),
//           BlocProvider(
//             create: (context) => ProductsCubit(getIt())..getInitialProducts(),
//           ),
//         ],
//         child: Column(
//           children: [
//
//             /// Categories Row
//             BlocBuilder<CategoriesCubit, CategoriesState>(
//               builder: (context, state) {
//                 final categoriesCubit = context.read<CategoriesCubit>();
//                 final categories = categoriesCubit.allCategories;
//
//                 return state is GetAllCategoriesLoadingState ||
//                     categories.isEmpty
//                     ? Skeletonizer(
//                   enabled: true,
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 18.h),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: List.generate(6, (index) {
//                             final isSelected = false;
//
//                             return Padding(
//                               padding: EdgeInsets.only(
//                                 left: index == 6 - 1 ? 0.w : 10.w,
//                               ),
//                               child: CategoryItemInRowWidget(
//                                 title: 'Category name',
//                                 isSelected: isSelected,
//                                 isFirst: index == 0,
//                                 isLast: index == categories.length - 1,
//                                 onTap: () {},
//                               ),
//                             );
//                           }),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//                     : Padding(
//                   padding: EdgeInsets.only(top: 18.h),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children:
//                         List.generate(categories.length, (index) {
//                           final isSelected =
//                               categoriesCubit.selectedCategoryIndex ==
//                                   index;
//
//                           return Padding(
//                             padding: EdgeInsets.only(
//                               left: index == categories.length - 1
//                                   ? 0.w
//                                   : 10.w,
//                             ),
//                             child: CategoryItemInRowWidget(
//                               title: categories[index].name ?? '',
//                               isSelected: isSelected,
//                               isFirst: index == 0,
//                               isLast: index == categories.length - 1,
//                               onTap: () {
//                                 final productsCubit = context.read<ProductsCubit>();
//
//                                 categoriesCubit
//                                     .changeCategoryIndex(index);
//
//                                 final selectedCategoryId = categories[index].id ?? '';
//                                 if (selectedCategoryId.isNotEmpty) {
//                                   productsCubit.getInitialProductsByCategory(categoryId: selectedCategoryId);
//                                 }
//                               },
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             18.verticalSpace,
//
//             BlocBuilder<ProductsCubit, ProductsState>(
//               buildWhen: (previous, current) =>
//               current is GetAllProductsLoadingState ||
//                   current is GetAllProductsSuccessState ||
//                   current is GetAllProductsErrorState ||
//                   current is GetAllProductsPaginationLoadingState ||
//                   current is GetProductByCategoryLoadingState ||
//                   current is GetProductByCategorySuccessState ||
//                   current is GetProductByCategoryErrorState ||
//                   current is GetProductByCategoryPaginationLoadingState,
//               builder: (context, state) {
//                 final cubit = context.read<ProductsCubit>();
//                 final products = cubit.allProducts;
//
//                 if ((state is GetAllProductsLoadingState || state is GetProductByCategoryLoadingState) && products.isEmpty) {
//                   /// 🔄 Loading shimmer state
//                   return Expanded(
//                     child: SingleChildScrollView(
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                             bottom: 18.h, left: 18.w, right: 18.w),
//                         child: ListView.separated(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: 6,
//                           itemBuilder: (context, index) =>
//                               CustomProductCardItemSkeletonizerWidget(),
//                           separatorBuilder: (context, index) =>
//                           12.verticalSpace,
//                         ),
//                       ),
//                     ),
//                   );
//                 } else if (products.isEmpty) {
//                   /// ❌ Empty state
//                   return Center(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 50.h),
//                       child: Text('noProducts'.tr()),
//                     ),
//                   );
//                 }
//
//                 /// ✅ Success state
//                 return Expanded(
//                   child: SingleChildScrollView(
//                     controller: cubit.scrollController,
//                     child: Container(
//                       padding: EdgeInsets.only(
//                           bottom: 18.h, left: 18.w, right: 18.w),
//                       child: ListView.separated(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: products.length,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () {
//                               context.pushNamed(
//                                 Routes.productDetailsScreen,
//                                 arguments: products[index].id,
//                               );
//                             },
//                             child: CustomProductCardItemWidget(
//                               product: products[index],
//                             ),
//                           );
//                         },
//                         separatorBuilder: (context, index) => 12.verticalSpace,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/services/di/di.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/loading/custom_loading_when_loading_more_widget.dart';
import 'package:nourex/core/widgets/loading/custom_refresh_indicator_widget.dart';
import 'package:nourex/features/categories/business_logic/categories_cubit.dart';
import 'package:nourex/features/categories/data/model/category_data_model.dart';
import 'package:nourex/features/products/business_logic/products_cubit.dart';
import 'package:nourex/features/products/presentation/widgets/category_item_in_row_widget.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_skeletonizer_widget.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BestSellerScreen extends StatelessWidget {
  const BestSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CategoriesCubit(getIt())..getInitialCategories(),
          ),
          BlocProvider(
            create: (context) => ProductsCubit(getIt())..getInitialBestSeller(),
          ),
        ],
        child: Column(
          children: [
            /// Categories Row
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                final categoriesCubit = context.read<CategoriesCubit>();
                final categories = categoriesCubit.allCategories;

                /// Create a list with "All" as the first item
                final displayCategories = [
                  CategoryModel(id: '', name: 'all'.tr()),
                  ...categories,
                ];

                return state is GetAllCategoriesLoadingState
                    ? Skeletonizer(
                  enabled: true,
                  child: Padding(
                    padding: EdgeInsets.only(top: 18.h,),
                    child: SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(6, (index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: index == 5 ? 0.w : 10.w,
                              ),
                              child: CategoryItemInRowWidget(
                                title: 'Category name',
                                isSelected: false,
                                isFirst: index == 0,
                                isLast: index == 5,
                                onTap: () {},
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
                    : Padding(
                  padding: EdgeInsets.only(top: 18.h,),
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(displayCategories.length, (index) {
                          final isSelected = categoriesCubit.selectedCategoryIndex == index;
                          final category = displayCategories[index];

                          return Padding(
                            // padding: EdgeInsets.only(
                            //   right: index == displayCategories.length - 1 ? 0.w : 10.w,
                            // ),
                            padding: EdgeInsets.only(
                              left: index == categories.length - 1
                                  ? 10.w
                                  : 10.w,
                            ),
                            child: CategoryItemInRowWidget(
                              title: category.name ?? '',
                              isSelected: isSelected,
                              isFirst: index == 0,
                              isLast: index == displayCategories.length - 1,
                              onTap: () {
                                final productsCubit = context.read<ProductsCubit>();
                                categoriesCubit.changeCategoryIndex(index);

                                if (index == 0) {
                                  // Fetch all products for "All" category
                                  productsCubit.getInitialBestSeller();
                                } else {
                                  // Fetch products for specific category
                                  final selectedCategoryId = categories[index - 1].id ?? '';
                                  if (selectedCategoryId.isNotEmpty) {
                                    productsCubit.getInitialBestSeller(
                                        categoryId: selectedCategoryId);
                                  }
                                }
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

            /// Products
            BlocBuilder<ProductsCubit, ProductsState>(
              buildWhen: (previous, current) =>
              current is GetAllBestSellerLoadingState ||
                  current is GetAllBestSellerSuccessState ||
                  current is GetAllBestSellerErrorState ||
                  current is GetAllBestSellerPaginationLoadingState,
              builder: (context, state) {
                final cubit = context.read<ProductsCubit>();
                final products = cubit.allProducts;

                return Expanded(
                  child: CustomRefreshIndicatorWidget(
                    controller: cubit.scrollController,
                    refreshIndicatorKey: cubit.refreshIndicatorKey,
                    onRefresh: () {
                      final categoriesCubit = context.read<CategoriesCubit>();
                      if (categoriesCubit.selectedCategoryIndex == 0) {
                        return cubit.getInitialBestSeller();
                      } else {
                        final selectedCategoryId = categoriesCubit.allCategories[categoriesCubit.selectedCategoryIndex - 1].id ?? '';
                        return cubit.getInitialBestSeller(categoryId: selectedCategoryId);
                      }
                    },
                    slivers: [
                      /// Loading state
                      if ((state is GetAllBestSellerLoadingState) && products.isEmpty)
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                          sliver: SliverList.separated(
                            itemCount: 6,
                            separatorBuilder: (context, index) => 12.verticalSpace,
                            itemBuilder: (context, index) => CustomProductCardItemSkeletonizerWidget(),
                          ),
                        )

                      /// Empty state
                      else if (products.isEmpty)
                        SliverToBoxAdapter(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 50.h),
                              child: Text('noProducts'.tr()),
                            ),
                          ),
                        )

                      /// Success state
                      else
                        SliverPadding(
                          padding: EdgeInsets.only(bottom: 18.h, left: 18.w, right: 18.w, top: 18.h),
                          sliver: SliverList.separated(
                            itemCount: products.length,
                            separatorBuilder: (context, index) => 12.verticalSpace,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  context.pushNamed(
                                    Routes.productDetailsScreen,
                                    arguments: products[index].id,
                                  );
                                },
                                child: CustomProductCardItemWidget(
                                  isInHome: false,
                                  product: products[index],
                                ),
                              );
                            },
                          ),
                        ),

                      /// Pagination loading
                      if (state is GetAllBestSellerPaginationLoadingState)
                        SliverToBoxAdapter(
                          child: CustomLoadingWhenLoadingMoreWidget(),
                        ),

                      /// Space at bottom
                      SliverToBoxAdapter(child: 18.verticalSpace),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
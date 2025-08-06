import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/services/di/di.dart';
import 'package:nourex/features/banners/business_logic/banners_cubit.dart';
import 'package:nourex/features/categories/business_logic/categories_cubit.dart';
import 'package:nourex/features/categories/data/model/category_model_data.dart';
import 'package:nourex/features/categories/presentation/presentation/widgets/custom_category_in_all_categories_widget.dart';
import 'package:nourex/features/home/presentation/widgets/custom_category_in_home_widget.dart';
import 'package:nourex/features/home/presentation/widgets/custom_category_skeletonizer_in_home_widget.dart';
import 'package:nourex/features/products/business_logic/products_cubit.dart';
import 'package:nourex/features/products/data/models/product_data_model.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_widget.dart';
import 'package:nourex/core/widgets/row/show_more_row_widget.dart';
import 'package:nourex/features/banners/presentation/widgets/banner_widget.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_skeletonizer_widget.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          MainAppBarWidget(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 18.h),
              child: Column(
                children: [
                  /// Banner Images
                  BlocProvider(
                    create: (context) =>
                        BannersCubit(getIt())..getInitialBanners(),
                    child: BannerWidget(),
                  ),
                  18.verticalSpace,

                  /// ====================================== ///

                  /// Categories In Home Screen
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: ShowMoreRowWidget(
                      title: 'category'.tr(),
                      onTapShowMore: () {
                        context.pushNamedWithSwipe(Routes.categoriesScreen);
                        // context.pushNamed(Routes.categoriesScreen);
                      },
                    ),
                  ),
                  12.verticalSpace,

                  /// Success
                  Container(
                    height: 110.h,
                    padding: EdgeInsets.only(right: 0.w),
                    child: BlocProvider(
                      create: (context) =>
                          CategoriesCubit(getIt())..getInitialCategories(),
                      child: BlocBuilder<CategoriesCubit, CategoriesState>(
                        builder: (context, state) {
                          final categoryCubit = context.read<CategoriesCubit>();
                          final categories = categoryCubit.allCategories;

                          /// Empty
                          return categories == []
                              ? Text(
                                  'noInvoices'.tr(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : categories.isEmpty ||
                                      state is GetAllCategoriesLoadingState

                                  /// Loading
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 6,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            right: index == 0 ? 18.w : 0,
                                            left: index == categories.length - 1
                                                ? 18.w
                                                : 12.w,
                                          ),
                                          child:
                                              CustomCategorySkeletonizerInHomeWidget(),
                                          // child: CustomCategoryInHomeSkeletonizerWidget(),
                                        );
                                      },
                                    )

                                  /// Loaded
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 6,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            context.pushNamed(
                                              Routes.productsByCategoryScreen,
                                              arguments: {
                                                'categoryName':
                                                    categories[index].name,
                                                'categoryId':
                                                    categories[index].id
                                              },
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              right: index == 0 ? 18.w : 0,
                                              left:
                                                  index == categories.length - 1
                                                      ? 18.w
                                                      : 12.w,
                                            ),
                                            child: CustomCategoryInHomeWidget(
                                              imageUrl:
                                                  categories[index].image ?? '',
                                              categoryName:
                                                  categories[index].name ?? '',
                                            ),
                                            // child: CustomCategoryInHomeSkeletonizerWidget(),
                                          ),
                                        );
                                      },
                                    );
                        },
                      ),
                    ),
                  ),
                  18.verticalSpace,

                  /// ====================================== ///

                  /// Best Seller
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: ShowMoreRowWidget(
                      title: 'popularProducts'.tr(),
                      onTapShowMore: () {
                        context.pushNamed(Routes.bestSellerScreen);
                      },
                    ),
                  ),
                  12.verticalSpace,
                  BlocProvider(
                    create: (context) =>
                        ProductsCubit(getIt())..getInitialProducts(),
                    child: BlocBuilder<ProductsCubit, ProductsState>(
                      buildWhen: (previous, current) =>
                          current is GetAllProductsLoadingState ||
                          current is GetAllProductsSuccessState ||
                          current is GetAllProductsErrorState,
                      builder: (context, state) {
                        final products =
                            context.read<ProductsCubit>().allProducts;

                        if (state is GetAllProductsLoadingState &&
                            products.isEmpty) {
                          /// Loading state with shimmer/skeleton
                          return SizedBox(
                            height: 124.h,
                            child: ListView.builder(
                              itemCount: 2,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    right: index == 0 ? 18.w : 0,
                                    left: index == 1 ? 18.w : 12.w,
                                  ),
                                  child:
                                      CustomProductCardItemSkeletonizerWidget(),
                                );
                              },
                            ),
                          );
                        } else if (products.isEmpty) {
                          /// Empty state
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: Text('noProducts'.tr()),
                          );
                        }

                        // Success state
                        return SizedBox(
                          height: 124.h,
                          child: ListView.builder(
                            itemCount: products.length.clamp(0, 10),

                            /// Clamp if needed
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                  right: index == 0 ? 18.w : 0,
                                  left: index == products.length - 1
                                      ? 18.w
                                      : 12.w,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    context.pushNamed(
                                      Routes.productDetailsScreen,
                                      arguments: products[index].id,
                                    );
                                  },
                                  child: CustomProductCardItemWidget(
                                    product: products[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  18.verticalSpace,

                  /// Best Offers
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: ShowMoreRowWidget(
                      title: 'bestOffers'.tr(),
                      onTapShowMore: () {
                        context.pushNamed(Routes.bestOffersScreen);
                      },
                    ),
                  ),
                  12.verticalSpace,

                  /// List of products
                  /// Success
                  BlocProvider(
                    create: (context) =>
                        ProductsCubit(getIt())..getInitialProducts(),
                    child: BlocBuilder<ProductsCubit, ProductsState>(
                      buildWhen: (previous, current) =>
                          current is GetAllProductsLoadingState ||
                          current is GetAllProductsSuccessState ||
                          current is GetAllProductsErrorState,
                      builder: (context, state) {
                        final products =
                            context.read<ProductsCubit>().allProducts;

                        if (state is GetAllProductsLoadingState &&
                            products.isEmpty) {
                          // Loading state with shimmer/skeleton
                          return SizedBox(
                            height: 124.h,
                            child: ListView.builder(
                              itemCount: 2,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    right: index == 0 ? 18.w : 0,
                                    left: index == 1 ? 18.w : 12.w,
                                  ),
                                  child:
                                      CustomProductCardItemSkeletonizerWidget(),
                                );
                              },
                            ),
                          );
                        } else if (products.isEmpty) {
                          // Empty state
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: Text('noProducts'.tr()),
                          );
                        }

                        // Success state
                        return SizedBox(
                          height: 124.h,
                          child: ListView.builder(
                            itemCount: products.length.clamp(0, 10),

                            /// Clamp if needed
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                  right: index == 0 ? 18.w : 0,
                                  left: index == products.length - 1
                                      ? 18.w
                                      : 12.w,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    context.pushNamed(
                                      Routes.productDetailsScreen,
                                      arguments: products[index],
                                    );
                                  },
                                  child: CustomProductCardItemWidget(
                                    product: products[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  18.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

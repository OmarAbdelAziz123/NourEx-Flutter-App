import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/services/di/di.dart';
import 'package:nourex/core/widgets/loading/custom_loading_when_loading_more_widget.dart';
import 'package:nourex/core/widgets/loading/custom_refresh_indicator_widget.dart';
import 'package:nourex/features/categories/data/model/category_data_model.dart';
import 'package:nourex/features/products/business_logic/products_cubit.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/features/categories/business_logic/categories_cubit.dart';
import 'package:nourex/features/products/presentation/widgets/category_item_in_row_widget.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_skeletonizer_widget.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BestOffersScreen extends StatelessWidget {
  const BestOffersScreen({super.key});

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
            create: (context) => ProductsCubit(getIt())..getInitialBestOffers(),
          ),
        ],
        child: Column(
          children: [
            /// Categories Row
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                final categoriesCubit = context.read<CategoriesCubit>();
                final categories = categoriesCubit.allCategories;

                // Create a list with "All" as the first item
                final displayCategories = [
                  CategoryModel(id: '', name: 'all'.tr()), // Synthetic "All" category
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
                                right: index == 5 ? 10.w : 10.w,
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
                                  productsCubit.getInitialBestOffers();
                                } else {
                                  // Fetch products for specific category
                                  final selectedCategoryId = categories[index - 1].id ?? '';
                                  if (selectedCategoryId.isNotEmpty) {
                                    productsCubit.getInitialBestOffers(
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
              current is GetAllBestOffersLoadingState ||
                  current is GetAllBestOffersSuccessState ||
                  current is GetAllBestOffersErrorState ||
                  current is GetAllBestOffersPaginationLoadingState ,
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
                        return cubit.getInitialBestOffers();
                      } else {
                        final selectedCategoryId = categoriesCubit.allCategories[categoriesCubit.selectedCategoryIndex - 1].id ?? '';
                        return cubit.getInitialBestOffers(categoryId: selectedCategoryId);
                      }
                    },
                    slivers: [
                      /// Loading state
                      if ((state is GetAllBestOffersLoadingState) && products.isEmpty)
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
                      if (state is GetAllBestOffersPaginationLoadingState)
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

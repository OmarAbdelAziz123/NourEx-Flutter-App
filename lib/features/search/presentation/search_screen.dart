import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/widgets/loading/custom_loading_when_loading_more_widget.dart';
import 'package:nourex/core/widgets/loading/custom_refresh_indicator_widget.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_in_search_widget.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_skeletonizer_widget.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_widget.dart';
import 'package:nourex/features/search/business_logic/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(74.h),
            child: MainAppBarInSearchWidget(),
          ),
          body: BlocBuilder<SearchCubit, SearchState>(
            buildWhen: (previous, current) =>
                current is GetProductsBySearchLoadingState ||
                current is GetProductsBySearchSuccessState ||
                current is GetProductsBySearchErrorState ||
                current is GetProductsBySearchPaginationLoadingState,
            builder: (context, state) {
              final cubit = context.read<SearchCubit>();
              final searchController = cubit.searchController;
              final products = cubit.allProducts;

              return CustomRefreshIndicatorWidget(
                onRefresh: () =>
                    cubit.getMoreProductsProductsBySearch(),
                controller: cubit.scrollController,
                refreshIndicatorKey: cubit.refreshIndicatorKey,
                slivers: [
                  /// Loading state
                  if (state is GetProductsBySearchLoadingState && products.isEmpty)
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
                          child: Text('noProductsFound'.tr()),
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
                  if (state is GetProductsBySearchPaginationLoadingState)
                    SliverToBoxAdapter(
                      child: CustomLoadingWhenLoadingMoreWidget(),
                    ),

                  /// Space at bottom
                  SliverToBoxAdapter(child: 18.verticalSpace),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

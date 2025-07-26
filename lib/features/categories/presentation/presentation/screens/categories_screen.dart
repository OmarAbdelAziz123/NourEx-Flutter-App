import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nourex/core/widgets/loading/custom_loading_when_loading_more_widget.dart';
import 'package:nourex/features/categories/business_logic/categories_cubit.dart';
import 'package:nourex/features/categories/presentation/presentation/widgets/custom_category_in_all_categories_widget.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/features/categories/presentation/presentation/widgets/custom_category_skeletonizer_in_all_categories_widget.dart';
import 'package:nourex/core/widgets/loading/custom_refresh_indicator_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CategoriesCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'category'.tr(),
          isSubScreen: true,
          onTapBack: () {
            context.pop();
          },
          onTapSearch: () {},
        ),
      ),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        buildWhen:
            (previous, current) =>
                current is GetAllCategoriesLoadingState ||
                current is GetAllCategoriesSuccessState ||
                current is GetAllCategoriesErrorState ||
                current is CategoriesPaginationLoading,
        builder: (context, state) {
          final categories = cubit.allCategories;

          return CustomRefreshIndicatorWidget(
            controller: cubit.scrollController,
            refreshIndicatorKey: cubit.refreshIndicatorKey,
            onRefresh: () => cubit.getInitialCategories(),
            slivers: [
              /// Loading State
              if (categories.isEmpty && state is GetAllCategoriesLoadingState)
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          CustomCategoryInAllCategoriesSkeletonizerWidget(),
                      childCount: 12,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12.h,
                      crossAxisSpacing: 12.w,
                      mainAxisExtent: 144.h,
                    ),
                  ),
                )
              /// Empty state
              else if (categories == [] ||
                  categories.isEmpty && state is! GetAllCategoriesLoadingState)
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Text('noCategory'.tr()),
                    ),
                  ),
                )
              /// Error state
              else if (state is GetAllCategoriesErrorState &&
                  categories.isEmpty)
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Column(
                        children: [
                          Text('noCategoryDescription'.tr()),
                          SizedBox(height: 10.h),
                          ElevatedButton(
                            onPressed: () => cubit.getInitialCategories(),
                            child: Text('retry'.tr()),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              /// Loaded Categories
              else ...[
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 18.h,
                  ),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return CustomCategoryInAllCategoriesWidget(
                        imageUrl: categories[index].image ?? '',
                        categoryName: categories[index].name ?? '',
                      );
                    }, childCount: categories.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12.h,
                      crossAxisSpacing: 12.w,
                      mainAxisExtent: 144.h,
                    ),
                  ),
                ),

                /// Pagination loading indicator
                if (state is CategoriesPaginationLoading)
                  SliverToBoxAdapter(
                    child: CustomLoadingWhenLoadingMoreWidget(),
                  ),
              ],

              /// Space at bottom
              SliverToBoxAdapter(child: 18.verticalSpace),
            ],
          );
        },
      ),
    );
  }
}

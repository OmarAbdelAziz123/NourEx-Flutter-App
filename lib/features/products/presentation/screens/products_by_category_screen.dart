import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/features/products/business_logic/products_cubit.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_skeletonizer_widget.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_widget.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: data['categoryName'],
          isSubScreen: true,
          onTapBack: () {
            context.pop();
          },
          onTapSearch: () {},
        ),
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        buildWhen: (previous, current) =>
        current is GetProductByCategorySuccessState ||
            current is GetProductByCategoryLoadingState ||
            current is GetProductByCategoryErrorState ||
            current is GetProductByCategoryPaginationLoadingState,
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
          return SingleChildScrollView(
            controller: cubit.scrollController,
            child: Container(
              padding: EdgeInsets.only(bottom: 18.h, left: 18.w, right: 18.w),
              child: Column(
                children: [
                  18.verticalSpace,

                  /// Products
                  ListView.separated(
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

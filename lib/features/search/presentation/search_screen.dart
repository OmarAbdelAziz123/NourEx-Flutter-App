import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/features/products/data/models/product_data_model.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_in_search_widget.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_widget.dart';
import 'package:nourex/features/search/business_logic/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();
        final searchController = cubit.searchController;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(74.h),
            child: MainAppBarInSearchWidget(),
          ),
          body: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              final cubit = context.read<SearchCubit>();
              final searchController = cubit.searchController;
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

              return Column(
                children: [
                  /// Products List
                  Expanded(
                    child: ListView.separated(
                      itemCount: products.length,
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 18.h,
                      ),
                      separatorBuilder: (context, index) => 12.verticalSpace,
                      itemBuilder: (context, index) {
                        return CustomProductCardItemWidget(
                          product: products[index],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

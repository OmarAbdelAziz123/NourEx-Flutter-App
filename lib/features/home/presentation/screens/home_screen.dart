import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/features/categories/data/model/category_model_data.dart';
import 'package:nourex/features/categories/presentation/presentation/widgets/custom_category_in_all_categories_widget.dart';
import 'package:nourex/components/products/custom_product_card_item_widget.dart';
import 'package:nourex/components/products/models/product_data_model.dart';
import 'package:nourex/components/wallet/models/transactions_history_data_model.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_widget.dart';
import 'package:nourex/core/widgets/row/show_more_row_widget.dart';
import 'package:nourex/features/banners/presentation/widgets/banner_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryModelData> categories = [
      CategoryModelData(
        categoryName: 'ملابس رجالية',
        categoryImage: 'assets/pngs/clothes_man.png',
      ),
      CategoryModelData(
        categoryName: 'إكسسوارات',
        categoryImage: 'assets/pngs/accessories.png',
      ),
      CategoryModelData(
        categoryName: 'العطور',
        categoryImage: 'assets/pngs/uttor.png',
      ),
      CategoryModelData(
        categoryName: 'حقائب',
        categoryImage: 'assets/pngs/hijab.png',
      ),
      CategoryModelData(
        categoryName: 'منتجات العناية بالبشرة',
        categoryImage: 'assets/pngs/face.png',
      ),
      CategoryModelData(
        categoryName: 'أحذية',
        categoryImage: 'assets/pngs/shoes.png',
      ),
    ];
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
    ];
    final transactionsHistoryList = [
      TransactionsHistoryDataModel(
        method: 'deposit',
        orderNumber: '987n30',
        date: '20 يونيو 2025',
        numberOfTransactions: '100+',
      ),
      TransactionsHistoryDataModel(
        method: 'to_withdraw',
        orderNumber: '4687m',
        date: '20 يونيو 2025',
        numberOfTransactions: '100+',
      ),
      TransactionsHistoryDataModel(
        method: 'deposit',
        orderNumber: '987n30',
        date: '20 يونيو 2025',
        numberOfTransactions: '100+',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          MainAppBarWidget(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 18.h,
              ),
              child: Column(
                children: [
                  /// Banner Images
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                    ),
                    child: BannerWidget(),
                  ),
                  18.verticalSpace,

                  /// ====================================== ///

                  /// Categories In Home Screen
                  /// Loading
                  // Container(
                  //   height: 110.h,
                  //   padding: EdgeInsets.only(right: 0.w),
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: categories.length,
                  //     itemBuilder: (context, index) {
                  //       return Padding(
                  //         padding: EdgeInsets.only(
                  //           right: index == 0 ? 18.w : 0,
                  //           left: index == categories.length - 1 ? 18.w : 12.w,
                  //         ),
                  //         child: CustomCategoryInHomeSkeletonizerWidget(),
                  //       );
                  //     },
                  //   ),
                  // ),
                  // 18.verticalSpace,

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                    ),
                    child: ShowMoreRowWidget(
                      title: 'الفئات',
                      onTapShowMore: () {
                        context.pushNamed(Routes.categoriesScreen);
                      },
                    ),
                  ),
                  12.verticalSpace,

                  /// Success
                  Container(
                    height: 110.h,
                    padding: EdgeInsets.only(right: 0.w),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: index == 0 ? 18.w : 0,
                            left: index == categories.length - 1 ? 18.w : 12.w,
                          ),
                          child: CustomCategoryInHomeWidget(
                            imageUrl: categories[index].categoryImage,
                            categoryName: categories[index].categoryName,
                          ),
                          // child: CustomCategoryInHomeSkeletonizerWidget(),
                        );
                      },
                    ),
                  ),
                  18.verticalSpace,

                  /// ====================================== ///

                  /// Best Seller
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                    ),
                    child: ShowMoreRowWidget(
                      title: 'الأكثر مبيعاً',
                      onTapShowMore: () {
                        context.pushNamed(Routes.bestSellerScreen);
                      },
                    ),
                  ),
                  12.verticalSpace,


                  SizedBox(
                    height: 124.h,
                    child: ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            right: index == 0 ? 18.w : 0,
                            left: index == products.length - 1 ? 18.w : 12.w,
                          ),
                          child: CustomProductCardItemWidget(
                            product: products[index],
                          ),
                          // child: CustomProductCardItemSkeletonizerWidget(),
                        );
                      },
                    ),
                  ),
                  18.verticalSpace,

                  /// List of products
                  /// Loading
                  // SizedBox(
                  //   height: 124.h,
                  //   child: ListView.builder(
                  //     itemCount: 2,
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         margin: EdgeInsets.only(
                  //           right: index == 0 ? 18.w : 0,
                  //           left: index == products.length - 1 ? 18.w : 12.w,
                  //         ),
                  //         // child: CustomProductCardItemWidget(
                  //         //   product: products[index],
                  //         // ),
                  //         child: CustomProductCardItemSkeletonizerWidget(),
                  //       );
                  //     },
                  //   ),
                  // ),
                  // 18.verticalSpace,

                  /// Best Offers
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                    ),
                    child: ShowMoreRowWidget(
                      title: 'أفضل العروضً',
                      onTapShowMore: () {},
                    ),
                  ),
                  12.verticalSpace,

                  /// List of products
                  /// Success
                  SizedBox(
                    height: 124.h,
                    child: ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            right: index == 0 ? 18.w : 0,
                            left: index == products.length - 1 ? 18.w : 12.w,
                          ),
                          child: CustomProductCardItemWidget(
                            product: products[index],
                          ),
                          // child: CustomProductCardItemSkeletonizerWidget(),
                        );
                      },
                    ),
                  ),
                  18.verticalSpace,

                  // /// ====================================== ///
                  //
                  // /// Categories In Categories Screen
                  // /// Loading
                  // GridView.builder(
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemCount: categories.length,
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 3,
                  //     mainAxisSpacing: 12.h,
                  //     crossAxisSpacing: 12.w,
                  //     mainAxisExtent: 150.h,
                  //   ),
                  //   itemBuilder: (context, index) {
                  //     // return CustomCategoryInAllCategoriesWidget(
                  //     //   imageUrl: categories[index].categoryImage,
                  //     //   categoryName: categories[index].categoryName,
                  //     // );
                  //     return CustomCategoryInAllCategoriesSkeletonizerWidget();
                  //   },
                  // ),
                  // 18.verticalSpace,
                  //
                  // /// Success
                  // GridView.builder(
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemCount: categories.length,
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 3,
                  //     mainAxisSpacing: 12.h,
                  //     crossAxisSpacing: 12.w,
                  //     mainAxisExtent: 150.h,
                  //   ),
                  //   itemBuilder: (context, index) {
                  //     return CustomCategoryInAllCategoriesWidget(
                  //       imageUrl: categories[index].categoryImage,
                  //       categoryName: categories[index].categoryName,
                  //     );
                  //   },
                  // ),
                  // 18.verticalSpace,

                  // /// ====================================== ///
                  // ShowMoreRowWidget(
                  //   title: 'سجل المعاملاتً',
                  //   onTapShowMore: () {},
                  // ),
                  // 12.verticalSpace,
                  // /// My Points History
                  // /// Loading
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   padding: EdgeInsets.zero,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemCount: transactionsHistoryList.length,
                  //   itemBuilder: (context, index) {
                  //     return Padding(
                  //       padding: EdgeInsets.only(
                  //         bottom: 12.h,
                  //       ),
                  //       child: CustomTransactionsHistoryFromWalletSkeletonizerWidget(),
                  //     );
                  //   },
                  // ),
                  // 18.verticalSpace,
                  // /// Success
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   padding: EdgeInsets.zero,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemCount: transactionsHistoryList.length,
                  //   itemBuilder: (context, index) {
                  //     return Padding(
                  //       padding: EdgeInsets.only(
                  //         bottom: 12.h,
                  //       ),
                  //       child: CustomTransactionsHistoryFromWalletWidget(
                  //         transactionsHistoryDataModel:
                  //             transactionsHistoryList[index],
                  //       ),
                  //     );
                  //   },
                  // ),
                  // 18.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}





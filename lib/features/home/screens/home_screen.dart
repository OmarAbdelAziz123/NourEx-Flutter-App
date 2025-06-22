import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/components/category/custom_category_in_all_categories_widget.dart';
import 'package:nourex/components/category/model/category_model_data.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_widget.dart';
import 'package:nourex/core/widgets/row/show_more_row_widget.dart';
import 'package:nourex/features/home/widgets/banner_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CategoryModelData> categories = [
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainAppBarWidget(),
            Center(child: Text('NourEx')),
            ShowMoreRowWidget(title: 'عروض خاصة', onTapShowMore: () {}),
            18.verticalSpace,
            BannerWidget(),

            18.verticalSpace,

            /// Categories In Home Screen
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

            /// Categories In Categories Screen
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                mainAxisExtent: 150.h,
              ),
              itemBuilder: (context, index) {
                // return CustomCategoryInAllCategoriesWidget(
                //   imageUrl: categories[index].categoryImage,
                //   categoryName: categories[index].categoryName,
                // );
                return CustomCategoryInAllCategoriesSkeletonizerWidget();
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/features/categories/data/model/category_model_data.dart';
import 'package:nourex/features/categories/presentation/presentation/widgets/custom_category_in_all_categories_widget.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'الفئات',
          isSubScreen: true,
          onTapBack: () {
            context.pop();
          },
          onTapSearch: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 18.h,
        ),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                mainAxisExtent: 144.h,
              ),
              itemBuilder: (context, index) {
                return CustomCategoryInAllCategoriesWidget(
                  imageUrl: categories[index].categoryImage,
                  categoryName: categories[index].categoryName,
                );
              },
            ),
            18.verticalSpace,

          ],
        ),
      ),
    );
  }
}

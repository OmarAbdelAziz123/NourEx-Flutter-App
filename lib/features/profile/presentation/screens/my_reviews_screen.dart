import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/drop_down/custom_drop_down_menu_widget.dart';
import 'package:nourex/features/profile/presentation/widgets/review_item_skeletonizer_widget.dart';
import 'package:nourex/features/profile/presentation/widgets/review_item_widget.dart';

class MyReviewsScreen extends StatelessWidget {
  const MyReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'myReviews'.tr(),
          isSubScreen: true,
          haveOnlyNotification: false,
          onTapBack: () {
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            18.verticalSpace,

            /// List of reviews
            ReviewItemSkeletonizerWidget(),
            16.verticalSpace,
            ReviewItemWidget(
              reviewerName: 'ايه القحطاني',
              profileImagePath: 'assets/pngs/profile_image.png',
              reviewText:
              'الخدمة كانت رائعة جدًا! مقدم الخدمة محترف ووصل في الوقت المحدد. أنصح الجميع بالتعامل معه. شكرًا لتطبيق حرفة على التجربة الممتازة',
              timeAgo: 'منذ 6 ساعات',
              rating: 4.5,
              isArabic: true,
              moreIconButtonWidget: CustomDropDownMenuWidget(
                onSelected: (String value) {
                  if (value == 'الابلاغ') {
                    print('navigate to report screen');
                  } else if (value == 'تعديل التقييم') {
                    print('navigate to edit review screen');
                  } else if (value == 'حذف التقييم') {
                    print('delete review');
                  }
                },
                menuItems: [
                  {'title': 'الابلاغ', 'icon': Icons.report_outlined},
                  {'title': 'تعديل التقييم', 'icon': Iconsax.edit},
                  {'title': 'حذف التقييم', 'icon': Iconsax.trash},
                ],
              ),
            ),
            16.verticalSpace,
            ReviewItemWidget(
              reviewerName: 'ايه القحطاني',
              profileImagePath: 'assets/pngs/profile_image.png',
              reviewText:
              'الخدمة كانت رائعة جدًا! مقدم الخدمة محترف ووصل في الوقت المحدد. أنصح الجميع بالتعامل معه. شكرًا لتطبيق حرفة على التجربة الممتازة',
              timeAgo: 'منذ 6 ساعات',
              rating: 4.5,
              isArabic: true,
              moreIconButtonWidget: CustomDropDownMenuWidget(
                onSelected: (String value) {
                  if (value == 'الابلاغ') {
                    print('navigate to report screen');
                  } else if (value == 'تعديل التقييم') {
                    print('navigate to edit review screen');
                  } else if (value == 'حذف التقييم') {
                    print('delete review');
                  }
                },
                menuItems: [
                  {'title': 'الابلاغ', 'icon': Icons.report_outlined},
                  {'title': 'تعديل التقييم', 'icon': Iconsax.edit},
                  {'title': 'حذف التقييم', 'icon': Iconsax.trash},
                ],
              ),
            ),
            16.verticalSpace,
            ReviewItemWidget(
              reviewerName: 'ايه القحطاني',
              profileImagePath: 'assets/pngs/profile_image.png',
              reviewText:
              'الخدمة كانت رائعة جدًا! مقدم الخدمة محترف ووصل في الوقت المحدد. أنصح الجميع بالتعامل معه. شكرًا لتطبيق حرفة على التجربة الممتازة',
              timeAgo: 'منذ 6 ساعات',
              rating: 4.5,
              isArabic: true,
              moreIconButtonWidget: CustomDropDownMenuWidget(
                onSelected: (String value) {
                  if (value == 'الابلاغ') {
                    print('navigate to report screen');
                  } else if (value == 'تعديل التقييم') {
                    print('navigate to edit review screen');
                  } else if (value == 'حذف التقييم') {
                    print('delete review');
                  }
                },
                menuItems: [
                  {'title': 'الابلاغ', 'icon': Icons.report_outlined},
                  {'title': 'تعديل التقييم', 'icon': Iconsax.edit},
                  {'title': 'حذف التقييم', 'icon': Iconsax.trash},
                ],
              ),
            ),
            16.verticalSpace,
            ReviewItemWidget(
              reviewerName: 'ايه القحطاني',
              profileImagePath: 'assets/pngs/profile_image.png',
              reviewText:
              'الخدمة كانت رائعة جدًا! مقدم الخدمة محترف ووصل في الوقت المحدد. أنصح الجميع بالتعامل معه. شكرًا لتطبيق حرفة على التجربة الممتازة',
              timeAgo: 'منذ 6 ساعات',
              rating: 4.5,
              isArabic: true,
              moreIconButtonWidget: CustomDropDownMenuWidget(
                onSelected: (String value) {
                  if (value == 'الابلاغ') {
                    print('navigate to report screen');
                  } else if (value == 'تعديل التقييم') {
                    print('navigate to edit review screen');
                  } else if (value == 'حذف التقييم') {
                    print('delete review');
                  }
                },
                menuItems: [
                  {'title': 'الابلاغ', 'icon': Icons.report_outlined},
                  {'title': 'تعديل التقييم', 'icon': Iconsax.edit},
                  {'title': 'حذف التقييم', 'icon': Iconsax.trash},
                ],
              ),
            ),
            16.verticalSpace,
            ReviewItemWidget(
              reviewerName: 'ايه القحطاني',
              profileImagePath: 'assets/pngs/profile_image.png',
              reviewText:
              'الخدمة كانت رائعة جدًا! مقدم الخدمة محترف ووصل في الوقت المحدد. أنصح الجميع بالتعامل معه. شكرًا لتطبيق حرفة على التجربة الممتازة',
              timeAgo: 'منذ 6 ساعات',
              rating: 4.5,
              isArabic: true,
              moreIconButtonWidget: CustomDropDownMenuWidget(
                onSelected: (String value) {
                  if (value == 'الابلاغ') {
                    print('navigate to report screen');
                  } else if (value == 'تعديل التقييم') {
                    print('navigate to edit review screen');
                  } else if (value == 'حذف التقييم') {
                    print('delete review');
                  }
                },
                menuItems: [
                  {'title': 'الابلاغ', 'icon': Icons.report_outlined},
                  {'title': 'تعديل التقييم', 'icon': Iconsax.edit},
                  {'title': 'حذف التقييم', 'icon': Iconsax.trash},
                ],
              ),
            ),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_shared_bottom_sheet_review.dart';
import 'package:nourex/core/widgets/row/show_more_row_widget.dart';

class BottomSheets extends StatelessWidget {
  const BottomSheets({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _commentController = TextEditingController();

    return Column(
      children: [
        ShowMoreRowWidget(
          title: 'عروض خاصة',
          onTapShowMore: () {
            /// Show Bottom Sheet

            /// Login As Guest
            // showModalBottomSheet(
            //   context: context,
            //   builder: (context) {
            //     return CustomSharedShowBottomSheet(
            //       headingName: 'تسجيل كضيف',
            //       imagePath:
            //           'assets/svgs/yellow_icon_in_bottom_sheet_icon.svg',
            //       title:
            //           'أهلاً بك! يمكنك إستكشاف التطبيق وتصفح المنتجات بكل حرية',
            //       description:
            //           'لن تتمكن من إتمام عمليات الشراء إلا بعد تسجيل الدخول أو إنشاء حساب.',
            //       haveOneButton: false,
            //       buttonText1: 'تسجيل الدخول',
            //       buttonText2: 'تسجيل كضيف',
            //       onTap1: () {},
            //       onTap2: () {},
            //     );
            //   },
            // );
            /// In Change Password
            // showModalBottomSheet(
            //   context: context,
            //   isScrollControlled: true,
            //   builder: (context) {
            //     return CustomSharedShowBottomSheet(
            //       headingName: 'انشاء حساب',
            //       imagePath:
            //           'assets/svgs/green_icon_in_bottom_sheet_icon.svg',
            //       text1: 'تم تسجيل حسابك',
            //       text2: ' بنجاح',
            //       description:
            //           'لن تتمكن من إتمام عمليات الشراء إلا بعد تسجيل الدخول أو إنشاء حساب.',
            //       haveOneButton: true,
            //       haveTextSpan: true,
            //       buttonText1: 'هيا بنا',
            //     );
            //   },
            // );
            /// In Make Order
            // showModalBottomSheet(
            //   context: context,
            //   isScrollControlled: true,
            //   builder: (context) {
            //     return CustomSharedShowBottomSheet(
            //       headingName: 'طلبك رقم #12345',
            //       imagePath:
            //           'assets/svgs/green_icon_in_bottom_sheet_icon.svg',
            //       text1: 'تم طلب الاوردر',
            //       text2: ' بنجاح',
            //       description:
            //           'شكراً لثقتك بنا! 🎉 طلبك رقم #12345 تم بنجاح وجاري معالجته. يمكنك متابعة حالة الطلب من خلال صفحة الطلبات الخاصة بك. سنقوم بإبلاغك بأي تحديثات تتعلق بالشحن والتوصيل قريبًا. إذا كان لديك أي استفسار، لا تتردد في التواصل مع فريق الدعم',
            //       haveOneButton: false,
            //       haveTextSpan: true,
            //       buttonText1: 'التالي',
            //       buttonText2: 'طلباتي',
            //     );
            //   },
            // );
            /// In Delete Account
            // showModalBottomSheet(
            //   context: context,
            //   isScrollControlled: true,
            //   builder: (context) {
            //     return CustomSharedShowBottomSheet(
            //       headingName: 'حذف الحساب',
            //       imagePath:
            //       'assets/svgs/red_icon_in_bottom_sheet_icon.svg',
            //       text1: 'هل أنت متأكد من أنك تريد حذف ',
            //       text2: 'حسابك؟',
            //       description: 'هل أنت متأكد من أنك تريد حذف حسابك؟ سيتم فقدان جميع بياناتك بشكل نهائي!',
            //       haveOneButton: false,
            //       haveTextSpan: true,
            //       buttonText1: 'الغاء',
            //       buttonText2: 'حذف',
            //       text2Color: AppColors.redColor100,
            //     );
            //   },
            // );
            /// In Logout
            // showModalBottomSheet(
            //   context: context,
            //   isScrollControlled: true,
            //   builder: (context) {
            //     return CustomSharedShowBottomSheet(
            //       headingName: 'تسجيل الخروج',
            //       imagePath:
            //           'assets/svgs/yellow2_icon_in_bottom_sheet_icon.svg',
            //       text1: 'هل أنت متأكد من رغبتك في تسجيل ',
            //       text2: 'الخروج؟',
            //       description: 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
            //       haveOneButton: true,
            //       haveTextSpan: true,
            //       buttonText1: 'الغاء',
            //       buttonText2: 'تسجيل الخروج',
            //       text2Color: AppColors.yellowColor100,
            //     );
            //   },
            // );
            /// In Contact for support
            // showModalBottomSheet(
            //   context: context,
            //   isScrollControlled: true,
            //   builder: (context) {
            //     return CustomSharedShowBottomSheet(
            //       headingName: 'حذف التقييم',
            //       imagePath:
            //       'assets/svgs/red_icon_in_bottom_sheet_icon.svg',
            //       text1: 'هل أنت متأكد من أنك تريد حذف ',
            //       text2: 'التقييم؟',
            //       description: 'هل أنت متأكد من أنك تريد حذف التقييم الخاص بك؟ سيحذف التقييم نهائيا',
            //       haveOneButton: false,
            //       haveTextSpan: true,
            //       buttonText1: 'الغاء',
            //       buttonText2: 'حذف',
            //       text2Color: AppColors.redColor100,
            //     );
            //   },
            // );
            /// In Edit Review
            // showModalBottomSheet(
            //   context: context,
            //   isScrollControlled: true,
            //   builder: (context) {
            //     return CustomSharedBottomSheetReview(
            //       title: 'التعديل التقييم',
            //       initialRating: 3.5,
            //       buttonText1: 'تعديل',
            //       buttonText2: 'الغاء',
            //       nameOfFiled: 'تقييم',
            //       isEdit: true,
            //       hintText: 'psdihgouisdgoiuh',
            //       onRatingChanged: (rating) {
            //         print("New Rating: $rating");
            //       },
            //       commentController: _commentController,
            //       onEditPressed: () {
            //         print("Edited: ${_commentController.text}");
            //       },
            //       onCancelPressed: () {
            //         Navigator.pop(context);
            //       },
            //     );
            //   },
            // );
            /// Make Review
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return CustomSharedBottomSheetReview(
                  title: 'التقييم',
                  nameOfFiled: 'قيّم هذا المنتج',
                  initialRating: 3.5,
                  hintText: 'تقييمك يصنع الفرق! أخبرنا بتجربتك مع المنتج.',
                  isEdit: false,
                  buttonText1: 'تاكيد',
                  buttonText2: 'الغاء',
                  onRatingChanged: (rating) {
                    print("New Rating: $rating");
                  },
                  commentController: _commentController,
                  onEditPressed: () {
                    print("Edited: ${_commentController.text}");
                  },
                  onCancelPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}

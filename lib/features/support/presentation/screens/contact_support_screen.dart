import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_shared_show_bottom_sheet.dart';
import 'package:nourex/core/widgets/drop_down/custom_drop_down_widget.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  String? selectedSubject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'تواصل مع الدعم',
          isSubScreen: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 34.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              18.verticalSpace,
              Text(
                'الموضوع',
                style: Styles.highlightEmphasis,
              ),
              8.verticalSpace,

              /// TODO: add dropdown
              CustomDropdownButtonWidget<String>(
                  hint: 'اختر الموضوع',
                  isSvgPic: true,
                  onChanged: (selectedBrand) {
                    setState(() {
                      selectedSubject = selectedBrand;
                    });
                  },
                  isString: false,
                  getItemText: (item) => item,
                  getItemIcon: (item) {
                    switch (item) {
                      case 'مشكلة في التطبيق':
                        return 'assets/svgs/support_app.svg';
                      case 'مشكلة في الحساب':
                        return 'assets/svgs/support_account.svg';
                      case 'مشكلة في التسجيل':
                        return 'assets/svgs/support_register.svg';
                      default:
                        return '';
                    }
                  },
                  items: [
                    'مشكلة في التطبيق',
                    'مشكلة في الحساب',
                    'مشكلة في التسجيل',
                  ]),

              16.verticalSpace,

              Text(
                'الرسالة',
                style: Styles.highlightEmphasis,
              ),
              8.verticalSpace,

              CustomTextFormFieldWidget(
                borderRadius: AppConstants.borderRadius,
                borderWidth: 1.w,
                maxLines: 5,
                controller: TextEditingController(),
                backgroundColor: Colors.transparent,
                hintText: 'قم بإدخال الرسالة  الخاصة بك هنا',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarMakeButtonOnly(
        buttonTitle: 'إرسال',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return CustomSharedShowBottomSheet(
                headingName: 'تواصل مع الدعم',
                imagePath: 'assets/svgs/green_icon_in_bottom_sheet_icon.svg',
                text1: 'تم ارسال طلبك ',
                text2: 'بنجاح',
                description:
                    'رقم التذكرة: #TICKET-12987، سنقوم بالرد عليك خلال 48 ساعة',
                haveOneButton: true,
                haveTextSpan: true,
                buttonText1: 'التالي',
                text2Color: AppColors.greenColor100,
              );
            },
          );
        },
      ),
    );
  }
}

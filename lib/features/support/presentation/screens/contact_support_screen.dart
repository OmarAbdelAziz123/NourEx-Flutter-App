import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_shared_show_bottom_sheet.dart';
import 'package:nourex/core/widgets/drop_down/custom_drop_down_widget.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/support/business_logic/support_cubit.dart';

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
          title: 'contactSupport'.tr(),
          isSubScreen: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: BlocBuilder<SupportCubit, SupportState>(
        builder: (context, state) {
          final cubit = context.read<SupportCubit>();

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 34.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  18.verticalSpace,
                  Text(
                    'subject'.tr(),
                    style: Styles.highlightEmphasis,
                  ),
                  8.verticalSpace,
                  CustomDropdownButtonWidget<String>(
                    hint: 'selectSubject'.tr(),
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
                        case 'مشكلة في التسجيل أو تسجيل الدخول':
                          return 'assets/svgs/support_register.svg';
                        case 'مشكلة في الطلب':
                          return 'assets/svgs/support_app.svg';
                        case 'مشكلة في الدفع':
                          return 'assets/svgs/support_app.svg';
                        case 'لم يصلني طلبي':
                          return 'assets/svgs/support_app.svg';
                        case 'طلب راجع أو إرجاع منتج':
                          return 'assets/svgs/support_app.svg';
                        case 'طلب إلغاء الطلب':
                          return 'assets/svgs/support_app.svg';
                        case 'مشكلة في التوصيل':
                          return 'assets/svgs/support_app.svg';
                        case 'منتج غير مطابق للوصف':
                          return 'assets/svgs/support_app.svg';
                        case 'اقتراح أو ملاحظة':
                          return 'assets/svgs/support_app.svg';
                        case 'الإبلاغ عن بائع':
                          return 'assets/svgs/support_app.svg';
                        case 'طلب مساعدة عامة':
                          return 'assets/svgs/support_app.svg';
                        default:
                          return '';
                      }
                    },
                    items: [
                      'مشكلة في التطبيق'.tr(),
                      'مشكلة في الحساب'.tr(),
                      'مشكلة في التسجيل أو تسجيل الدخول'.tr(),
                      'مشكلة في الطلب'.tr(),
                      'مشكلة في الدفع'.tr(),
                      'لم يصلني طلبي'.tr(),
                      'طلب راجع أو إرجاع منتج'.tr(),
                      'طلب إلغاء الطلب'.tr(),
                      'مشكلة في التوصيل'.tr(),
                      'منتج غير مطابق للوصف'.tr(),
                      'اقتراح أو ملاحظة'.tr(),
                      'الإبلاغ عن بائع'.tr(),
                      'طلب مساعدة عامة'.tr(),
                    ],
                  ),
                  16.verticalSpace,
                  Text(
                    'message'.tr(),
                    style: Styles.highlightEmphasis,
                  ),
                  8.verticalSpace,
                  CustomTextFormFieldWidget(
                    borderRadius: AppConstants.borderRadius,
                    borderWidth: 1.w,
                    maxLines: 5,
                    controller: cubit.messageController,
                    backgroundColor: Colors.transparent,
                    hintText: 'message2'.tr(),
                    hintStyle: Styles.contentRegular.copyWith(
                      color: AppColors.neutralColor600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocConsumer<SupportCubit, SupportState>(
        listener: (context, state) {
          if (state is MakeSupportTicketSuccessState) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: false,
              enableDrag: false,
              builder: (context) {
                return PopScope(
                  canPop: false, // Prevents dismissal via back button
                  child: CustomSharedShowBottomSheet(
                    headingName: 'contactSupport'.tr(),
                    imagePath:
                        'assets/svgs/green_icon_in_bottom_sheet_icon.svg',
                    text1: 'orderSent2'.tr(),
                    text2: 'accountCreatedSuccess'.tr(),
                    description:
                        '${'trackingNumber'.tr()} ${state.supportResponseModel.data!.ticketSeq!}، ${'willReply'.tr()}',
                    haveOneButton: true,
                    haveTextSpan: true,
                    buttonText1: 'next'.tr(),
                    text2Color: AppColors.greenColor100,
                    onPressedOnOneButton: () {
                      context.pop();
                      context.pop();
                    },
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<SupportCubit>();

          return CustomBottomNavBarMakeButtonOnly(
            buttonTitle: 'send'.tr(),
            onPressed: () {
              if (cubit.messageController.text.isNotEmpty &&
                  selectedSubject != null) {
                cubit.makeSupportTicket(subject: selectedSubject!);
              } else if (selectedSubject == null) {
                ToastManager.showCustomToast(
                  message: 'subjectRequired'.tr(),
                  backgroundColor: AppColors.redColor200,
                  icon: Icons.error_outline,
                );
              } else if (cubit.messageController.text.isEmpty) {
                ToastManager.showCustomToast(
                  message: 'messageRequired'.tr(),
                  backgroundColor: AppColors.redColor200,
                  icon: Icons.error_outline,
                );
              }
            },
          );
        },
      ),
    );
  }
}

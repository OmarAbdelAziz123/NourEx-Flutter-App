import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_shared_show_bottom_sheet.dart';
import 'package:nourex/core/widgets/divider/custom_divider_in_bottom_sheet.dart';
import 'package:nourex/features/localization/presentation/localization_screen.dart';
import 'package:nourex/features/profile/data/models/settings/settings_data_model.dart';
import 'package:nourex/features/profile/presentation/widgets/custom_profile_container_in_settings_widget.dart';
import 'package:nourex/features/profile/presentation/widgets/custom_row_in_settings_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List settingsList = [
      SettingsDataModel(
        iconPath: 'assets/svgs/change_password.svg',
        title: 'تغير كلمة السر',
        onTap: () => context.pushNamed(Routes.changePassword),
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/wallet.svg',
        title: 'محفظتي',
        onTap: () => context.pushNamed(Routes.walletScreen),
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/my_rates.svg',
        title: 'تقييماتي',
        onTap: () {},
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/address.svg',
        title: 'العناوين',
        onTap: () {},
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/about_us.svg',
        title: 'حول الشركة',
        onTap: () => context.pushNamed(Routes.aboutUsScreen),
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/language.svg',
        title: 'لغة التطبيق',
        onTap: () {
          showLocalizationBottomSheet(context);
        },
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/privacy.svg',
        title: 'سياسة الخصوصية',
        onTap: () => context.pushNamed(Routes.privacyPolicyScreen),
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/security.svg',
        title: 'الشروط والأحكام',
        onTap: () => context.pushNamed(Routes.termsAndConditionsScreen),
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/support.svg',
        title: 'الدعم',
        onTap: () => context.pushNamed(Routes.supportScreen),
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/logout.svg',
        title: 'تسجيل خروج',
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return CustomSharedShowBottomSheet(
                headingName: 'تسجيل الخروج',
                imagePath:
                'assets/svgs/yellow2_icon_in_bottom_sheet_icon.svg',
                text1: 'هل أنت متأكد من رغبتك في تسجيل ',
                text2: 'الخروج؟',
                description: 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                haveOneButton: false,
                haveTextSpan: true,
                buttonText1: 'الغاء',
                buttonText2: 'خروج',
                text2Color: AppColors.yellowColor100,
              );
            },
          );
        },
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/remove.svg',
        title: 'حذف الحساب',
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return CustomSharedShowBottomSheet(
                headingName: 'حذف الحساب',
                imagePath:
                'assets/svgs/red_icon_in_bottom_sheet_icon.svg',
                text1: 'هل أنت متأكد من أنك تريد حذف ',
                text2: 'حسابك؟',
                description: 'هل أنت متأكد من أنك تريد حذف حسابك؟ سيتم فقدان جميع بياناتك بشكل نهائي!',
                haveOneButton: false,
                haveTextSpan: true,
                buttonText1: 'الغاء',
                buttonText2: 'حذف',
                text2Color: AppColors.redColor100,
              );
            },
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'settings'.tr(),
          onTapSearch: () {},
          onTapNotification: () {},
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: 18.w,
                left: 18.w,
                bottom: 18.h,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    18.verticalSpace,

                    /// User Data
                    CustomProfileContainerInSettingsWidget(),
                    18.verticalSpace,

                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: settingsList.length,
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.h,
                          ),
                          child: CustomDividerInBottomSheet(),
                        );
                      },
                      itemBuilder: (context, index) {
                        return CustomRowInSettingsWidget(
                          isLang: index == 5,
                          settingsDataModel: settingsList[index],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
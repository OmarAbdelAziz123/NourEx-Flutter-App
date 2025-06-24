import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/divider/custom_divider_in_bottom_sheet.dart';
import 'package:nourex/features/localization/presentation/localization_screen.dart';
import 'package:nourex/features/profile/data/models/settings/settings_data_model.dart';
import 'package:nourex/features/profile/widgets/custom_profile_container_in_settings_widget.dart';
import 'package:nourex/features/profile/widgets/custom_row_in_settings_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List settingsList = [
      SettingsDataModel(
        iconPath: 'assets/svgs/change_password.svg',
        title: 'تغير كلمة السر',
        onTap: () {},
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/wallet.svg',
        title: 'محفظتي',
        onTap: () {},
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
        onTap: () {},
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
        onTap: () {},
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/security.svg',
        title: 'الشروط والأحكام',
        onTap: () {},
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/support.svg',
        title: 'الدعم',
        onTap: () {},
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/logout.svg',
        title: 'تسجيل خروج',
        onTap: () {},
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/remove.svg',
        title: 'حذف الحساب',
        onTap: () {},
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
                          isLang: index == 3 ? true : false,
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
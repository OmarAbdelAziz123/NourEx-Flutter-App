import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_shared_show_bottom_sheet.dart';
import 'package:nourex/core/widgets/divider/custom_divider_in_bottom_sheet.dart';
import 'package:nourex/features/localization/presentation/localization_screen.dart';
import 'package:nourex/features/profile/business_logic/profile_cubit.dart';
import 'package:nourex/features/profile/data/models/settings/settings_data_model.dart';
import 'package:nourex/features/profile/presentation/widgets/custom_call_profile_container_in_settings_widget.dart';
import 'package:nourex/features/profile/presentation/widgets/custom_row_in_settings_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List settingsList = [
      SettingsDataModel(
        iconPath: 'assets/svgs/change_password.svg',
        title: 'changePassword'.tr(),
        onTap: () => context.pushNamed(Routes.changePassword),
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/wallet.svg',
        title: 'wallet'.tr(),
        onTap: () => context.pushNamed(Routes.walletScreen),
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/my_rates.svg',
        title: 'myReviews'.tr(),
        onTap: () => context.pushNamed(Routes.myReviewsScreen),
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/address.svg',
        title: 'addresses'.tr(),
        onTap: () => context.pushNamed(Routes.addressesScreen),
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/about_us.svg',
        title: 'aboutUs'.tr(),
        onTap: () => context.pushNamed(Routes.aboutUsScreen),
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/language.svg',
        title: 'language'.tr(),
        onTap: () {
          showLocalizationBottomSheet(context);
        },
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/privacy.svg',
        title: 'privacyPolicy'.tr(),
        onTap: () => context.pushNamed(Routes.privacyPolicyScreen),
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/security.svg',
        title: 'termsAndConditions'.tr(),
        onTap: () => context.pushNamed(Routes.termsAndConditionsScreen),
      ),
      SettingsDataModel(
        iconPath: 'assets/svgs/support.svg',
        title: 'support'.tr(),
        onTap: () => context.pushNamed(Routes.supportScreen),
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
              padding: EdgeInsets.only(right: 18.w, left: 18.w,),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    18.verticalSpace,

                    /// User Data
                    CustomCallProfileContainerInSettingsWidget(),
                    18.verticalSpace,

                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: settingsList.length,
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
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

                    BlocConsumer<ProfileCubit, ProfileState>(
                      listener: (context, state) {
                        if (state is LogoutSuccessState) {
                          context.pushNamedAndRemoveUntil(Routes.chooseLoginOrRegisterScreen);
                        }
                      },
                      builder: (context, state) {
                        final profileCubit = context.read<ProfileCubit>();

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Column(
                            children: [
                              CustomDividerInBottomSheet(),
                              16.verticalSpace,

                              CustomRowInSettingsWidget(
                                isLang: false,
                                settingsDataModel: SettingsDataModel(
                                  iconPath: 'assets/svgs/logout.svg',
                                  title: 'logout'.tr(),
                                  onTap: AppConstants.userToken == null ? () {

                                  } : () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return CustomSharedShowBottomSheet(
                                          headingName: 'logout2'.tr(),
                                          imagePath:
                                              'assets/svgs/yellow2_icon_in_bottom_sheet_icon.svg',
                                          text1:
                                              'AreYouSure'.tr(),
                                          text2: 'exit'.tr(),
                                          description:
                                              'exitDescription'.tr(),
                                          haveOneButton: false,
                                          haveTextSpan: true,
                                          buttonText1: 'cancel'.tr(),
                                          buttonText2: 'goOut'.tr(),
                                          text2Color: AppColors.yellowColor100,
                                          onTap1: () {
                                            Navigator.pop(context);
                                          },
                                          onTap2: () {
                                            profileCubit.userLogout();
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              16.verticalSpace,

                              CustomDividerInBottomSheet(),
                              16.verticalSpace,

                              CustomRowInSettingsWidget(
                                isLang: false,
                                settingsDataModel: SettingsDataModel(
                                  iconPath: 'assets/svgs/remove.svg',
                                  title: 'removeAccount'.tr(),
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return CustomSharedShowBottomSheet(
                                          headingName: 'removeAccount'.tr(),
                                          imagePath: 'assets/svgs/red_icon_in_bottom_sheet_icon.svg',
                                          text1: 'removeAccountDescription'.tr(),
                                          text2: 'حسابك؟',
                                          description:
                                          'removeAccountDescription2'.tr(),
                                          haveOneButton: false,
                                          haveTextSpan: true,
                                          buttonText1: 'cancel'.tr(),
                                          buttonText2: 'remove'.tr(),
                                          text2Color: AppColors.redColor100,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
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

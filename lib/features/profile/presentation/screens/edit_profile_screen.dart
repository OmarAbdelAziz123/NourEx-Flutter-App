import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/profile/business_logic/profile_cubit.dart';
import 'package:nourex/features/profile/data/models/profile/profile_data_model.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.profileData});

  final ProfileUserModel profileData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'profile'.tr(),
          isSubScreen: true,
          haveOnlyNotification: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final editProfileCubit = context.read<ProfileCubit>();

          return Form(
            key: editProfileCubit.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 18.w, right: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    18.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                editProfileCubit.chooseImageFromGallery();
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 45.r,
                                    backgroundColor: Colors.transparent,
                                    child: ClipOval(
                                      child: CacheNetworkImagesWidget(
                                        image:
                                            editProfileCubit.profileImage !=
                                                    null
                                                ? editProfileCubit.profileImage!.path
                                                : profileData.profilePic ??
                                                    'assets/pngs/profile_image2.png',
                                        borderRadius: AppConstants.borderRadius,
                                        boxFit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: SvgPicture.asset(
                                      'assets/svgs/camera_icon_in_profile.svg',
                                      width: 20.w,
                                      height: 20.h,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            10.verticalSpace,
                            Text(
                              profileData.name ?? 'No Name',
                              // 'محمد علي',
                              style: Styles.featureEmphasis,
                            ),
                            8.verticalSpace,
                          ],
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    Text('name2'.tr(), style: Styles.contentEmphasis),
                    8.verticalSpace,
                    CustomTextFormFieldWidget(
                      controller: editProfileCubit.nameController,
                      keyboardType: TextInputType.name,
                      backgroundColor: Colors.white,
                      validator: (value) {},
                      hintText: profileData.name ?? 'No Name',
                      // 'محمد علي',
                      hintStyle: Styles.contentRegular.copyWith(
                        color: AppColors.neutralColor600,
                      ),
                    ),
                    16.verticalSpace,
                    Text('email2'.tr(), style: Styles.contentEmphasis),
                    8.verticalSpace,
                    CustomTextFormFieldWidget(
                      controller: editProfileCubit.emailController,
                      backgroundColor: Colors.white,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {},
                      hintText: profileData.email ?? 'No Email',
                      // 'mohamedali@eg.com',
                      hintStyle: Styles.contentRegular.copyWith(
                        color: AppColors.neutralColor600,
                      ),
                    ),
                    16.verticalSpace,
                    Text('phoneNumber'.tr(), style: Styles.contentEmphasis),
                    8.verticalSpace,
                    CustomTextFormFieldWidget(
                      controller: editProfileCubit.phoneController,
                      backgroundColor: Colors.white,
                      keyboardType: TextInputType.phone,
                      validator: (value) {},
                      hintText: profileData.phone ?? 'No Phone',
                      // '01012345678',
                      hintStyle: Styles.contentRegular.copyWith(
                        color: AppColors.neutralColor600,
                      ),
                    ),
                    16.verticalSpace,
                    Text('age'.tr(), style: Styles.contentEmphasis),
                    8.verticalSpace,
                    CustomTextFormFieldWidget(
                      controller: editProfileCubit.ageController,
                      backgroundColor: Colors.white,
                      keyboardType: TextInputType.number,
                      validator: (value) {},
                      hintText: profileData.age.toString() ?? 'No Age',
                      // '25',
                      hintStyle: Styles.contentRegular.copyWith(
                        color: AppColors.neutralColor600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileSuccessState) {
            context.read<ProfileCubit>().getProfile();
            context.pushNamedAndRemoveUntil(
              Routes.mainLayoutScreen,
              arguments: 3,
            );
          }
        },
        builder: (context, state) {
          final editProfileCubit = context.watch<ProfileCubit>();
          final profileData = editProfileCubit.profileDataModel?.data;

          return CustomBottomNavBarMakeButtonOnly(
            buttonTitle: 'edit'.tr(),
            onPressed: () {
              print(
                "Current: ${editProfileCubit.nameController.text}, ${editProfileCubit.emailController.text}, ${editProfileCubit.phoneController.text}, ${editProfileCubit.ageController.text}",
              );
              print(
                "Original: ${editProfileCubit.profileDataModel?.data?.name ?? 'No Name'}, ${editProfileCubit.profileDataModel?.data?.email ?? 'No Email'}, ${editProfileCubit.profileDataModel?.data?.phone ?? 'No Phone'}, ${editProfileCubit.profileDataModel?.data?.age ?? 'No Age'}",
              );

              if (editProfileCubit.isDataChanged) {
                if (editProfileCubit.formKey.currentState!.validate()) {
                  print('data changed');
                  editProfileCubit.updateProfile();
                }
              } else {
                print('no data changed');
                ToastManager.showCustomToast(
                  message: 'noDataChanged'.tr(),
                  backgroundColor: AppColors.neutralColor700,
                );
              }
            },
          );
        },
      ),
    );
  }
}

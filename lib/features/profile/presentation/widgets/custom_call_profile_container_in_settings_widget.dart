import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/features/profile/business_logic/profile_cubit.dart';
import 'package:nourex/features/profile/presentation/widgets/custom_profile_container_in_settings_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomCallProfileContainerInSettingsWidget extends StatelessWidget {
  const CustomCallProfileContainerInSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profileCubit = context.read<ProfileCubit>();
        final profileData = profileCubit.profileDataModel?.data;

        return profileData != null
            ? GestureDetector(
              onTap: () => context.pushNamed(Routes.editProfileScreen, arguments: profileData),
              child: CustomProfileContainerWidget(
                name: profileData.name ?? 'No Name',
                email: profileData.email ?? 'No Email',
                imagePath:
                    profileData.profilePic ?? 'assets/pngs/profile_image.png',
              ),
            )
            : Skeletonizer(
              enabled: true,
              child: CustomProfileContainerWidget(
                name: 'No Name',
                email: 'No Email',
                imagePath: 'assets/pngs/profile_image.png',
              ),
            );
      },
    );
  }
}

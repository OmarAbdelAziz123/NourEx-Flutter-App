import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/features/addresses/data/models/addresses_data_model.dart';
import 'package:nourex/features/addresses/presentation/widgets/custom_addresses_container_widget.dart';
import '../../../../core/widgets/appbar/main_app_bar_2_widget.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressesList = [
      AddressesDataModel(addressesName: 'عنوان 1', addressesData: ['شارع 1', 'القاهرة', 'مصر']),
      AddressesDataModel(addressesName: 'عنوان 2', addressesData: ['شارع 2', 'القاهرة', 'مصر']),
      AddressesDataModel(addressesName: 'عنوان 3', addressesData: ['شارع 3', 'القاهرة', 'مصر']),
      AddressesDataModel(addressesName: 'عنوان 4', addressesData: ['شارع 4', 'القاهرة', 'مصر']),
      AddressesDataModel(addressesName: 'عنوان 5', addressesData: ['شارع 5', 'القاهرة', 'مصر']),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'العناوين',
          isSubScreen: true,
          haveOnlyNotification: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            12.verticalSpace,
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: addressesList.length,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return 16.verticalSpace;
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                  },
                  child: CustomAddressesContainerWidget(
                    addressesDataModel: addressesList[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarMakeButtonOnly(
        buttonTitle: 'اضافة عنوان',
        onPressed: () {
          context.pushNamed(Routes.addNewAddressScreen);
        },
      ),
    );
  }
}

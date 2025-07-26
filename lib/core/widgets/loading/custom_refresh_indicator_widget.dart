import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nourex/core/themes/app_colors.dart';

class CustomRefreshIndicatorWidget extends StatelessWidget {
  const CustomRefreshIndicatorWidget({
    super.key,
    required this.onRefresh,
    required this.refreshIndicatorKey,
    required this.slivers,
    this.controller,
  });

  final Future Function() onRefresh;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  final List<Widget> slivers;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? buildAndroidWidget() : buildIOSWidget();
  }

  Widget buildAndroidWidget() {
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: onRefresh,
      color: AppColors.primaryColor700,
      child: CustomScrollView(
        controller: controller,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: slivers,
      ),
    );
  }

  Widget buildIOSWidget() {
    return CustomScrollView(
      controller: controller,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        CupertinoSliverRefreshControl(
          refreshIndicatorExtent: 60,
          onRefresh: onRefresh,
          builder: (
            BuildContext context,
            RefreshIndicatorMode? refreshState,
            double pulledExtent,
            double refreshTriggerPullDistance,
            double refreshIndicatorExtent,
          ) {
            return Center(
              child: CupertinoActivityIndicator(
                color: AppColors.primaryColor700, // 👈 Change your color here
                radius: 14,
              ),
            );
          },
        ),
        ...slivers,
      ],
    );
  }
}

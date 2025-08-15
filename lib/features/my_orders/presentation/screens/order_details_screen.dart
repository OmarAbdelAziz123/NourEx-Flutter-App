import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/helper_functions/date_formate.dart';
import 'package:nourex/features/my_orders/business_logic/my_orders_cubit.dart';
import 'package:nourex/features/my_orders/data/models/my_orders_data_model.dart';
import 'package:nourex/features/products/data/models/product_data_model.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/divider/custom_divider_in_bottom_sheet.dart';
import 'package:nourex/features/my_orders/presentation/widgets/custom_container_in_order_details_to_connect_the_three_status_widget.dart';
import 'package:nourex/features/my_orders/presentation/widgets/custom_row_inn_container_order_details_widget.dart';
import 'package:nourex/features/my_orders/presentation/widgets/time_line_stage_widget.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.ordersList});

  final MyOrder ordersList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(74.h),
          child: MainAppBar2Widget(
            title: '${'orderNumber'.tr()} : ${ordersList.orderSeq}',
            isSubScreen: true,
            haveOnlyNotification: true,
            onTapBack: () {
              context.pop();
            },
            onTapNotification: () {},
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                18.verticalSpace,
                Text('executionSteps'.tr(), style: Styles.highlightEmphasis),
                12.verticalSpace,

                /// Status Timeline with IntrinsicHeight for better alignment
                ordersList.status == 'Cancelled'
                    ? Column(
                        children: [
                          /// First Stage
                          IntrinsicHeight(
                            child: Row(
                              spacing: 16.w,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      ordersList.status != 'Pending'
                                          ? 'assets/svgs/pending_icon1.svg'
                                          : 'assets/svgs/pending_icon2.svg',
                                    ),
                                    CustomContainerInOrderDetailsToConnectTheThreeStatusWidget(
                                      color: ordersList.status == 'Pending'
                                          ? AppColors.neutralColor300
                                          : null,
                                    ),
                                  ],
                                ),
                                TimelineStageWidget(
                                  stage: 'firstStep'.tr(),
                                  status: ordersList.status == 'Pending'
                                      ? 'pending'.tr()
                                      : 'completed'.tr(),
                                  description: 'firstStepDescription'.tr(),
                                  buttonText: ordersList.status == 'Pending'
                                      ? " جاري العمل عليه"
                                      : 'completed'.tr(),
                                  isCompleted: ordersList.status != 'Pending',
                                  inProgressColor:
                                      ordersList.status == 'Pending',
                                ),
                              ],
                            ),
                          ),

                          /// Second Stage
                          IntrinsicHeight(
                            child: Row(
                              spacing: 16.w,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      ordersList.status == 'Pending'
                                          ? 'assets/svgs/delevering_icon3.svg'
                                          : 'assets/svgs/cancelled_icon.svg',
                                    ),
                                  ],
                                ),
                                TimelineStageWidget(
                                  stage: 'rejectedd'.tr(),
                                  // status: 'secondStepDescription'.tr(),
                                  status: 'rejectedd'.tr(),
                                  description: 'thirdStep'.tr(),
                                  // buttonText: 'fourthStep'.tr(),
                                  buttonText: 'rejectedd'.tr(),
                                  isCancelled: true,
                                  isCompleted: ordersList.status == 'Cancelled',
                                  inProgressColor:
                                      ordersList.status == 'Cancelled',
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          /// First Stage
                          IntrinsicHeight(
                            child: Row(
                              spacing: 16.w,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      ordersList.status == 'Delivered'
                                          ? 'assets/svgs/pending_icon3.svg'
                                          : ordersList.status != 'Pending'
                                              ? 'assets/svgs/pending_icon1.svg'
                                              : 'assets/svgs/pending_icon2.svg',
                                    ),
                                    CustomContainerInOrderDetailsToConnectTheThreeStatusWidget(
                                      color: ordersList.status == 'Pending'
                                          ? AppColors.neutralColor300
                                          : null,
                                    ),
                                  ],
                                ),
                                TimelineStageWidget(
                                  stage: 'firstStep'.tr(),
                                  status: ordersList.status == 'Pending'
                                      ? 'pending'.tr()
                                      : 'completed'.tr(),
                                  description: 'firstStepDescription'.tr(),
                                  buttonText: ordersList.status == 'Pending'
                                      ? " جاري العمل عليه"
                                      : 'completed'.tr(),
                                  isCompleted: ordersList.status != 'Pending',
                                  inProgressColor:
                                      ordersList.status == 'Pending',
                                ),
                              ],
                            ),
                          ),

                          /// Second Stage
                          IntrinsicHeight(
                            child: Row(
                              spacing: 16.w,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      ordersList.status == 'Shipped'
                                          ? 'assets/svgs/delevering_icon3.svg'
                                          : ordersList.status == 'Delivered'
                                              ? 'assets/svgs/delevering_icon1.svg'
                                              : 'assets/svgs/delevering_icon2.svg',
                                    ),
                                    CustomContainerInOrderDetailsToConnectTheThreeStatusWidget(
                                      color: ordersList.status == 'Shipped'
                                          ? AppColors.neutralColor300
                                          : null,
                                    ),
                                  ],
                                ),
                                TimelineStageWidget(
                                  stage: 'secondStep'.tr(),
                                  // status: 'secondStepDescription'.tr(),
                                  status: ordersList.status == 'Shipped'
                                      ? 'shipped'.tr()
                                      : ordersList.status == 'Delivered'
                                          ? 'completed'.tr()
                                          : ordersList.status == 'Pending'
                                              ? 'pending'.tr()
                                              : 'cancelled'.tr(),
                                  description: 'thirdStep'.tr(),
                                  // buttonText: 'fourthStep'.tr(),
                                  buttonText: ordersList.status == 'Shipped'
                                      ? " جاري العمل عليه"
                                      : 'completed'.tr(),
                                  isCompleted: ordersList.status == 'Delivered',
                                  inProgressColor:
                                      ordersList.status == 'Shipped',
                                ),
                              ],
                            ),
                          ),

                          /// Third Stage
                          Row(
                            spacing: 16.w,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                ordersList.status == 'Delivered'
                                    ? 'assets/svgs/delevered_icon1.svg'
                                    : 'assets/svgs/delevered_icon2.svg',
                              ),
                              TimelineStageWidget(
                                stage: 'thirdStepDescription'.tr(),
                                status: ordersList.status == 'Delivered'
                                    ? 'delivered'.tr()
                                    : ordersList.status == 'Delivered'
                                        ? 'completed'.tr()
                                        : ordersList.status == 'Pending' ||
                                                ordersList.status == 'Shipped'
                                            ? 'pending'.tr()
                                            : 'cancelled'.tr(),
                                description: 'fourthStepDescription'.tr(),
                                // buttonText: 'fourthStep'.tr(),
                                buttonText: ordersList.status == 'Delivered'
                                    ? 'completed'.tr()
                                    : 'pending'.tr(),
                                isCompleted: ordersList.status == 'Delivered',
                                // Last step is never "completed"
                                inProgressColor:
                                    ordersList.status == 'Delivered',
                              ),
                            ],
                          ),
                        ],
                      ),

                /// Order Details
                24.verticalSpace,
                Text('productInfo'.tr(), style: Styles.highlightEmphasis),
                12.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.w,
                      color: AppColors.neutralColor600,
                    ),
                    borderRadius: BorderRadius.circular(
                      AppConstants.borderRadius + 4.r,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neutralColor600.withAlpha(1),
                        blurRadius: 60.r,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    spacing: 12.h,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 12.w, right: 12.w, top: 8.h),
                        child: CustomRowInContainerOrderDetailsWidget(
                          title: 'name'.tr(),
                          value: ordersList.user!.name!,
                        ),
                      ),
                      CustomDividerInBottomSheet(),
                      Padding(
                        padding: EdgeInsets.only(left: 12.w, right: 12.w),
                        child: CustomRowInContainerOrderDetailsWidget(
                          title: 'phone'.tr(),
                          value: ordersList.user!.phone!,
                        ),
                      ),
                      CustomDividerInBottomSheet(),
                      Padding(
                        padding: EdgeInsets.only(left: 12.w, right: 12.w),
                        child: CustomRowInContainerOrderDetailsWidget(
                          title: 'date'.tr(),
                          value: formatDate(ordersList.createdAt!),
                          // value: '19 ديسمبر 2024',
                        ),
                      ),
                      CustomDividerInBottomSheet(),
                      Padding(
                        padding: EdgeInsets.only(left: 12.w, right: 12.w),
                        child: CustomRowInContainerOrderDetailsWidget(
                          title: 'address2'.tr(),
                          value:
                              '${ordersList.address!.city!} - ${ordersList.address!.zone!} - ${ordersList.address!.street!}',
                        ),
                      ),
                      if (ordersList.address!.notes != null)
                        Column(
                          children: [
                            CustomDividerInBottomSheet(),
                            Padding(
                              padding: EdgeInsets.only(left: 12.w, right: 12.w),
                              child: CustomRowInContainerOrderDetailsWidget(
                                title: 'notes2'.tr(),
                                value: ordersList.address!.notes ?? '',
                              ),
                            ),
                          ],
                        ),
                      CustomDividerInBottomSheet(),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 12.w, right: 12.w, bottom: 8.h),
                        child: CustomRowInContainerOrderDetailsWidget(
                          title: '${'orderNumber2'.tr()}: ',
                          value: ordersList.orderSeq.toString(),
                        ),
                      ),
                    ],
                  ),
                ),
                18.verticalSpace,

                /// Order Products
                Text('products'.tr(), style: Styles.featureBold),
                12.verticalSpace,
                Container(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ordersList.products!.length,
                    itemBuilder: (context, index) {
                      // استخراج itemSeq الخاص بالـ product في الـ index المحدد
                      String? itemSeq;
                      if (ordersList.products![index].variants != null &&
                          ordersList.products![index].variants!.isNotEmpty) {
                        // أخذ itemSeq من الـ variant الخاص بهذا الـ product تحديداً
                        itemSeq =
                            ordersList.products![index].variants![0].itemSeq;
                      }

                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(Routes.productStatusScreen,
                              arguments: {
                                'orderId': ordersList.id,
                                'product': ordersList.products![index],
                                'itemSeq': itemSeq,
                              }
                              // arguments: ordersList.products![index],
                              );
                        },
                        child: CustomProductCardItemWidget(
                          isInHome: false,
                          product:
                              ProductModel.convertMyOrderProductToProductModel(
                            ordersList.products![index],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => 12.verticalSpace,
                  ),
                ),

                24.verticalSpace,
              ],
            ),
          ),
        ),
        bottomNavigationBar: BlocConsumer<MyOrdersCubit, MyOrdersState>(
          listener: (context, state) {
            if (state is MakeCancelOrderSuccessState ||
                state is MakeDeliveryOrderSuccessState) {
              context.pushNamedAndRemoveUntil(
                Routes.mainLayoutScreen,
                arguments: 2,
              );
            }
          },
          builder: (context, state) {
            final orderCubit = context.read<MyOrdersCubit>();

            return ordersList.status == 'Shipped'
                ? SafeArea(
                    child: CustomBottomNavBarMakeButtonOnly(
                      buttonTitle: 'delivered'.tr(),
                      onPressed: () {
                        orderCubit.makeDeliveryOrder(orderId: ordersList.id!);
                      },
                    ),
                  )
                : ordersList.status == 'Pending'
                    ? SafeArea(
                        child: CustomBottomNavBarMakeButtonOnly(
                          buttonTitle: 'cancelOrder'.tr(),
                          buttonColor: AppColors.redColor100,
                          onPressed: () {
                            orderCubit.makeCancelOrder(orderId: ordersList.id!);
                          },
                        ),
                      )
                    : ordersList.status == 'Cancelled'
                        ? SafeArea(
                            child: CustomBottomNavBarMakeButtonOnly(
                              buttonTitle: 'contactSupport'.tr(),
                              onPressed: () {},
                            ),
                          )
                        : ordersList.status == 'Delivered'
                            ? SafeArea(
                                child: CustomBottomNavBarMakeButtonOnly(
                                  buttonTitle: 'returnOrder'.tr(),
                                  onPressed: () {
                                    context.pushNamed(Routes.cancelOrderScreen,
                                        arguments: {
                                          'orderId': ordersList.id,
                                          'orderProducts': ordersList,
                                        });
                                  },
                                ),
                              )
                            : Container();
          },
        ));
  }
}

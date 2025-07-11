import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/app_router.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/features/my_orders/data/models/order_data_model.dart';
import 'package:nourex/features/my_orders/presentation/widgets/custom_order_container_widget.dart';

class PendingOrdersWidget extends StatelessWidget {
  const PendingOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersList = [
      OrderDataModel(
        orderNumber: '#123456',
        productNames: ['منتج 1', 'منتج 2', 'منتج 3'],
      ),
      OrderDataModel(
        orderNumber: '#123456',
        productNames: ['منتج 1', 'منتج 2', 'منتج 3'],
      ),
      OrderDataModel(
        orderNumber: '#123456',
        productNames: ['منتج 1', 'منتج 2', 'منتج 3'],
      ),
      OrderDataModel(
        orderNumber: '#123456',
        productNames: ['منتج 1', 'منتج 2', 'منتج 3'],
      ),
      OrderDataModel(
        orderNumber: '#123456',
        productNames: ['منتج 1', 'منتج 2', 'منتج 3'],
      ),
      OrderDataModel(
        orderNumber: '#123456',
        productNames: ['منتج 1', 'منتج 2', 'منتج 3'],
      ),
      OrderDataModel(
        orderNumber: '#123456',
        productNames: ['منتج 1', 'منتج 2', 'منتج 3'],
      ),
      OrderDataModel(
        orderNumber: '#123456',
        productNames: ['منتج 1', 'منتج 2', 'منتج 3'],
      ),
      OrderDataModel(
        orderNumber: '#123456',
        productNames: ['منتج 1', 'منتج 2', 'منتج 3'],
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          12.verticalSpace,
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: ordersList.length,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return 16.verticalSpace;
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.pushNamed(
                    Routes.orderDetailsScreen,
                  );
                },
                child: CustomOrderContainerWidget(
                  orderDataModel: ordersList[index],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

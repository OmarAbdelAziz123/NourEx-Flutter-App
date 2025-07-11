import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/features/support/data/models/solved_orders_data_model.dart';
import 'package:nourex/features/support/presentation/widgets/custom_ticket_container_widget.dart';

class SolvedWidget extends StatelessWidget {
  const SolvedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final solvedOrdersList = [
      SolvedOrdersDataModel(
        orderNumber: '#123456',
      ),
      SolvedOrdersDataModel(
        orderNumber: '#123456',
      ),
      SolvedOrdersDataModel(
        orderNumber: '#123456',
      ),
      SolvedOrdersDataModel(
        orderNumber: '#123456',
      ),
      SolvedOrdersDataModel(
        orderNumber: '#123456',
      ),
      SolvedOrdersDataModel(
        orderNumber: '#123456',
      ),
      SolvedOrdersDataModel(
        orderNumber: '#123456',
      ),
      SolvedOrdersDataModel(
        orderNumber: '#123456',
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          12.verticalSpace,
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: solvedOrdersList.length,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return 16.verticalSpace;
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.pushNamed(
                    Routes.supportDetailsScreenRoute,
                  );
                },
                child: CustomTicketContainerWidget(
                  solvedOrdersDataModel: solvedOrdersList[index],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
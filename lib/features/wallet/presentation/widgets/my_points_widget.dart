import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/components/wallet/custom_transactions_history_from_wallet_skeletonizer_widget.dart';
import 'package:nourex/components/wallet/custom_transactions_history_from_wallet_widget.dart';
import 'package:nourex/components/wallet/models/transactions_history_data_model.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/row/show_more_row_widget.dart';

class MyPointsWidget extends StatelessWidget {
  const MyPointsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionsHistoryList = [
      TransactionsHistoryDataModel(
        method: 'deposit',
        orderNumber: '987n30',
        date: '20 يونيو 2025',
        numberOfTransactions: '100+',
      ),
      TransactionsHistoryDataModel(
        method: 'to_withdraw',
        orderNumber: '4687m',
        date: '20 يونيو 2025',
        numberOfTransactions: '100+',
      ),
      TransactionsHistoryDataModel(
        method: 'deposit',
        orderNumber: '987n30',
        date: '20 يونيو 2025',
        numberOfTransactions: '100+',
      ),
      TransactionsHistoryDataModel(
        method: 'deposit',
        orderNumber: '987n30',
        date: '20 يونيو 2025',
        numberOfTransactions: '100+',
      ),
      TransactionsHistoryDataModel(
        method: 'to_withdraw',
        orderNumber: '4687m',
        date: '20 يونيو 2025',
        numberOfTransactions: '100+',
      ),
      TransactionsHistoryDataModel(
        method: 'deposit',
        orderNumber: '987n30',
        date: '20 يونيو 2025',
        numberOfTransactions: '100+',
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          18.verticalSpace,

          /// My Balance
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 24.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius + 4.r),
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor700,
                  AppColors.primaryColor800,
                  AppColors.primaryColor800,
                  AppColors.primaryColor800,
                ],
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'نقاطك الحالي',
                    style: Styles.captionRegular.copyWith(
                      color: AppColors.neutralColor200,
                    ),
                  ),
                  12.verticalSpace,
                  Text(
                    '10000 ل.س',
                    style: Styles.heading1.copyWith(
                      color: AppColors.neutralColor100,
                    ),
                  ),
                ],
              ),
            ),
          ),

          18.verticalSpace,
          ShowMoreRowWidget(
            title: 'سجل المعاملاتً',
            onTapShowMore: () {},
          ),
          12.verticalSpace,
          /// My Points History
          /// Loading
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: transactionsHistoryList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: 12.h,
                ),
                child: CustomTransactionsHistoryFromWalletSkeletonizerWidget(),
              );
            },
          ),
          18.verticalSpace,
          /// Success
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: transactionsHistoryList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: 12.h,
                ),
                child: CustomTransactionsHistoryFromWalletWidget(
                  transactionsHistoryDataModel:
                  transactionsHistoryList[index],
                ),
              );
            },
          ),
          18.verticalSpace,
        ],
      ),
    );
  }
}

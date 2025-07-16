import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/features/wallet/data/models/transactions_history_data_model.dart';

class CustomTransactionsHistoryFromWalletWidget extends StatelessWidget {
  const CustomTransactionsHistoryFromWalletWidget({
    super.key,
    required this.transactionsHistoryDataModel,
  });

  final TransactionsHistoryDataModel transactionsHistoryDataModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius - 4.r,
        ),
        border: Border.all(
          width: 1.w,
          color: AppColors.neutralColor300,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8.w,
            children: [
              SvgPicture.asset(
                transactionsHistoryDataModel.method == 'deposit'
                    ? 'assets/svgs/deposit.svg'
                    : 'assets/svgs/to_withdraw.svg',
                fit: BoxFit.scaleDown,
              ),
              Column(
                spacing: 8.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactionsHistoryDataModel.orderNumber,
                    style: Styles.highlightEmphasis,
                  ),
                  Text(
                    transactionsHistoryDataModel.date,
                    style: Styles.captionEmphasis,
                  ),
                ],
              ),
            ],
          ),
          Text(
            transactionsHistoryDataModel.numberOfTransactions,
            style: Styles.highlightBold.copyWith(
              color: transactionsHistoryDataModel.method == 'deposit'
                  ? AppColors.greenColor200
                  : AppColors.redColor100,
            ),
          )
        ],
      ),
    );
  }
}

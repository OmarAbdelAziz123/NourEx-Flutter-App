import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/features/wallet/data/models/wallet_data_model.dart';

class CustomTransactionsHistoryInPointsFromWalletWidget extends StatelessWidget {
  const CustomTransactionsHistoryInPointsFromWalletWidget({
    super.key,
    required this.transactionsHistoryDataModel,
  });

  final WalletTransaction transactionsHistoryDataModel;

  String _formattedDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final parsed = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd HH:mm').format(parsed);
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDeposit =
        transactionsHistoryDataModel.type?.toLowerCase() != 'redeem';

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
          SvgPicture.asset(
            isDeposit
                ? 'assets/svgs/deposit.svg'
                : 'assets/svgs/to_withdraw.svg',
            fit: BoxFit.scaleDown,
          ),
          8.horizontalSpace,
          Expanded(
            child: Column(
              spacing: 8.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transactionsHistoryDataModel.description ?? '---',
                  style: Styles.highlightEmphasis,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  _formattedDate(transactionsHistoryDataModel.createdAt),
                  style: Styles.captionEmphasis,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Text(
            '${isDeposit ? '+' : '-'}${transactionsHistoryDataModel.points?.toStringAsFixed(2) ?? '0.00'} Points',
            style: Styles.highlightBold.copyWith(
              color: isDeposit
                  ? AppColors.greenColor200
                  : AppColors.redColor100,
            ),
          )
        ],
      ),
    );
  }
}
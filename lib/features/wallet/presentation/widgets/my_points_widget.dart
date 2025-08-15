import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/services/di/di.dart';
import 'package:nourex/features/wallet/data/models/transactions_history_data_model.dart';
import 'package:nourex/features/wallet/presentation/widgets/custom_transactions_history_from_wallet_skeletonizer_widget.dart';
import 'package:nourex/features/wallet/presentation/widgets/custom_transactions_history_balance_from_wallet_widget.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/row/show_more_row_widget.dart';
import 'package:nourex/features/wallet/presentation/widgets/custom_transactions_history_points_from_wallet_widget.dart';

import '../../business_logic/wallet_cubit.dart';

class MyPointsWidget extends StatelessWidget {
  const MyPointsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletCubit(getIt())..getWalletHistory(type: 'points'),
      child: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          final cubit = context.read<WalletCubit>();

          return SingleChildScrollView(
            child: Column(
              children: [
                18.verticalSpace,

                /// My Balance
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 24.sp),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(AppConstants.borderRadius + 4.r),
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
                          'myCurrentPoints'.tr(),
                          style: Styles.captionRegular.copyWith(
                            color: AppColors.neutralColor200,
                          ),
                        ),
                        12.verticalSpace,
                        Text(
                          '${cubit.walletDataModel?.points  ?? '0.00'} ',
                          style: Styles.heading1.copyWith(
                            color: AppColors.neutralColor100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                18.verticalSpace,
                Row(
                  children: [
                    Text(
                      'transactions'.tr(),
                      style: Styles.featureBold.copyWith(
                        color: AppColors.neutralColor1000,
                      ),
                    ),
                  ],
                ),
                12.verticalSpace,

                /// My Points History
                /// Loading
                cubit.walletDataModel == null ||
                    cubit.walletDataModel?.transactions?.isEmpty == true
                    ? ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 12.h,
                      ),
                      child:
                      CustomTransactionsHistoryFromWalletSkeletonizerWidget(),
                    );
                  },
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cubit.walletDataModel?.transactions?.length,
                  itemBuilder: (context, index) {
                    final transactionsHistoryList =
                        cubit.walletDataModel?.transactions ?? [];

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 12.h,
                      ),
                      child: CustomTransactionsHistoryInPointsFromWalletWidget(
                        transactionsHistoryDataModel:
                        transactionsHistoryList[index],
                      ),
                    );
                  },
                ),

                18.verticalSpace,

                /// Success

                18.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}

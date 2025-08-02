import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/services/di/di.dart';
import 'package:nourex/features/wallet/business_logic/wallet_cubit.dart';
import 'package:nourex/features/wallet/presentation/widgets/custom_transactions_history_from_wallet_skeletonizer_widget.dart';
import 'package:nourex/features/wallet/presentation/widgets/custom_transactions_history_balance_from_wallet_widget.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';

class MyBalanceWidget extends StatelessWidget {
  const MyBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletCubit(getIt())..getWalletHistory(type: 'balance'),
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
                    borderRadius: BorderRadius.circular(
                        AppConstants.borderRadius + 4.r),
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
                          'balance2'.tr(),
                          style: Styles.captionRegular.copyWith(
                            color: AppColors.neutralColor200,
                          ),
                        ),
                        12.verticalSpace,
                        Text(
                          '${cubit.walletDataModel?.balance} ${'currency'
                              .tr()}',
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
                cubit.walletDataModel?.transactions == []
                    ? Center(
                  child: Text(
                    'noTransactions'.tr(),
                    style: Styles.highlightSemiBold.copyWith(
                      color: AppColors.neutralColor400,
                    ),
                  ),
                )
                    :
                cubit.walletDataModel == null ||
                    cubit.walletDataModel?.transactions?.isEmpty == true ?
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 12.h,
                      ),
                      child: CustomTransactionsHistoryFromWalletSkeletonizerWidget(),
                    );
                  },
                ) : ListView.builder(
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
                      child: CustomTransactionsHistoryInBalanceFromWalletWidget(
                        transactionsHistoryDataModel:
                        transactionsHistoryList[index],
                      ),
                    );
                  },
                ),
                // 18.verticalSpace,

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

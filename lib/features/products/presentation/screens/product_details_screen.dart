import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_shared_bottom_sheet_review.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:nourex/core/widgets/drop_down/custom_drop_down_menu_widget.dart';
import 'package:nourex/core/widgets/text/custom_text_rich_widget.dart';
import 'package:nourex/features/products/business_logic/products_cubit.dart';
import 'package:nourex/features/products/data/models/product_details_model.dart';
import 'package:nourex/features/products/data/models/variant_option.dart';
import 'package:nourex/features/products/presentation/widgets/custom_variant_column_widget.dart';
import 'package:nourex/features/profile/presentation/widgets/review_item_widget.dart';
import 'package:share_plus/share_plus.dart';

// class ProductDetailsScreen extends StatefulWidget {
//   const ProductDetailsScreen({super.key, required this.productId});

//   final String productId;

//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   String? selectedColor;
//   String? selectedSize;

//   List<VariantOption>? colorOptions;
//   List<VariantOption>? sizeOptions;

//   bool isButtonClicked = false;
//   Map<String, String?> selectedVariants = {};

//   @override
//   void initState() {
//     super.initState();
//   }

//   List<VariantOption> _generateVariantOptions(
//       List<String?> values, String variantType) {
//     return values.where((value) => value != null).map((value) {
//       return VariantOption(
//         id: value!,
//         label: value,
//         color: variantType.toLowerCase() == 'colors' ||
//                 variantType.toLowerCase() == 'الألوان'
//             ? _getColorFromString(value)
//             : null,
//         isAvailable: true,
//       );
//     }).toList();
//   }

//   Color? _getColorFromString(String colorName) {
//     switch (colorName.toLowerCase()) {
//       case 'أسود':
//       case 'black':
//         return Colors.black;
//       case 'أحمر':
//       case 'red':
//         return Colors.red;
//       case 'بني':
//       case 'brown':
//         return Colors.brown;
//       case 'أصفر':
//       case 'yellow':
//         return Colors.yellow;
//       case 'رمادي':
//       case 'grey':
//       case 'gray':
//         return Colors.grey;
//       case 'أبيض':
//       case 'white':
//         return Colors.white;
//       case 'أزرق':
//       case 'blue':
//         return Colors.blue;
//       case 'أخضر':
//       case 'green':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }

//   Future<void> _fetchVariantBasedOnSelection() async {
//     await context
//         .read<ProductsCubit>()
//         .fetchVariantByAttributes(selectedVariants);
//   }

//   Map<String, List<String>> buildVariantMap(Result product) {
//     final variantMap = <String, Set<String>>{};

//     for (var variant in product.variants ?? []) {
//       for (var attr in variant.attributes ?? []) {
//         variantMap.putIfAbsent(attr.name, () => {}).add(attr.value ?? '');
//       }
//     }

//     return variantMap.map((key, value) =>
//         MapEntry(key, value.where((v) => v.isNotEmpty).toList()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isArabic = Localizations.localeOf(context).languageCode == 'ar';
//     num? price;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(74.h),
//         child: MainAppBar2Widget(
//           title: 'تيشرت بولو',
//           isSubScreen: true,
//           haveOnlyNotification: false,
//           onTapBack: () {
//             context.pop();
//           },
//           onTapSearch: () {},
//         ),
//       ),
//       body: BlocBuilder<ProductsCubit, ProductsState>(
//         builder: (context, state) {
//           final cubit = context.read<ProductsCubit>();
//           final productDetails = cubit.productDetailsModel?.result;
//           final subImages = productDetails?.subImages ?? [];
//           final variantsMap =
//               cubit.productDetailsModel?.result?.addInvariantsMap() ?? {};

//           print('----------------');
//           print(cubit.productDetailsModel?.result?.addInvariantsMap());
//           print('----------------');

//           return state is GetProductByIdLoadingState ||
//                   cubit.productDetailsModel == null
//               ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       18.verticalSpace,
//                       Padding(
//                         padding: EdgeInsets.only(left: 18.w, right: 18.w),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             AnimatedSwitcher(
//                               duration: const Duration(milliseconds: 400),
//                               child: InteractiveViewer(
//                                 key: ValueKey(
//                                     productDetails?.mainImageURL ?? ''),
//                                 panEnabled: true,
//                                 scaleEnabled: true,
//                                 minScale: 1.0,
//                                 maxScale: 4.0,
//                                 child: CacheNetworkImagesWidget(
//                                   image: productDetails?.mainImageURL ?? '',
//                                   width: double.infinity,
//                                   height: 249.h,
//                                   boxFit: BoxFit.fill,
//                                   borderRadius: 10.r,
//                                 ),
//                               ),
//                             ),
//                             12.verticalSpace,
//                             productDetails?.subImages != null
//                                 ? SizedBox.shrink()
//                                 : Container(
//                                     width: double.infinity,
//                                     height: 60.h,
//                                     padding:
//                                         EdgeInsets.only(top: 8.h, bottom: 8.h),
//                                     decoration: BoxDecoration(
//                                       color: Colors.transparent,
//                                       border: Border.all(
//                                         color: AppColors.neutralColor300,
//                                         width: 1.w,
//                                       ),
//                                       borderRadius: BorderRadius.circular(
//                                         AppConstants.borderRadius + 4.r,
//                                       ),
//                                     ),
//                                     child: SingleChildScrollView(
//                                       scrollDirection: Axis.horizontal,
//                                       child: Row(
//                                         children: List.generate(
//                                             subImages.length ?? 0, (index) {
//                                           final image = subImages[index];

//                                           return GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 productDetails?.mainImageURL =
//                                                     image;
//                                               });
//                                             },
//                                             child: Container(
//                                               margin: EdgeInsets.symmetric(
//                                                   horizontal: 8.w),
//                                               padding: EdgeInsets.all(2.sp),
//                                               decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                   color: image ==
//                                                           productDetails
//                                                               ?.mainImageURL
//                                                       ? AppColors
//                                                           .primaryColor700
//                                                       : Colors.transparent,
//                                                   width: 1.5.w,
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                   AppConstants.borderRadius -
//                                                       2.r,
//                                                 ),
//                                               ),
//                                               child: CacheNetworkImagesWidget(
//                                                 image: image,
//                                                 width: 62.w,
//                                                 height: 41.h,
//                                                 borderRadius: 9.r,
//                                                 boxFit: BoxFit.fill,
//                                               ),
//                                             ),
//                                           );
//                                         }),
//                                       ),
//                                     ),
//                                   ),
//                             18.verticalSpace,
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       productDetails?.name ?? 'No Name',
//                                       style: Styles.captionRegular.copyWith(
//                                         color: AppColors.neutralColor600,
//                                       ),
//                                     ),
//                                     8.horizontalSpace,
//                                     Container(
//                                       padding: EdgeInsets.symmetric(
//                                         horizontal: 8.w,
//                                         vertical: 6.h,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: AppColors.secondaryColor500,
//                                         borderRadius: BorderRadius.circular(
//                                           AppConstants.borderRadius + 18.r,
//                                         ),
//                                       ),
//                                       child: Text(
//                                         '${productDetails?.stock.toString()} متبقي',
//                                         style: Styles.captionEmphasis.copyWith(
//                                           color: AppColors.neutralColor100,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   spacing: 12.w,
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         showModalBottomSheet(
//                                           context: context,
//                                           isScrollControlled: true,
//                                           builder: (context) {
//                                             return CustomSharedBottomSheetReview(
//                                               title: 'التقييم',
//                                               nameOfFiled: 'قيّم هذا المنتج',
//                                               initialRating: 3.5,
//                                               hintText:
//                                                   'تقييمك يصنع الفرق! أخبرنا بتجربتك مع المنتج.',
//                                               isEdit: false,
//                                               buttonText1: 'تاكيد',
//                                               buttonText2: 'الغاء',
//                                               onRatingChanged: (rating) {
//                                                 print("New Rating: $rating");
//                                               },
//                                               commentController:
//                                                   TextEditingController(),
//                                               onEditPressed: () {},
//                                               onCancelPressed: () {
//                                                 Navigator.pop(context);
//                                               },
//                                             );
//                                           },
//                                         );
//                                       },
//                                       child: Text(
//                                         'تقييم المنتج',
//                                         style:
//                                             Styles.highlightSemiBold.copyWith(
//                                           color: AppColors.primaryColor700,
//                                           decoration: TextDecoration.underline,
//                                           decorationColor:
//                                               AppColors.primaryColor700,
//                                           decorationThickness: 1.5.w,
//                                         ),
//                                       ),
//                                     ),
//                                     SvgPicture.asset(
//                                       'assets/svgs/share_icon.svg',
//                                       fit: BoxFit.scaleDown,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             4.verticalSpace,
//                             Text(productDetails?.name ?? '',
//                                 style: Styles.featureSemiBold),
//                             4.verticalSpace,
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   spacing: 12.w,
//                                   children: [
//                                     CircleAvatar(
//                                       backgroundColor:
//                                           AppColors.neutralColor300,
//                                       radius: 13.r,
//                                     ),
//                                     Text(
//                                       cubit.productDetailsModel?.result?.name ??
//                                           '',
//                                       style: Styles.contentBold.copyWith(
//                                         color: AppColors.secondaryColor500,
//                                       ),
//                                     ),
//                                     SvgPicture.asset(
//                                       'assets/svgs/water_mark_icon.svg',
//                                       fit: BoxFit.scaleDown,
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       ' ${price ?? productDetails?.finalPrice} ${'currency'.tr()}',
//                                       style: Styles.heading4,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             18.verticalSpace,
//                             18.verticalSpace,
//                             ...[
//                               if (productDetails != null &&
//                                   productDetails.variants != null &&
//                                   productDetails.variants!.isNotEmpty)
//                                 Builder(
//                                   builder: (context) {
//                                     final variantMap =
//                                         buildVariantMap(productDetails);

//                                     return Container(
//                                       width: double.infinity,
//                                       padding: EdgeInsets.all(12.w),
//                                       decoration: BoxDecoration(
//                                         color: AppColors.neutralColor100,
//                                         borderRadius: BorderRadius.circular(
//                                             AppConstants.borderRadius),
//                                         border: Border.all(
//                                           color: AppColors.neutralColor300,
//                                           width: 1.w,
//                                         ),
//                                       ),
//                                       child: Column(
//                                         children:
//                                             variantMap.entries.map((entry) {
//                                           final variantType = entry.key;
//                                           final values = entry.value;
//                                           final options =
//                                               _generateVariantOptions(
//                                                   values, variantType);

//                                           return Column(
//                                             children: [
//                                               CustomVariantColumnWidget(
//                                                 variantName: variantType,
//                                                 options: options,
//                                                 isColored: variantType
//                                                         .toLowerCase()
//                                                         .contains('color') ||
//                                                     variantType
//                                                         .toLowerCase()
//                                                         .contains('لون'),
//                                                 selectedId: selectedVariants[
//                                                     variantType],
//                                               ),
//                                               if (entry !=
//                                                   variantMap.entries.last)
//                                                 16.verticalSpace,
//                                             ],
//                                           );
//                                         }).toList(),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                             ],
//                             18.verticalSpace,
//                             Container(
//                               width: double.infinity,
//                               padding: EdgeInsets.all(12.w),
//                               decoration: BoxDecoration(
//                                 color: AppColors.neutralColor100,
//                                 borderRadius: BorderRadius.circular(
//                                   AppConstants.borderRadius,
//                                 ),
//                                 border: Border.all(
//                                   color: AppColors.neutralColor300,
//                                   width: 1.w,
//                                 ),
//                               ),
//                               child: Column(
//                                 spacing: 8.h,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('الوصف',
//                                       style: Styles.highlightEmphasis),
//                                   Text(
//                                     productDetails?.description ?? '',
//                                     style: Styles.contentRegular.copyWith(
//                                       color: AppColors.neutralColor800,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             18.verticalSpace,
//                             Container(
//                               width: double.infinity,
//                               padding: EdgeInsets.all(12.w),
//                               decoration: BoxDecoration(
//                                 color: AppColors.neutralColor100,
//                                 borderRadius: BorderRadius.circular(
//                                   AppConstants.borderRadius,
//                                 ),
//                                 border: Border.all(
//                                   color: AppColors.neutralColor300,
//                                   width: 1.w,
//                                 ),
//                               ),
//                               child: Column(
//                                 spacing: 8.h,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       CustomRichText(
//                                         text1: 'productNumber'.tr(),
//                                         textStyle1: Styles.highlightEmphasis,
//                                         text2: productDetails?.sId ?? '',
//                                         textStyle2:
//                                             Styles.contentRegular.copyWith(
//                                           color: AppColors.neutralColor800,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             18.verticalSpace,
//                           ],
//                         ),
//                       ),
//                       ReviewItemWidget(
//                         reviewerName: 'ايه القحطاني',
//                         profileImagePath: 'assets/pngs/profile_image.png',
//                         reviewText:
//                             'الخدمة كانت رائعة جدًا! مقدم الخدمة محترف ووصل في الوقت المحدد. أنصح الجميع بالتعامل معه. شكرًا لتطبيق حرفة على التجربة الممتازة',
//                         timeAgo: 'منذ 6 ساعات',
//                         rating: 4.5,
//                         isArabic: true,
//                         moreIconButtonWidget: CustomDropDownMenuWidget(
//                           onSelected: (String value) {
//                             if (value == 'report'.tr()) {
//                               print('navigate to report screen');
//                             } else if (value == 'editReview'.tr()) {
//                               print('navigate to edit review screen');
//                             } else if (value == 'deleteReview'.tr()) {
//                               print('delete review');
//                             }
//                           },
//                           menuItems: [
//                             {
//                               'title': 'report'.tr(),
//                               'icon': Icons.report_outlined
//                             },
//                             {'title': 'editReview'.tr(), 'icon': Iconsax.edit},
//                             {
//                               'title': 'deleteReview'.tr(),
//                               'icon': Iconsax.trash
//                             },
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//         },
//       ),
//       bottomNavigationBar: CustomBottomNavBarMakeButtonOnly(
//         buttonTitle: 'addToCart'.tr(),
//         onPressed: () {},
//       ),
//     );
//   }
// }

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? selectedColor;
  String? selectedSize;

  List<VariantOption>? colorOptions;
  List<VariantOption>? sizeOptions;

  bool isButtonClicked = false;
  Map<String, String?> selectedVariants = {};

  num? price;

  @override
  void initState() {
    super.initState();
  }

  List<VariantOption> _generateVariantOptions(
      List<String?> values, String variantType) {
    return values.where((value) => value != null).map((value) {
      return VariantOption(
        id: value!,
        label: value,
        color: variantType.toLowerCase() == 'colors' ||
                variantType.toLowerCase() == 'الألوان'
            ? _getColorFromString(value)
            : null,
        isAvailable: true,
      );
    }).toList();
  }

  Color? _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'أسود':
      case 'black':
        return Colors.black;
      case 'أحمر':
      case 'red':
        return Colors.red;
      case 'بني':
      case 'brown':
        return Colors.brown;
      case 'أصفر':
      case 'yellow':
        return Colors.yellow;
      case 'رمادي':
      case 'grey':
      case 'gray':
        return Colors.grey;
      case 'أبيض':
      case 'white':
        return Colors.white;
      case 'أزرق':
      case 'blue':
        return Colors.blue;
      case 'أخضر':
      case 'green':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Map<String, List<String>> buildVariantMap(Result product) {
    final variantMap = <String, Set<String>>{};

    for (var variant in product.variants ?? []) {
      for (var attr in variant.attributes ?? []) {
        variantMap.putIfAbsent(attr.name, () => {}).add(attr.value ?? '');
      }
    }

    return variantMap.map((key, value) =>
        MapEntry(key, value.where((v) => v.isNotEmpty).toList()));
  }

  void _updatePriceBasedOnVariant() {
    final product = context.read<ProductsCubit>().productDetailsModel?.result;
    if (product == null) return;

    for (var variant in product.variants ?? []) {
      bool isMatch = true;

      for (var attr in variant.attributes ?? []) {
        final selectedValue = selectedVariants[attr.name];
        if (selectedValue == null || selectedValue != attr.value) {
          isMatch = false;
          break;
        }
      }

      if (isMatch) {
        setState(() {
          // price = variant.priceAfterDiscount;
          price = variant.price;
        });
        return;
      }
    }

    // Fallback to default
    setState(() {
      price = product.finalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'تيشرت بولو',
          isSubScreen: true,
          haveOnlyNotification: false,
          onTapBack: () {
            context.pop();
          },
          onTapSearch: () {},
        ),
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          final cubit = context.read<ProductsCubit>();
          final productDetails = cubit.productDetailsModel?.result;
          final subImages = productDetails?.subImages ?? [];

          final variantsMap =
              cubit.productDetailsModel?.result?.addInvariantsMap() ?? {};

          return state is GetProductByIdLoadingState ||
                  cubit.productDetailsModel == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      18.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image and Sub Images
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 400),
                              child: InteractiveViewer(
                                key: ValueKey(
                                    productDetails?.mainImageURL ?? ''),
                                panEnabled: true,
                                scaleEnabled: true,
                                minScale: 1.0,
                                maxScale: 4.0,
                                child: CacheNetworkImagesWidget(
                                  image: productDetails?.mainImageURL ?? '',
                                  width: double.infinity,
                                  height: 249.h,
                                  boxFit: BoxFit.fill,
                                  borderRadius: 10.r,
                                ),
                              ),
                            ),
                            12.verticalSpace,
                            if (subImages.isNotEmpty)
                              Container(
                                width: double.infinity,
                                height: 60.h,
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: AppColors.neutralColor300,
                                    width: 1.w,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.borderRadius + 4.r,
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(subImages.length,
                                        (index) {
                                      final image = subImages[index];
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            productDetails?.mainImageURL =
                                                image;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          padding: EdgeInsets.all(2.sp),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: image ==
                                                      productDetails
                                                          ?.mainImageURL
                                                  ? AppColors.primaryColor700
                                                  : Colors.transparent,
                                              width: 1.5.w,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              AppConstants.borderRadius - 2.r,
                                            ),
                                          ),
                                          child: CacheNetworkImagesWidget(
                                            image: image,
                                            width: 62.w,
                                            height: 41.h,
                                            borderRadius: 9.r,
                                            boxFit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            18.verticalSpace,

                            // Product name & stock
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      productDetails?.name ?? 'No Name',
                                      style: Styles.captionRegular.copyWith(
                                        color: AppColors.neutralColor600,
                                      ),
                                    ),
                                    8.horizontalSpace,
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 6.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.secondaryColor500,
                                        borderRadius: BorderRadius.circular(
                                            AppConstants.borderRadius + 18.r),
                                      ),
                                      child: Text(
                                        '${productDetails?.stock.toString()} متبقي',
                                        style: Styles.captionEmphasis.copyWith(
                                          color: AppColors.neutralColor100,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: 12.w,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return CustomSharedBottomSheetReview(
                                              title: 'التقييم',
                                              nameOfFiled: 'قيّم هذا المنتج',
                                              initialRating: 3.5,
                                              hintText:
                                                  'تقييمك يصنع الفرق! أخبرنا بتجربتك مع المنتج.',
                                              isEdit: false,
                                              buttonText1: 'تاكيد',
                                              buttonText2: 'الغاء',
                                              onRatingChanged: (rating) {},
                                              commentController:
                                                  TextEditingController(),
                                              onEditPressed: () {},
                                              onCancelPressed: () {
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        'تقييم المنتج',
                                        style:
                                            Styles.highlightSemiBold.copyWith(
                                          color: AppColors.primaryColor700,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              AppColors.primaryColor700,
                                          decorationThickness: 1.5.w,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        final productName =
                                            productDetails?.name ?? '';
                                        final productDesc =
                                            AppConstants.removeHtmlTags(
                                                productDetails?.description ??
                                                    '');
                                        final productLink =
                                            "https://noorex-dashboard.vercel.app/products/1";
                                            // "https://noorex-dashboard.vercel.app/products/${productDetails?.sId}"; // Replace with actual product link

                                        final shareText = '''
$productName

$productDesc

رابط المنتج:
$productLink
''';

                                        Share.share(shareText);
                                      },
                                      child: SvgPicture.asset(
                                        'assets/svgs/share_icon.svg',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            4.verticalSpace,

                            // Final Product Name
                            Text(productDetails?.name ?? '',
                                style: Styles.featureSemiBold),
                            4.verticalSpace,

                            // Brand and Price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: 12.w,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          AppColors.neutralColor300,
                                      radius: 13.r,
                                    ),
                                    Text(
                                      productDetails?.name ?? '',
                                      style: Styles.contentBold.copyWith(
                                        color: AppColors.secondaryColor500,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      'assets/svgs/water_mark_icon.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ],
                                ),
                                Text(
                                  ' ${price ?? productDetails?.finalPrice} ${'currency'.tr()}',
                                  style: Styles.heading4,
                                ),
                              ],
                            ),

                            18.verticalSpace,

                            // Variants
                            if (productDetails?.variants != null &&
                                productDetails!.variants!.isNotEmpty)
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: AppColors.neutralColor100,
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.borderRadius),
                                  border: Border.all(
                                    color: AppColors.neutralColor300,
                                    width: 1.w,
                                  ),
                                ),
                                child: Column(
                                  children: variantsMap.entries.map((entry) {
                                    final variantType = entry.key;
                                    final values = entry.value;
                                    final options = _generateVariantOptions(
                                        values, variantType);

                                    return Column(
                                      children: [
                                        CustomVariantColumnWidget(
                                          variantName: variantType,
                                          options: options,
                                          isColored: variantType
                                                  .toLowerCase()
                                                  .contains('color') ||
                                              variantType
                                                  .toLowerCase()
                                                  .contains('لون'),
                                          selectedId:
                                              selectedVariants[variantType],
                                          onSelect: (type, value) {
                                            setState(() {
                                              selectedVariants[type] = value;
                                              _updatePriceBasedOnVariant(); // Price update
                                            });
                                          },
                                        ),
                                        if (entry != variantsMap.entries.last)
                                          16.verticalSpace,
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),

                            18.verticalSpace,

                            // Description
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: AppColors.neutralColor100,
                                borderRadius: BorderRadius.circular(
                                    AppConstants.borderRadius),
                                border: Border.all(
                                  color: AppColors.neutralColor300,
                                  width: 1.w,
                                ),
                              ),
                              child: Column(
                                spacing: 8.h,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('الوصف',
                                      style: Styles.highlightEmphasis),
                                  Text(
                                    AppConstants.removeHtmlTags(
                                        productDetails?.description ?? ''),
                                    style: Styles.contentRegular.copyWith(
                                      color: AppColors.neutralColor800,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            18.verticalSpace,

                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: AppColors.neutralColor100,
                                borderRadius: BorderRadius.circular(
                                  AppConstants.borderRadius,
                                ),
                                border: Border.all(
                                  color: AppColors.neutralColor300,
                                  width: 1.w,
                                ),
                              ),
                              child: Column(
                                spacing: 8.h,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CustomRichText(
                                        text1: 'productNumber'.tr(),
                                        textStyle1: Styles.highlightEmphasis,
                                        text2: productDetails?.sId ?? '',
                                        textStyle2:
                                            Styles.contentRegular.copyWith(
                                          color: AppColors.neutralColor800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            18.verticalSpace,
                          ],
                        ),
                      ),

                      // Sample review
                      ReviewItemWidget(
                        reviewerName: 'ايه القحطاني',
                        profileImagePath: 'assets/pngs/profile_image.png',
                        reviewText:
                            'الخدمة كانت رائعة جدًا! مقدم الخدمة محترف ووصل في الوقت المحدد. أنصح الجميع بالتعامل معه. شكرًا لتطبيق حرفة على التجربة الممتازة',
                        timeAgo: 'منذ 6 ساعات',
                        rating: 4.5,
                        isArabic: true,
                        moreIconButtonWidget: CustomDropDownMenuWidget(
                          onSelected: (String value) {
                            // handle review actions
                          },
                          menuItems: [
                            {
                              'title': 'report'.tr(),
                              'icon': Icons.report_outlined
                            },
                            {'title': 'editReview'.tr(), 'icon': Iconsax.edit},
                            {
                              'title': 'deleteReview'.tr(),
                              'icon': Iconsax.trash
                            },
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
      bottomNavigationBar: CustomBottomNavBarMakeButtonOnly(
        buttonTitle: 'addToCart'.tr(),
        onPressed: () {},
      ),
    );
  }
}

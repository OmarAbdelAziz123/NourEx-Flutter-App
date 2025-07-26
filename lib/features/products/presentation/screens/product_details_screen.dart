import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nourex/core/widgets/drop_down/custom_drop_down_menu_widget.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_shared_bottom_sheet_review.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:nourex/core/widgets/container/custom_rating_filter_item_widget.dart';
import 'package:nourex/core/widgets/row/show_more_row_widget.dart';
import 'package:nourex/core/widgets/text/custom_text_rich_widget.dart';
import 'package:nourex/features/products/business_logic/products_cubit.dart';
import 'package:nourex/features/products/data/models/product_details_model.dart';
import 'package:nourex/features/products/data/models/variant_option.dart';
import 'package:nourex/features/products/presentation/widgets/custom_variant_column_widget.dart';
import 'package:nourex/features/profile/presentation/widgets/review_item_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? selectedColor;
  String? selectedSize;

  final List<VariantOption> colorOptions = [
    VariantOption(id: '1', label: 'أسود', color: Colors.black),
    VariantOption(id: '2', label: 'أحمر', color: Colors.red),
    VariantOption(id: '3', label: 'بني', color: Colors.brown),
    VariantOption(id: '4', label: 'أصفر', color: Colors.yellow),
    VariantOption(
      id: '5',
      label: 'رمادي',
      color: Colors.grey,
      isAvailable: false,
    ),
  ];

  final List<VariantOption> sizeOptions = [
    VariantOption(id: 's', label: 'S'),
    VariantOption(id: 'm', label: 'M'),
    VariantOption(id: 'l', label: 'L'),
    VariantOption(id: 'xl', label: 'XL'),
    VariantOption(id: 'xxl', label: 'XXL'),
  ];

  late String selectedImage;
  bool isButtonClicked = false;
  final imagesList = [
    'assets/svgs/shirt2.png',
    'assets/pngs/shirt3.png',
    'assets/pngs/shirt4.png',
    'assets/pngs/shirt5.png',
    'assets/pngs/shirt6.png',
  ];

  ProductDetailsModel? productDetailsModel;

  @override
  void initState() {
    super.initState();
    selectedImage = imagesList[0];
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
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
          print('----------------');
          print(cubit.productDetailsModel?.result?.addInvariantsMap());
          print('----------------');

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                18.verticalSpace,

                Padding(
                  padding: EdgeInsets.only(left: 18.w, right: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Main Image
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: InteractiveViewer(
                          key: ValueKey(selectedImage),
                          // ensures switch animation still works
                          panEnabled: true,
                          scaleEnabled: true,
                          minScale: 1.0,
                          maxScale: 4.0,
                          child: CacheNetworkImagesWidget(
                            image: selectedImage,
                            width: double.infinity,
                            height: 249.h,
                            boxFit: BoxFit.fill,
                            borderRadius: 10.r,
                          ),
                        ),
                      ),

                      12.verticalSpace,

                      /// Images Row
                      Container(
                        width: double.infinity,
                        height: 60.h,
                        // margin: EdgeInsets.only(left: 18.w, right: 18.w),
                        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
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
                            children: List.generate(imagesList.length, (index) {
                              final image = imagesList[index];

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedImage = image;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                                  padding: EdgeInsets.all(2.sp),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          image == selectedImage
                                              ? AppColors.primaryColor700
                                              : Colors.transparent,
                                      width: 1.5.w,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      AppConstants.borderRadius - 2.r,
                                    ),
                                  ),
                                  child: CacheNetworkImagesWidget(
                                    image: imagesList[index],
                                    width: 62.w,
                                    height: 41.h,
                                    boxFit: BoxFit.fill,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      18.verticalSpace,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'تيشرت بولو',
                                style: Styles.captionRegular.copyWith(
                                  color: AppColors.neutralColor600,
                                ),
                              ),
                              8.horizontalSpace,
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryColor500,
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.borderRadius + 18.r,
                                  ),
                                ),
                                child: Text(
                                  '12 متبقي',
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
                                  /// Make Review
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
                                        onRatingChanged: (rating) {
                                          print("New Rating: $rating");
                                        },
                                        commentController:
                                            TextEditingController(),
                                        // commentController: _commentController,
                                        onEditPressed: () {
                                          // print("Edited: ${_commentController.text}");
                                        },
                                        onCancelPressed: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  'تقييم المنتج',
                                  style: Styles.highlightSemiBold.copyWith(
                                    color: AppColors.primaryColor700,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primaryColor700,
                                    decorationThickness: 1.5.w,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/svgs/share_icon.svg',
                                fit: BoxFit.scaleDown,
                              ),
                            ],
                          ),
                        ],
                      ),
                      4.verticalSpace,

                      Text('تيشرت بولو', style: Styles.featureSemiBold),
                      4.verticalSpace,

                      /// Vendor Name - Product Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 12.w,
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.neutralColor300,
                                radius: 13.r,
                              ),
                              Text(
                                'عمر عبدالعزيز',
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
                            '6933399 ${'currency'.tr()}',
                            style: Styles.heading4,
                          ),
                        ],
                      ),
                      18.verticalSpace,

                      /// Variants
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
                          children: [
                            CustomVariantColumnWidget(
                              variantName: 'الألوان',
                              options: colorOptions,
                              isColored: true,
                              selectedId: selectedColor,
                              onSelectionChanged: (id) {
                                setState(() {
                                  selectedColor = id;
                                });
                                print('Selected color: $id');
                              },
                            ),
                            16.verticalSpace,
                            CustomVariantColumnWidget(
                              variantName: 'الحجم',
                              options: sizeOptions,
                              selectedId: selectedSize,
                              onSelectionChanged: (id) {
                                setState(() {
                                  selectedSize = id;
                                });
                                print('Selected size: $id');
                              },
                            ),
                          ],
                        ),
                      ),
                      18.verticalSpace,

                      /// Description
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
                            Text('الوصف', style: Styles.highlightEmphasis),
                            Text(
                              'دلّلي بشرتك برذاذ GlowMist المنعش!  تركيبة خفيفة وغنية بحمض الهيالورونيك وفيتامين E تمنحك ترطيبًا فوريًا ولمعانًا طبيعيًا يدوم طوال اليوم.  مثالي للاستخدام قبل المكياج أو أثناء اليوم لتجديد الحيوية.',
                              style: Styles.contentRegular.copyWith(
                                color: AppColors.neutralColor800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      18.verticalSpace,

                      /// Product Number
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
                                  text2: '0102102',
                                  textStyle2: Styles.contentRegular.copyWith(
                                    color: AppColors.neutralColor800,
                                  ),
                                ),
                              ],
                            ),
                            // Text(
                            //   'الوصف',
                            //   style: Styles.highlightEmphasis,
                            // ),
                          ],
                        ),
                      ),
                      18.verticalSpace,
                    ],
                  ),
                ),

                /// Similar Products
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 12.w),
                //   child: ShowMoreRowWidget(
                //     title: 'relatedProducts'.tr(),
                //     onTapShowMore: () {},
                //   ),
                // ),
                // 12.verticalSpace,
                // SizedBox(
                //   height: 124.h,
                //   child: ListView.builder(
                //     itemCount: 2,
                //     shrinkWrap: true,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (context, index) {
                //       return Container(
                //         margin: EdgeInsets.only(
                //           right: index == 0 ? 18.w : 0,
                //           left: index == products.length - 1 ? 18.w : 12.w,
                //         ),
                //         child: GestureDetector(
                //           onTap: () {
                //             context.pushNamed(Routes.productDetailsScreen);
                //           },
                //           child: CustomProductCardItemWidget(
                //             product: products[index],
                //           ),
                //         ),
                //         // child: CustomProductCardItemSkeletonizerWidget(),
                //       );
                //     },
                //   ),
                // ),
                // 18.verticalSpace,

                /// Related Products
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: ShowMoreRowWidget(
                    isRate: true,
                    avgRate: '4.5',
                    totalOfRate: '4,479',
                    onTapShowMore: () {},
                  ),
                ),
                16.verticalSpace,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      18.horizontalSpace,

                      BlocBuilder<ProductsCubit, ProductsState>(
                        buildWhen:
                            (previous, current) =>
                                current is ToggleSelectedRating,
                        builder: (context, state) {
                          final selected =
                              context.read<ProductsCubit>().selectedRating;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /// زر "الكل"
                              Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: InkWell(
                                  onTap:
                                      () => context
                                          .read<ProductsCubit>()
                                          .toggleRating(0),
                                  borderRadius: BorderRadius.circular(40.r),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          selected == 0
                                              ? AppColors.primaryColor700
                                              : Colors.white,
                                      border: Border.all(
                                        color: AppColors.primaryColor700,
                                      ),
                                      borderRadius: BorderRadius.circular(40.r),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'الكل',
                                          style: Styles.contentEmphasis
                                              .copyWith(
                                                color:
                                                    selected == 0
                                                        ? Colors.white
                                                        : AppColors
                                                            .primaryColor700,
                                              ),
                                        ),
                                        4.horizontalSpace,
                                        Icon(
                                          Icons.star,
                                          size: 18.sp,
                                          color:
                                              selected == 0
                                                  ? Colors.white
                                                  : AppColors.primaryColor700,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              ...List.generate(5, (index) {
                                final rating = index + 1;

                                return CustomRatingFilterItem(
                                  rating: rating,
                                  selectedRating: selected,
                                  onTap:
                                      () => context
                                          .read<ProductsCubit>()
                                          .toggleRating(rating),
                                  selectedColor: AppColors.primaryColor700,
                                  unselectedColor: Colors.white,
                                  selectedTextStyle: Styles.contentEmphasis
                                      .copyWith(color: Colors.white),
                                  unselectedTextStyle: Styles.contentEmphasis
                                      .copyWith(
                                        color: AppColors.primaryColor700,
                                      ),
                                );
                              }),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                16.verticalSpace,

                /// List of reviews
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
                      if (value == 'report'.tr()) {
                        print('navigate to report screen');
                      } else if (value == 'editReview'.tr()) {
                        print('navigate to edit review screen');
                      } else if (value == 'deleteReview'.tr()) {
                        print('delete review');
                      }
                    },
                    menuItems: [
                      {'title': 'report'.tr(), 'icon': Icons.report_outlined},
                      {'title': 'editReview'.tr(), 'icon': Iconsax.edit},
                      {'title': 'deleteReview'.tr(), 'icon': Iconsax.trash},
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

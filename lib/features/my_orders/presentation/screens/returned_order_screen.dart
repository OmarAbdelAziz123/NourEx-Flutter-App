import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_image_picker_bottom_sheet_widget.dart';
import 'package:nourex/core/widgets/button/custom_button_widget.dart';
import 'package:nourex/core/widgets/container/selectd_image_item_container_widget.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/my_orders/business_logic/my_orders_cubit.dart';
import 'package:nourex/features/my_orders/data/models/my_orders_data_model.dart';

class ReturnedOrderScreen extends StatefulWidget {
  const ReturnedOrderScreen({super.key, required this.orderData});

  final Map<String, dynamic> orderData;

  @override
  State<ReturnedOrderScreen> createState() => _ReturnedOrderScreenState();
}

class _ReturnedOrderScreenState extends State<ReturnedOrderScreen> {
  List<XFile> selectedImages = [];
  String? selectedProductName;
  TextEditingController productController = TextEditingController();
  List<MyOrderProduct> selectedProducts = [];
  List<MyOrderProduct> allProducts = [];

  @override
  void initState() {
    super.initState();
    _initializeProducts();
  }

  void _initializeProducts() {
    // Extract products from orderData
    final orderData = widget.orderData['orderProducts'] as MyOrder?;
    if (orderData?.products != null) {
      allProducts = orderData!.products!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'returnOrder'.tr(),
          isSubScreen: true,
          haveOnlyNotification: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: BlocBuilder<MyOrdersCubit, MyOrdersState>(
  builder: (context, state) {
    final cubit = context.read<MyOrdersCubit>();

    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 18.h,
            left: 18.w,
            right: 18.w,
            bottom: 52.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'returnOrderDescription'.tr(),
                style: Styles.highlightEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
              ),
              8.verticalSpace,

              CustomTextFormFieldWidget(
                borderRadius: AppConstants.borderRadius,
                borderWidth: 1.w,
                maxLines: 5,
                controller: cubit.reasonController,
                backgroundColor: Colors.transparent,
                hintText: 'returnOrderDescription2'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
              24.verticalSpace,

              Text(
                'selectProduct'.tr(),
                style: Styles.highlightEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
              ),
              8.verticalSpace,

              CustomTextFormFieldWidget(
                borderRadius: AppConstants.borderRadius,
                borderWidth: 1.w,
                readOnly: true,
                controller: productController,
                onTap: () {
                  _showProductSelectionDialog(context);
                },
                backgroundColor: Colors.transparent,
                hintText: 'choiceProduct'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                suffixIcon: Icon(
                  Icons.production_quantity_limits,
                  size: 18.sp,
                  color: AppColors.neutralColor600,
                ),
              ),

              // Show selected products
              if (selectedProducts.isNotEmpty) ...[
                16.verticalSpace,
                Text(
                  'selectedProducts'.tr(),
                  style: Styles.highlightEmphasis.copyWith(
                    color: AppColors.neutralColor1000,
                  ),
                ),
                8.verticalSpace,
                ...selectedProducts.map((product) => Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.neutralColor200),
                        borderRadius:
                            BorderRadius.circular(AppConstants.borderRadius),
                      ),
                      child: Row(
                        children: [
                          // Product Image
                          Container(
                            width: 50.w,
                            height: 50.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              image: product.mainImageURL != null
                                  ? DecorationImage(
                                      image:
                                          NetworkImage(product.mainImageURL!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: product.mainImageURL == null
                                ? Icon(Icons.image,
                                    color: AppColors.neutralColor400)
                                : null,
                          ),
                          12.horizontalSpace,
                          // Product Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name ?? 'Unknown Product',
                                  style: Styles.contentEmphasis.copyWith(
                                    color: AppColors.neutralColor1000,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (product.variants?.isNotEmpty == true) ...[
                                  4.verticalSpace,
                                  Text(
                                    '${'price'.tr()}: \$${product.variants!.first.priceAfterDiscount ?? product.variants!.first.price}',
                                    style: Styles.contentRegular.copyWith(
                                      color: AppColors.neutralColor600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          // Remove Button
                          IconButton(
                            onPressed: () {
                              setState(() {
                                selectedProducts.remove(product);
                                _updateProductController();
                                _printSelectedProductsIds();
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              color: AppColors.redColor200,
                              size: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],

              24.verticalSpace,

              Text(
                'productImage'.tr(),
                style: Styles.highlightEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
              ),
              8.verticalSpace,

              CustomTextFormFieldWidget(
                borderRadius: AppConstants.borderRadius,
                readOnly: true,
                showCursor: true,
                onTap: () {
                  _showImagePickerBottomSheet(context);
                },
                suffixIcon: SvgPicture.asset(
                  'assets/svgs/gallery_icon.svg',
                  fit: BoxFit.scaleDown,
                ),
                borderWidth: 1.w,
                backgroundColor: Colors.transparent,
                hintText: 'productDescription'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
              24.verticalSpace,

              /// Row Selected Images
              if (selectedImages.isNotEmpty) ...[
                Text(
                  '${'selectedImages'.tr()} (${selectedImages.length})',
                  style: Styles.highlightEmphasis.copyWith(
                    color: AppColors.neutralColor1000,
                  ),
                ),
                12.verticalSpace,
                SizedBox(
                  height: 100.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedImages.length,
                    separatorBuilder: (context, index) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      final image = selectedImages[index];
                      return SelectedImageItemContainerWidget(
                        image: image,
                        onRemove: () {
                          setState(() {
                            selectedImages.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                ),
                16.verticalSpace,
              ],
            ],
          ),
        ),
      );
  },
),
      bottomNavigationBar: BlocConsumer<MyOrdersCubit, MyOrdersState>(
        listener: (context, state) {
          if (state is MakeReturnOrderSuccessState) {
            context.pushNamedAndRemoveUntil(
              Routes.mainLayoutScreen,
              arguments: 0,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<MyOrdersCubit>();

          return SafeArea(
            child: Container(
              padding: EdgeInsets.only(
                left: 18.w,
                right: 18.w,
                bottom: 35.h,
                top: 18.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: AppColors.neutralColor100, width: 1.w),
                ),
              ),
              child: Row(
                spacing: 16.w,
                children: [
                  Expanded(
                    child: CustomButtonWidget(
                      text: 'returnOrder'.tr(),
                      color: AppColors.primaryColor700,
                      onPressed: () {
                        print('Filter');
                        _printSelectedProductsIds();
                        _printSelectedProductsPostmanStyle();
                        print(
                            'Selected Images: ${selectedImages.map((image) => image.path).toList()}');
                        // Format products and call the API
                        List<Map<String, String>> formattedProducts =
                            _formatProductsForAPI();

                        cubit.makeReturnOrder(
                          orderId: widget.orderData['orderId'].toString(),
                          products: formattedProducts,
                          returnImages: selectedImages,
                        );
                        // showModalBottomSheet(
                        //   context: context,
                        //   backgroundColor: AppColors.neutralColor100,
                        //   isScrollControlled: true,
                        //   builder: (context) {
                        //     return CustomSharedShowBottomSheet(
                        //       headingName: 'returnOrder'.tr(),
                        //       imagePath:
                        //           'assets/svgs/green_icon_in_bottom_sheet_icon.svg',
                        //       haveTextSpan: true,
                        //       text1: 'orderSent'.tr(),
                        //       text2: 'returnOrder'.tr(),
                        //       description: 'orderSentDescription'.tr(),
                        //       haveOneButton: false,
                        //       buttonText1: 'contactSupport'.tr(),
                        //       buttonText2: 'myOrders'.tr(),
                        //       onTap1: () {},
                        //       onTap2: () {},
                        //     );
                        //   },
                        // );
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomButtonWidget(
                      text: 'cancelOrder'.tr(),
                      textColor: AppColors.primaryColor700,
                      borderSide: BorderSide(
                        color: AppColors.primaryColor700,
                        width: 1.w,
                      ),
                      borderRadius: AppConstants.borderRadius - 2.w,
                      color: Colors.white,
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showProductSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.neutralColor100,
              title: Text(
                'selectProducts'.tr(),
                style: Styles.highlightSemiBold,
              ),
              content: Container(
                width: double.maxFinite,
                height: 400.h,
                child: allProducts.isEmpty
                    ? Center(
                        child: Text(
                          'noProductsFound'.tr(),
                          style: Styles.contentRegular.copyWith(
                            color: AppColors.neutralColor600,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: allProducts.length,
                        itemBuilder: (context, index) {
                          final product = allProducts[index];
                          final isSelected = selectedProducts.contains(product);

                          return Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            child: InkWell(
                              onTap: () {
                                setDialogState(() {
                                  if (isSelected) {
                                    selectedProducts.remove(product);
                                  } else {
                                    selectedProducts.add(product);
                                  }
                                });
                                // Print IDs when selection changes
                                _printSelectedProductsIds();
                              },
                              child: Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primaryColor700
                                        : AppColors.neutralColor200,
                                    width: isSelected ? 2.w : 1.w,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.borderRadius),
                                  color: isSelected
                                      ? AppColors.primaryColor700
                                          .withOpacity(0.1)
                                      : Colors.transparent,
                                ),
                                child: Row(
                                  children: [
                                    // Product Image
                                    Container(
                                      width: 50.w,
                                      height: 50.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        image: product.mainImageURL != null
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                    product.mainImageURL!),
                                                fit: BoxFit.cover,
                                              )
                                            : null,
                                      ),
                                      child: product.mainImageURL == null
                                          ? Icon(Icons.image,
                                              color: AppColors.neutralColor400)
                                          : null,
                                    ),
                                    12.horizontalSpace,
                                    // Product Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name ?? 'Unknown Product',
                                            style:
                                                Styles.contentEmphasis.copyWith(
                                              color: AppColors.neutralColor1000,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          if (product.variants?.isNotEmpty ==
                                              true) ...[
                                            4.verticalSpace,
                                            Text(
                                              '${'price'.tr()}: \$${product.variants!.first.priceAfterDiscount ?? product.variants!.first.price}',
                                              style: Styles.contentRegular
                                                  .copyWith(
                                                color:
                                                    AppColors.neutralColor600,
                                              ),
                                            ),
                                            if (product.variants!.first
                                                    .attributes?.isNotEmpty ==
                                                true) ...[
                                              2.verticalSpace,
                                              Text(
                                                product
                                                    .variants!.first.attributes!
                                                    .map((attr) =>
                                                        '${attr.name}: ${attr.value}')
                                                    .join(', '),
                                                style: Styles.captionRegular
                                                    .copyWith(
                                                  color:
                                                      AppColors.neutralColor500,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ],
                                        ],
                                      ),
                                    ),

                                    12.horizontalSpace,
                                    // Checkbox
                                    Container(
                                      width: 24.w,
                                      height: 24.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected
                                              ? AppColors.primaryColor700
                                              : AppColors.neutralColor400,
                                          width: 2.w,
                                        ),
                                        color: isSelected
                                            ? AppColors.primaryColor700
                                            : Colors.transparent,
                                      ),
                                      child: isSelected
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 16.sp,
                                            )
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text('cancel'.tr(), style: Styles.contentRegular),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _updateProductController();
                    });
                    context.pop();
                    _printSelectedProductsIds();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor700,
                  ),
                  child: Text(
                    'confirm'.tr(),
                    style: Styles.contentRegular.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _updateProductController() {
    if (selectedProducts.isEmpty) {
      productController.text = '';
    } else {
      productController.text = selectedProducts
          .map((product) => product.name ?? 'Unknown')
          .join(', ');
    }
  }

  // void _printSelectedProductsIds() {
  //   List<String> selectedProductsIds = [];
  //
  //   for (var product in selectedProducts) {
  //     // If the product has variants, collect variant IDs
  //     if (product.variants?.isNotEmpty == true) {
  //       for (var variant in product.variants!) {
  //         if (variant.id != null) {
  //           selectedProductsIds.add(variant.id!);
  //         }
  //       }
  //     }
  //   }
  //
  //   print('Selected Products IDs: $selectedProductsIds');
  //   print('Selected Products Count: ${selectedProducts.length}');
  //
  //   // Also print product names for debugging
  //   List<String> productNames =
  //       selectedProducts.map((product) => product.name ?? 'Unknown').toList();
  //   print('Selected Product Names: $productNames');
  // }

  void _printSelectedProductsIds() {
    List<Map<String, String>> formattedProducts = [];
    int index = 0;

    for (var product in selectedProducts) {
      // If the product has variants, collect variant IDs with proper formatting
      if (product.variants?.isNotEmpty == true) {
        for (var variant in product.variants!) {
          // Print in postman-like format
          print('products[$index][productId]: ${product.productId ?? 'N/A'}');
          print('products[$index][variantSku]: ${variant.sku ?? 'N/A'}');

          // Add to formatted list for additional processing if needed
          formattedProducts.add({
            // 'productId': product.id ?? 'N/A',
            'variantSku': variant.sku ?? 'N/A',
          });

          index++;
        }
      }
    }

    print('\n--- Summary ---');
    print('Total Selected Products: ${selectedProducts.length}');
    print('Total Variants: $index');

    // Also print product names for debugging
    List<String> productNames =
        selectedProducts.map((product) => product.name ?? 'Unknown').toList();
    print('Selected Product Names: $productNames');

    // Print all formatted data as a list
    print('\nFormatted Data:');
    for (int i = 0; i < formattedProducts.length; i++) {
      print('products[$i][productId]: ${formattedProducts[i]['productId']}');
      print('products[$i][variantSku]: ${formattedProducts[i]['variantSku']}');
    }
  }

// Alternative version if you want to return the formatted data
  Map<String, String> getFormattedProductsData() {
    Map<String, String> formData = {};
    int index = 0;

    for (var product in selectedProducts) {
      if (product.variants?.isNotEmpty == true) {
        for (var variant in product.variants!) {
          formData['products[$index][productId]'] = product.productId ?? '';
          formData['products[$index][variantSku]'] = variant.sku ?? '';
          index++;
        }
      }
    }

    return formData;
  }

  // Add this method to format your products properly
  List<Map<String, String>> _formatProductsForAPI() {
    List<Map<String, String>> formattedProducts = [];

    for (var product in selectedProducts) {
      if (product.variants?.isNotEmpty == true) {
        for (var variant in product.variants!) {
          formattedProducts.add({
            'productId': product.productId ?? '', // Use productId, not id
            'variantSku': variant.sku ?? '',
          });
        }
      }
    }

    return formattedProducts;
  }

// If you want to print exactly like the image format
  void _printSelectedProductsPostmanStyle() {
    int index = 0;

    print('\n=== Selected Products (Postman Style) ===');

    for (var product in selectedProducts) {
      if (product.variants?.isNotEmpty == true) {
        for (var variant in product.variants!) {
          // print('✓ products[$index][productId]    Text    ${product. ?? 'N/A'}');
          print(
              '✓ products[$index][variantSku]   Text    ${variant.sku ?? 'N/A'}');
          index++;
        }
      }
    }

    print('\nTotal entries: $index');
  }

  /// Add this method to show the image picker bottom sheet
  void _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.neutralColor100,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.borderRadius),
        ),
      ),
      builder: (context) => CustomImagePickerBottomSheetWidget(
        onImagePicked: (image) {
          setState(() {
            selectedImages.add(image);
          });
          print('Selected: ${image.path}');
        },
      ),
    );
  }
}

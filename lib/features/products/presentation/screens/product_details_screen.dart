import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/services/di/di.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/hex_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_shared_bottom_sheet_review.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:nourex/core/widgets/divider/custom_divider_in_bottom_sheet.dart';
import 'package:nourex/core/widgets/drop_down/custom_drop_down_menu_widget.dart';
import 'package:nourex/core/widgets/row/show_more_row_widget.dart';
import 'package:nourex/core/widgets/text/custom_text_rich_widget.dart';
import 'package:nourex/features/cart/business_logic/cart_cubit.dart';
import 'package:nourex/features/products/business_logic/products_cubit.dart';
import 'package:nourex/features/products/data/models/product_details_model.dart';
import 'package:nourex/features/products/data/models/variant_option.dart';
import 'package:nourex/features/profile/business_logic/profile_cubit.dart';
import 'package:nourex/features/profile/presentation/widgets/review_item_skeletonizer_widget.dart';
import 'package:nourex/features/profile/presentation/widgets/review_item_widget.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  // List<VariantOption> _generateVariantOptions(
  //     List<String?> values, String variantType) {
  //   return values.where((value) => value != null).map((value) {
  //     // Enhanced color detection
  //     final isColorVariant = variantType.toLowerCase().contains('color') ||
  //         variantType.toLowerCase().contains('colour') ||
  //         variantType.toLowerCase().contains('لون') ||
  //         variantType.toLowerCase().contains('الألوان') ||
  //         variantType.toLowerCase() == 'color' ||
  //         variantType == 'Color';
  //
  //     print('isColorVariant is $isColorVariant');
  //
  //     return VariantOption(
  //       id: value!,
  //       label: value,
  //       color: isColorVariant ? _getColorFromString(value) : null,
  //       // isAvailable: true,
  //     );
  //   }).toList();
  // }
  //
  // Color? _getColorFromString(String colorName) {
  //   switch (colorName.toLowerCase()) {
  //     // Arabic colors
  //     case 'أسود':
  //     case 'black':
  //       return Colors.black;
  //     case 'أحمر':
  //     case 'red':
  //       return Colors.red;
  //     case 'بني':
  //     case 'brown':
  //       return Colors.brown;
  //     case 'أصفر':
  //     case 'yellow':
  //       return Colors.yellow;
  //     case 'رمادي':
  //     case 'grey':
  //     case 'gray':
  //       return Colors.grey;
  //     case 'أبيض':
  //     case 'white':
  //       return Colors.white;
  //     case 'أزرق':
  //     case 'blue':
  //       return Colors.blue;
  //     case 'أخضر':
  //     case 'green':
  //       return Colors.green;
  //     // Additional common colors
  //     case 'orange':
  //     case 'برتقالي':
  //       return Colors.orange;
  //     case 'purple':
  //     case 'بنفسجي':
  //       return Colors.purple;
  //     case 'pink':
  //     case 'وردي':
  //       return Colors.pink;
  //     case 'cyan':
  //     case 'سماوي':
  //       return Colors.cyan;
  //     case 'lime':
  //     case 'ليموني':
  //       return Colors.lime;
  //     case 'indigo':
  //     case 'نيلي':
  //       return Colors.indigo;
  //     case 'teal':
  //     case 'أزرق مخضر':
  //       return Colors.teal;
  //     case 'amber':
  //     case 'عنبري':
  //       return Colors.amber;
  //     case 'deep orange':
  //     case 'برتقالي غامق':
  //       return Colors.deepOrange;
  //     case 'light blue':
  //     case 'أزرق فاتح':
  //       return Colors.lightBlue;
  //     case 'light green':
  //     case 'أخضر فاتح':
  //       return Colors.lightGreen;
  //     default:
  //       return Colors.grey;
  //   }
  // }
  //
  // // Map<String, List<String>> buildVariantMap(Result product) {
  // Color _getContrastColor(Color backgroundColor) {
  //   // Calculate luminance to determine if we need white or black text
  //   final luminance = backgroundColor.computeLuminance();
  //   return luminance > 0.5 ? Colors.black : Colors.white;
  // }
  //
  // /// ✅ Add this helper method to your ProductDetailsScreen class:
  // num _getDefaultPrice(Result? productDetails) {
  //   if (productDetails?.variants?.isNotEmpty == true) {
  //     final firstVariant = productDetails!.variants!.first;
  //     return firstVariant.priceAfterDiscount!;
  //   }
  //   return 0;
  // }
  //
  // num _getDefaultPriceBefore(Result? productDetails) {
  //   if (productDetails?.variants?.isNotEmpty == true) {
  //     final firstVariant = productDetails!.variants!.first;
  //     if (firstVariant.discountRounded! > 0) {
  //       return firstVariant.price ?? 0;
  //     }
  //   }
  //   return 0;
  // }
  //
  // /// ✅ Add this helper method for stock:
  // int _getStockAmount(
  //     Result? productDetails, Map<String, String?> selectedVariants) {
  //   if (productDetails?.variants == null) return 0;
  //
  //   /// Find matching variant based on selected variants
  //   for (var variant in productDetails!.variants!) {
  //     bool isMatch = true;
  //
  //     for (var attr in variant.attributes ?? []) {
  //       final selectedValue = selectedVariants[attr.name];
  //       if (selectedValue == null || selectedValue != attr.value) {
  //         isMatch = false;
  //         break;
  //       }
  //     }
  //
  //     if (isMatch) {
  //       return variant.stockAmount ?? 0;
  //     }
  //   }
  //
  //   /// Fallback to first variant
  //   if (productDetails.variants!.isNotEmpty) {
  //     return productDetails.variants!.first.stockAmount ?? 0;
  //   }
  //
  //   return 0;
  // }
  //
  //
  // Color _parseColor(String hexColor) {
  //   if (hexColor.isEmpty) return Colors.grey; // fallback for empty values
  //
  //   hexColor = hexColor.toUpperCase().replaceAll("#", ""); // remove #
  //
  //   if (hexColor.length == 6) {
  //     hexColor = "FF$hexColor"; // add full opacity if not provided
  //   }
  //
  //   return Color(int.parse(hexColor, radix: 16));
  // }

  List<VariantOption> _generateVariantOptions(
      List<String?> values, String variantType) {
    return values.where((value) => value != null).map((value) {
      // Enhanced color detection
      final isColorVariant = variantType.toLowerCase().contains('color') ||
          variantType.toLowerCase().contains('colour') ||
          variantType.toLowerCase().contains('لون') ||
          variantType.toLowerCase().contains('الألوان') ||
          variantType.toLowerCase() == 'color' ||
          variantType == 'Color';

      print('isColorVariant is $isColorVariant');

      return VariantOption(
        id: value!,
        label: value,
        // Updated: Use hex color parsing for color variants
        color: isColorVariant ? _parseHexColor(value) : null,
      );
    }).toList();
  }

// Updated method to handle hex colors from API
  Color _parseHexColor(String colorValue) {
    try {
      // Check if it's a hex color (starts with # or is 6-8 characters of hex)
      if (_isHexColor(colorValue)) {
        return _parseColor(colorValue);
      } else {
        // Fallback to color name parsing for backward compatibility
        return _getColorFromString(colorValue);
      }
    } catch (e) {
      print('Error parsing color: $colorValue, Error: $e');
      return Colors.grey; // fallback color
    }
  }

// Helper method to check if string is hex color
  bool _isHexColor(String colorValue) {
    final hexPattern = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$');
    return hexPattern.hasMatch(colorValue.trim());
  }

// Updated parseColor method with better error handling
  Color _parseColor(String hexColor) {
    if (hexColor.isEmpty) return Colors.grey;

    try {
      hexColor = hexColor.trim().toUpperCase().replaceAll("#", "");

      // Handle 3-digit hex colors (e.g., "fff" -> "ffffff")
      if (hexColor.length == 3) {
        hexColor = hexColor.split('').map((char) => char + char).join('');
      }

      // Add full opacity if not provided (6 digits -> 8 digits)
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }

      // Validate hex string length
      if (hexColor.length != 8) {
        throw FormatException('Invalid hex color length: ${hexColor.length}');
      }

      return Color(int.parse(hexColor, radix: 16));
    } catch (e) {
      print('Error parsing hex color: $hexColor, Error: $e');
      return Colors.grey;
    }
  }

// Keep original method for backward compatibility with color names
  Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
    // Arabic colors
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
    // Additional common colors
      case 'orange':
      case 'برتقالي':
        return Colors.orange;
      case 'purple':
      case 'بنفسجي':
        return Colors.purple;
      case 'pink':
      case 'وردي':
        return Colors.pink;
      case 'cyan':
      case 'سماوي':
        return Colors.cyan;
      case 'lime':
      case 'ليموني':
        return Colors.lime;
      case 'indigo':
      case 'نيلي':
        return Colors.indigo;
      case 'teal':
      case 'أزرق مخضر':
        return Colors.teal;
      case 'amber':
      case 'عنبري':
        return Colors.amber;
      case 'deep orange':
      case 'برتقالي غامق':
        return Colors.deepOrange;
      case 'light blue':
      case 'أزرق فاتح':
        return Colors.lightBlue;
      case 'light green':
      case 'أخضر فاتح':
        return Colors.lightGreen;
      default:
        return Colors.grey;
    }
  }

  Color _getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

// Updated method to get selected variant price
  num _getSelectedVariantPrice(Result? productDetails, Map<String, String?> selectedVariants) {
    if (productDetails?.variants == null) return _getDefaultPrice(productDetails);

    // Find matching variant based on selected variants
    for (var variant in productDetails!.variants!) {
      bool isMatch = true;

      // Check if all selected variants match this variant's attributes
      for (var attr in variant.attributes ?? []) {
        final selectedValue = selectedVariants[attr.name];
        if (selectedValue == null || selectedValue != attr.value) {
          isMatch = false;
          break;
        }
      }

      if (isMatch) {
        return variant.priceAfterDiscount ?? variant.price ?? 0;
      }
    }

    // Fallback to default price if no matching variant found
    return _getDefaultPrice(productDetails);
  }

// Updated method to get selected variant price before discount
  num _getSelectedVariantPriceBefore(Result? productDetails, Map<String, String?> selectedVariants) {
    if (productDetails?.variants == null) return _getDefaultPriceBefore(productDetails);

    // Find matching variant based on selected variants
    for (var variant in productDetails!.variants!) {
      bool isMatch = true;

      // Check if all selected variants match this variant's attributes
      for (var attr in variant.attributes ?? []) {
        final selectedValue = selectedVariants[attr.name];
        if (selectedValue == null || selectedValue != attr.value) {
          isMatch = false;
          break;
        }
      }

      if (isMatch && (variant.discountRounded ?? 0) > 0) {
        return variant.price ?? 0;
      }
    }

    // Fallback to default price before discount
    return _getDefaultPriceBefore(productDetails);
  }

  /// ✅ Original helper methods (keep these)
  num _getDefaultPrice(Result? productDetails) {
    if (productDetails?.variants?.isNotEmpty == true) {
      final firstVariant = productDetails!.variants!.first;
      return firstVariant.priceAfterDiscount ?? firstVariant.price ?? 0;
    }
    return 0;
  }

  num _getDefaultPriceBefore(Result? productDetails) {
    if (productDetails?.variants?.isNotEmpty == true) {
      final firstVariant = productDetails!.variants!.first;
      if ((firstVariant.discountRounded ?? 0) > 0) {
        return firstVariant.price ?? 0;
      }
    }
    return 0;
  }



  /// ✅ Updated stock amount method (keep this)
  int _getStockAmount(Result? productDetails, Map<String, String?> selectedVariants) {
    if (productDetails?.variants == null) return 0;

    /// Find matching variant based on selected variants
    for (var variant in productDetails!.variants!) {
      bool isMatch = true;

      for (var attr in variant.attributes ?? []) {
        final selectedValue = selectedVariants[attr.name];
        if (selectedValue == null || selectedValue != attr.value) {
          isMatch = false;
          break;
        }
      }

      if (isMatch) {
        return variant.stockAmount ?? 0;
      }
    }

    /// Fallback to first variant
    if (productDetails.variants!.isNotEmpty) {
      return productDetails.variants!.first.stockAmount ?? 0;
    }

    return 0;
  }
  // List<VariantOption> _generateVariantOptions(
  //     List<String?> values, String variantType) {
  //   return values.where((value) => value != null).map((value) {
  //     // Enhanced color detection
  //     final isColorVariant = variantType.toLowerCase().contains('color') ||
  //         variantType.toLowerCase().contains('colour') ||
  //         variantType.toLowerCase().contains('لون') ||
  //         variantType.toLowerCase().contains('الألوان') ||
  //         variantType.toLowerCase() == 'color' ||
  //         variantType == 'Color';
  //
  //     print('isColorVariant is $isColorVariant');
  //
  //     return VariantOption(
  //       id: value!,
  //       label: value,
  //       // Updated: Use hex color parsing for color variants
  //       color: isColorVariant ? _parseHexColor(value) : null,
  //     );
  //   }).toList();
  // }
  //
  // // Updated method to handle hex colors from API
  // Color _parseHexColor(String colorValue) {
  //   try {
  //     // Check if it's a hex color (starts with # or is 6-8 characters of hex)
  //     if (_isHexColor(colorValue)) {
  //       return _parseColor(colorValue);
  //     } else {
  //       // Fallback to color name parsing for backward compatibility
  //       return _getColorFromString(colorValue);
  //     }
  //   } catch (e) {
  //     print('Error parsing color: $colorValue, Error: $e');
  //     return Colors.grey; // fallback color
  //   }
  // }
  //
  // // Helper method to check if string is hex color
  // bool _isHexColor(String colorValue) {
  //   final hexPattern = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$');
  //   return hexPattern.hasMatch(colorValue.trim());
  // }
  //
  // // Updated parseColor method with better error handling
  // Color _parseColor(String hexColor) {
  //   if (hexColor.isEmpty) return Colors.grey;
  //
  //   try {
  //     hexColor = hexColor.trim().toUpperCase().replaceAll("#", "");
  //
  //     // Handle 3-digit hex colors (e.g., "fff" -> "ffffff")
  //     if (hexColor.length == 3) {
  //       hexColor = hexColor.split('').map((char) => char + char).join('');
  //     }
  //
  //     // Add full opacity if not provided (6 digits -> 8 digits)
  //     if (hexColor.length == 6) {
  //       hexColor = "FF$hexColor";
  //     }
  //
  //     // Validate hex string length
  //     if (hexColor.length != 8) {
  //       throw FormatException('Invalid hex color length: ${hexColor.length}');
  //     }
  //
  //     return Color(int.parse(hexColor, radix: 16));
  //   } catch (e) {
  //     print('Error parsing hex color: $hexColor, Error: $e');
  //     return Colors.grey;
  //   }
  // }
  //
  // // Keep original method for backward compatibility with color names
  // Color _getColorFromString(String colorName) {
  //   switch (colorName.toLowerCase()) {
  //   // Arabic colors
  //     case 'أسود':
  //     case 'black':
  //       return Colors.black;
  //     case 'أحمر':
  //     case 'red':
  //       return Colors.red;
  //     case 'بني':
  //     case 'brown':
  //       return Colors.brown;
  //     case 'أصفر':
  //     case 'yellow':
  //       return Colors.yellow;
  //     case 'رمادي':
  //     case 'grey':
  //     case 'gray':
  //       return Colors.grey;
  //     case 'أبيض':
  //     case 'white':
  //       return Colors.white;
  //     case 'أزرق':
  //     case 'blue':
  //       return Colors.blue;
  //     case 'أخضر':
  //     case 'green':
  //       return Colors.green;
  //   // Additional common colors
  //     case 'orange':
  //     case 'برتقالي':
  //       return Colors.orange;
  //     case 'purple':
  //     case 'بنفسجي':
  //       return Colors.purple;
  //     case 'pink':
  //     case 'وردي':
  //       return Colors.pink;
  //     case 'cyan':
  //     case 'سماوي':
  //       return Colors.cyan;
  //     case 'lime':
  //     case 'ليموني':
  //       return Colors.lime;
  //     case 'indigo':
  //     case 'نيلي':
  //       return Colors.indigo;
  //     case 'teal':
  //     case 'أزرق مخضر':
  //       return Colors.teal;
  //     case 'amber':
  //     case 'عنبري':
  //       return Colors.amber;
  //     case 'deep orange':
  //     case 'برتقالي غامق':
  //       return Colors.deepOrange;
  //     case 'light blue':
  //     case 'أزرق فاتح':
  //       return Colors.lightBlue;
  //     case 'light green':
  //     case 'أخضر فاتح':
  //       return Colors.lightGreen;
  //     default:
  //       return Colors.grey;
  //   }
  // }
  //
  // Color _getContrastColor(Color backgroundColor) {
  //   final luminance = backgroundColor.computeLuminance();
  //   return luminance > 0.5 ? Colors.black : Colors.white;
  // }
  //
  // num _getDefaultPrice(Result? productDetails) {
  //   if (productDetails?.variants?.isNotEmpty == true) {
  //     final firstVariant = productDetails!.variants!.first;
  //     return firstVariant.priceAfterDiscount!;
  //   }
  //   return 0;
  // }

  // num _getDefaultPriceBefore(Result? productDetails) {
  //   if (productDetails?.variants?.isNotEmpty == true) {
  //     final firstVariant = productDetails!.variants!.first;
  //     if (firstVariant.discountRounded! > 0) {
  //       return firstVariant.price ?? 0;
  //     }
  //   }
  //   return 0;
  // }
  //
  // int _getStockAmount(
  //     Result? productDetails, Map<String, String?> selectedVariants) {
  //   if (productDetails?.variants == null) return 0;
  //
  //   for (var variant in productDetails!.variants!) {
  //     bool isMatch = true;
  //
  //     for (var attr in variant.attributes ?? []) {
  //       final selectedValue = selectedVariants[attr.name];
  //       if (selectedValue == null || selectedValue != attr.value) {
  //         isMatch = false;
  //         break;
  //       }
  //     }
  //
  //     if (isMatch) {
  //       return variant.stockAmount ?? 0;
  //     }
  //   }
  //
  //   if (productDetails.variants!.isNotEmpty) {
  //     return productDetails.variants!.first.stockAmount ?? 0;
  //   }
  //
  //   return 0;
  // }


  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final cubit = context.read<ProductsCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'productDetails'.tr(),
          isSubScreen: true,
          haveOnlyNotification: false,
          onTapBack: () {
            context.pop();
          },
          onTapSearch: () {},
        ),
      ),
      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          if (state is MakeReviewSuccessState) {
            context.pop();
            cubit.getProductById(productId: widget.productId);
          } else if(state is MakeReviewErrorState) {
            context.pop();
          }
        },
        builder: (context, state) {
          final cubit = context.read<ProductsCubit>();
          final productDetails = cubit.productDetailsModel?.result;
          final subImages = productDetails?.subImages ?? [];
          final selectedVariants = cubit.selectedVariants;

          // final variantsMap =
          //     cubit.productDetailsModel?.result?.addInvariantsMap() ?? {};
          final variantsMap = cubit.getVariantsMap();

          final selectedPrice = cubit.selectedPrice;

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
                            /// Image and Sub Images
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
                                          cubit.updateMainImage(
                                              image); // ✅ Use cubit method
                                          // setState(() {
                                          //   productDetails?.mainImageURL =
                                          //       image;
                                          // });
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

                            /// Product name & stock
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  spacing: 8.h,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productDetails?.name ?? 'No Name',
                                      style: Styles.captionRegular.copyWith(
                                        color: AppColors.neutralColor600,
                                      ),
                                    ),
                                    8.horizontalSpace,
                                    _getStockAmount(productDetails,
                                                cubit.selectedVariants) <
                                            10
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w, vertical: 6.h),
                                            decoration: BoxDecoration(
                                              color:
                                                  AppColors.secondaryColor500,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppConstants
                                                              .borderRadius +
                                                          18.r),
                                            ),
                                            child: Text(
                                              '${_getStockAmount(productDetails, cubit.selectedVariants)} ${'remaining'.tr()}',
                                              // '${productDetails?.stock.toString()} متبقي',
                                              style: Styles.captionEmphasis
                                                  .copyWith(
                                                color:
                                                    AppColors.neutralColor100,
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                                Row(
                                  spacing: 12.w,
                                  children: [
                                    if (cubit.productDetailsModel?.result
                                            ?.isRated ==
                                        false)
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) {
                                              final rating = 3.5;

                                              return CustomSharedBottomSheetReview(
                                                title: '${'theRate'.tr()}',
                                                nameOfFiled:
                                                    'rateTheProduct'.tr(),
                                                initialRating: rating,
                                                hintText: 'yourRating'.tr(),
                                                isEdit: false,
                                                buttonText1: 'makeSuree'.tr(),
                                                buttonText2: 'cancel'.tr(),
                                                onRatingChanged: (rating) {
                                                  rating = rating;
                                                  setState(() {});
                                                },
                                                commentController:
                                                    cubit.commentController,
                                                onEditPressed: () {
                                                  cubit.makeReview(
                                                      productId:
                                                          widget.productId,
                                                      rating: rating.toInt());
                                                },
                                                onCancelPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          'makeRate'.tr(),
                                          style:
                                              Styles.highlightSemiBold.copyWith(
                                            color: AppColors.primaryColor700,
                                            decoration:
                                                TextDecoration.underline,
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
                                            "https://noorex-dashboard.vercel.app/user/products/${productDetails?.sId}";
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
                            8.verticalSpace,

                            /// Final Product Name
                            Text(productDetails?.name ?? '',
                                style: Styles.featureSemiBold),
                            4.verticalSpace,

                            /// Brand and Price
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
                                      backgroundImage: productDetails
                                                  ?.createdBy?.profilePic !=
                                              null
                                          ? NetworkImage(productDetails!
                                              .createdBy!.profilePic!)
                                          : const AssetImage(
                                              'assets/pngs/admin_image.png'),
                                    ),
                                    Text(
                                      productDetails?.createdBy?.vendorName ??
                                          '',
                                      // productDetails?.name ?? '',
                                      style: Styles.contentBold.copyWith(
                                        color: AppColors.secondaryColor500,
                                      ),
                                    ),
                                    if (productDetails
                                            ?.createdBy?.varifiedVendor ==
                                        true)
                                      SvgPicture.asset(
                                        'assets/svgs/water_mark_icon.svg',
                                        fit: BoxFit.scaleDown,
                                      ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      // '${_getDefaultPrice(productDetails)} ${'currency'.tr()}',
                                      '${_getSelectedVariantPrice(productDetails, selectedVariants)} ${'currency'.tr()}',
                                      // '${_getSelectedVariantPriceBefore(productDetails, selectedVariants)} ${'currency'.tr()}',
                                      // ' ${selectedPrice ?? productDetails?.finalPrice} ${'currency'.tr()}',
                                      style: Styles.heading4,
                                    ),
                                    Text(
                                      '${_getDefaultPriceBefore(productDetails)} ${'currency'.tr()}',
                                      style: Styles.contentRegular.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: AppColors.redColor100,
                                          decorationColor:
                                              AppColors.redColor100),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            18.verticalSpace,

                            /// Variants
                            if (productDetails?.variants != null &&
                                productDetails!.variants!.isNotEmpty)
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
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
                                    final isColorVariant = variantType
                                            .toLowerCase()
                                            .contains('color') ||
                                        variantType
                                            .toLowerCase()
                                            .contains('لون');

                                    return Column(
                                      children: [
                                        /// Row containing variant options and title
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            /// Variant Options (Left side)
                                            Expanded(
                                              child: Wrap(
                                                spacing: 8.w,
                                                runSpacing: 8.h,
                                                alignment: WrapAlignment.start,
                                                children: options.map((option) {
                                                  final isSelected =
                                                      selectedVariants[
                                                              variantType] ==
                                                          option.id;

                                                  if (isColorVariant) {
                                                    /// Color Variant Design
                                                    return GestureDetector(
                                                      onTap: () {
                                                        cubit
                                                            .updateSelectedVariant(
                                                                variantType,
                                                                option.id);
                                                      },
                                                      child: Container(
                                                        width: 36.w,
                                                        height: 36.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: option.color ??
                                                          //     Colors.grey,
                                                          //     color: hexToColor('#0bda7a'),
                                                              color: option.color ?? Colors.transparent,

                                                          //     color: _parseColor(option.color.toString()), // ✅ use the hex value
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.r,
                                                              ),
                                                          border: Border.all(
                                                            color: isSelected
                                                                ? AppColors
                                                                    .primaryColor700
                                                                : Colors.grey
                                                                    .shade300,
                                                            width: isSelected
                                                                ? 2.5.w
                                                                : 1.w,
                                                          ),
                                                        ),
                                                        child: isSelected
                                                            ? Icon(
                                                                Icons.check,
                                                                color: _getContrastColor(
                                                                    option.color ??
                                                                        Colors
                                                                            .grey),
                                                                size: 18.sp,
                                                              )
                                                            : null,
                                                      ),
                                                    );
                                                  } else {
                                                    // Size/Text Variant Design
                                                    return GestureDetector(
                                                      onTap: () {
                                                        cubit
                                                            .updateSelectedVariant(
                                                                variantType,
                                                                option.id);
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 14.w,
                                                          vertical: 8.h,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isSelected
                                                              ? Colors.black
                                                              : Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.r),
                                                          border: Border.all(
                                                            color: isSelected
                                                                ? Colors.black
                                                                : Colors.grey
                                                                    .shade300,
                                                            width: 1.w,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          option.label,
                                                          style: TextStyle(
                                                            color: isSelected
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                isSelected
                                                                    ? FontWeight
                                                                        .w600
                                                                    : FontWeight
                                                                        .w500,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                }).toList(),
                                              ),
                                            ),

                                            /// Variant Type Title (Right side)
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 8.w),
                                              child: Text(
                                                variantType,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        /// Divider between variants
                                        if (entry !=
                                            variantsMap.entries.last) ...[
                                          20.verticalSpace,
                                          CustomDividerInBottomSheet(
                                            dividerColor:
                                                AppColors.neutralColor300,
                                          ),
                                          20.verticalSpace,
                                        ],
                                      ],
                                    );
                                  }).toList(),
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

                            // Container(
                            //   width: double.infinity,
                            //   padding: EdgeInsets.all(12.w),
                            //   decoration: BoxDecoration(
                            //     color: AppColors.neutralColor100,
                            //     borderRadius: BorderRadius.circular(
                            //       AppConstants.borderRadius,
                            //     ),
                            //     border: Border.all(
                            //       color: AppColors.neutralColor300,
                            //       width: 1.w,
                            //     ),
                            //   ),
                            //   child: Column(
                            //     mainAxisSize: MainAxisSize.min,
                            //     // Limit the column height
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Flexible(
                            //         // Constrain the row width
                            //         child: Column(
                            //           spacing: 8.h,
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.start,
                            //           // Align to start (left)
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             Text(
                            //               'productNumber'.tr(),
                            //               style: Styles.highlightEmphasis,
                            //             ),
                            //             Text(
                            //               productDetails?.sId ?? '',
                            //               style: Styles.contentRegular.copyWith(
                            //                 color: AppColors.neutralColor800,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // 18.verticalSpace,
                          ],
                        ),
                      ),

                      /// Reviews
                      cubit.allProductReviews.isEmpty
                          ? Container()
                          : state is GetProductReviewsLoadingState ||
                                  cubit.allProductReviews == []
                              ? ReviewItemSkeletonizerWidget()
                              : Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18.w),
                                      child: ShowMoreRowWidget(
                                        title: 'reviews'.tr(),
                                        onTapShowMore: () {
                                          context.pushNamed(
                                            Routes.productReviewsScreen,
                                            arguments: productDetails,
                                          );
                                        },
                                      ),
                                    ),
                                    18.verticalSpace,
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                          18.verticalSpace,
                                      itemCount:
                                          cubit.allProductReviews.length < 6
                                              ? cubit.allProductReviews.length
                                              : 6,
                                      itemBuilder: (context, index) {
                                        final review =
                                            cubit.allProductReviews[index];
                                        final isArabic =
                                            Localizations.localeOf(context)
                                                    .languageCode ==
                                                'ar';

                                        return ReviewItemWidget(
                                          reviewerName: review.user!.name ?? '',
                                          profileImagePath:
                                              review.user!.profilePic ?? '',
                                          reviewText: review.comment ??
                                              'الخدمة كانت رائعة جدًا! مقدم الخدمة محترف ووصل في الوقت المحدد. أنصح الجميع بالتعامل معه. شكرًا لتطبيق حرفة على التجربة الممتازة',
                                          timeAgo:
                                              review.createdAt.toString() ??
                                                  '0',
                                          rating: review.rating ?? 0,
                                          isArabic: isArabic,
                                          moreIconButtonWidget: review
                                                      .myReview ==
                                                  true
                                              ? 18.horizontalSpace
                                              : BlocProvider(
                                                  create: (context) =>
                                                      ProfileCubit(getIt()),
                                                  child: BlocConsumer<
                                                      ProfileCubit,
                                                      ProfileState>(
                                                    listener: (context, state) {
                                                      if (state
                                                          is MakeReportReviewSuccessState) {
                                                        cubit.getInitialProductReviews(
                                                            productId:
                                                                productDetails!
                                                                        .sId ??
                                                                    '');
                                                      }
                                                    },
                                                    builder: (context, state) {
                                                      final cu = context
                                                          .read<ProfileCubit>();
                                                      return CustomDropDownMenuWidget(
                                                        onSelected:
                                                            (String value) {
                                                          if (value ==
                                                              'report'.tr()) {
                                                            cu.makeReportReview(
                                                                reviewId:
                                                                    review.id ??
                                                                        '');
                                                          }
                                                        },
                                                        menuItems: [
                                                          {
                                                            'title':
                                                                'report'.tr(),
                                                            'icon': Icons
                                                                .report_outlined
                                                          },
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                      18.verticalSpace,
                    ],
                  ),
                );
        },
      ),
      bottomNavigationBar: BlocProvider(
        create: (context) => CartCubit(getIt()),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cartCubit = context.read<CartCubit>();

            return BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                final cubit = context.read<ProductsCubit>();
                final selectedVariants = cubit.selectedVariants;
                final selectedPrice = cubit.selectedPrice;
                final productDetails = cubit.productDetailsModel?.result;

                return CustomBottomNavBarMakeButtonOnly(
                    buttonColor: _getStockAmount(
                                productDetails, cubit.selectedVariants) <=
                            0
                        ? AppColors.neutralColor500
                        : AppColors.primaryColor700,
                    buttonTitle: 'addToCart'.tr(),
                    // onPressed: () {
                    //   print('=== ADD TO CART - SELECTED DATA ===');
                    //   print('Product ID: $productId');
                    //   print('Product Name: ${productDetails?.name ?? 'N/A'}');
                    //   print(
                    //       'Selected Price: ${selectedPrice ?? (productDetails?.variants?.isNotEmpty == true ? (productDetails!.variants!.first.priceAfterDiscount ?? productDetails.variants!.first.price ?? 0) : 0)}');
                    //   print('Selected Variants: $selectedVariants');
                    //
                    //   // ✅ Print stock from selected/matching variant
                    //   int stockAmount = 0;
                    //   if (productDetails?.variants != null) {
                    //     // Find matching variant
                    //     for (var variant in productDetails!.variants!) {
                    //       bool isMatch = true;
                    //       for (var attr in variant.attributes ?? []) {
                    //         final selectedValue = selectedVariants[attr.name];
                    //         if (selectedValue == null ||
                    //             selectedValue != attr.value) {
                    //           isMatch = false;
                    //           break;
                    //         }
                    //       }
                    //       if (isMatch) {
                    //         stockAmount = variant.stockAmount ?? 0;
                    //         break;
                    //       }
                    //     }
                    //     // If no match found, use first variant
                    //     if (stockAmount == 0 &&
                    //         productDetails.variants!.isNotEmpty) {
                    //       stockAmount =
                    //           productDetails.variants!.first.stockAmount ?? 0;
                    //     }
                    //   }
                    //   print('Stock Available: $stockAmount');
                    //
                    //   // Print each variant selection in detail
                    //   if (selectedVariants.isNotEmpty) {
                    //     print('\n--- Variant Details ---');
                    //     selectedVariants.forEach((variantType, selectedValue) {
                    //       print('$variantType: $selectedValue');
                    //     });
                    //   } else {
                    //     print('No variants selected');
                    //   }
                    //
                    //   // Find and print the matching variant details
                    //   if (productDetails?.variants != null &&
                    //       selectedVariants.isNotEmpty) {
                    //     print('\n--- Matching Variant Info ---');
                    //     for (var variant in productDetails!.variants!) {
                    //       bool isMatch = true;
                    //
                    //       for (var attr in variant.attributes ?? []) {
                    //         final selectedValue = selectedVariants[attr.name];
                    //         if (selectedValue == null ||
                    //             selectedValue != attr.value) {
                    //           isMatch = false;
                    //           break;
                    //         }
                    //       }
                    //
                    //       if (isMatch) {
                    //         print('Variant SKU: ${variant.sku ?? 'N/A'}');
                    //         print('Variant Price: ${variant.price ?? 'N/A'}');
                    //         // print('Variant Stock: ${variant.stock ?? 'N/A'}');
                    //         print('Variant Attributes:');
                    //         for (var attr in variant.attributes ?? []) {
                    //           print('  - ${attr.name}: ${attr.value}');
                    //         }
                    //         break;
                    //       }
                    //     }
                    //   }
                    //
                    //   print('================================\n');
                    // },
                    //   onPressed: () {
                    //     if (productDetails?.variants == null || productDetails!.variants!.isEmpty) {
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         const SnackBar(content: Text("❌ No variants available")),
                    //       );
                    //       return;
                    //     }
                    //
                    //     if (selectedVariants.isEmpty) {
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         const SnackBar(content: Text("⚠️ Please select product options")),
                    //       );
                    //       return;
                    //     }
                    //
                    //     Variants? matchingVariant;
                    //     try {
                    //       matchingVariant = productDetails!.variants!.firstWhere((variant) {
                    //         for (var attr in variant.attributes ?? []) {
                    //           final selectedValue = selectedVariants[attr.name];
                    //           if (selectedValue == null || selectedValue != attr.value) {
                    //             return false;
                    //           }
                    //         }
                    //         return true;
                    //       });
                    //     } catch (e) {
                    //       matchingVariant = null; // no match found
                    //     }
                    //
                    //     if (matchingVariant == null) {
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         const SnackBar(content: Text("❌ No matching variant found")),
                    //       );
                    //       return;
                    //     }
                    //
                    //     // ✅ Add to cart
                    //     cartCubit.addProductToCart(
                    //       productId: productId,
                    //       quantity: 1,
                    //       variantSku: matchingVariant.sku!,
                    //     );
                    //
                    //     // ✅ Show success
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         content: Text(
                    //           "✅ Added to cart: ${matchingVariant.sku} - ${matchingVariant.priceAfterDiscount ?? matchingVariant.price}",
                    //         ),
                    //         backgroundColor: Colors.green,
                    //       ),
                    //     );
                    //
                    //     // (Optional) Print all attributes for debugging
                    //     debugPrint("🟢 Variant Selected: ${matchingVariant.sku}");
                    //     for (var attr in matchingVariant.attributes ?? []) {
                    //       debugPrint("  - ${attr.name}: ${attr.value}");
                    //     }
                    //   },
                    onPressed: _getStockAmount(
                        productDetails, cubit.selectedVariants) <=
                        0
                        ? () {} : () {
                      if (productDetails?.variants == null ||
                          productDetails!.variants!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("❌ No variants available")),
                        );
                        return;
                      }

                      if (selectedVariants.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("⚠️ Please select at least one option")),
                        );
                        return;
                      }

                      // 🔎 Find all variants that match ANY of the selected attributes
                      final matchingVariants =
                          productDetails!.variants!.where((variant) {
                        for (var attr in variant.attributes ?? []) {
                          final selectedValue = selectedVariants[attr.name];
                          if (selectedValue != null &&
                              selectedValue == attr.value) {
                            return true; // ✅ at least one attribute matched
                          }
                        }
                        return false;
                      }).toList();

                      if (matchingVariants.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("❌ No variant matches your selection")),
                        );

                        return;
                      }

                      // ✅ For now, just take the first matching variant
                      final selectedVariant = matchingVariants.first;

                      // Add to cart
                      cartCubit.addProductToCart(
                        productId: widget.productId,
                        quantity: 1,
                        variantSku: selectedVariant.sku!,
                      );

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text(
                      //       "✅ Added to cart: ${selectedVariant.sku} - ${selectedVariant.priceAfterDiscount ?? selectedVariant.price}",
                      //     ),
                      //     backgroundColor: Colors.green,
                      //   ),
                      // );
                      ToastManager.showCustomToast(message: 'addToCart'.tr(), backgroundColor: AppColors.greenColor200);

                      // Debug print all variants that matched
                      debugPrint(
                          "🟢 Matching Variants Found: ${matchingVariants.length}");
                      for (var v in matchingVariants) {
                        debugPrint("Variant SKU: ${v.sku}");
                        for (var attr in v.attributes ?? []) {
                          debugPrint("  - ${attr.name}: ${attr.value}");
                        }
                      }
                    }

                    // onPressed: () {
                    //   print('All Attributes is ${productDetails?.variants?[1].attributes?[1].value}');
                    //   if (productDetails?.variants != null &&
                    //       selectedVariants.isNotEmpty) {
                    //     print('\n--- Matching Variant Info ---');
                    //     for (var variant in productDetails!.variants!) {
                    //       bool isMatch = true;
                    //
                    //       for (var attr in variant.attributes ?? []) {
                    //         final selectedValue = selectedVariants[attr.name];
                    //         if (selectedValue == null ||
                    //             selectedValue != attr.value) {
                    //           isMatch = false;
                    //           break;
                    //         }
                    //       }
                    //
                    //       if (isMatch) {
                    //         print('Variant SKU: ${variant.sku ?? 'N/A'}');
                    //         print('Variant Price: ${variant.price ?? 'N/A'}');
                    //         // print('Variant Stock: ${variant.stock ?? 'N/A'}');
                    //         cartCubit.addProductToCart(
                    //           productId: productId,
                    //           quantity: 1,
                    //           variantSku: variant.sku!,
                    //         );
                    //         print('Variant Attributes:');
                    //         for (var attr in variant.attributes ?? []) {
                    //           print('  - ${attr.name}: ${attr.value}');
                    //         }
                    //         break;
                    //       }
                    //     }
                    //   }
                    // },
                    );
              },
            );
          },
        ),
      ),
    );
  }
}

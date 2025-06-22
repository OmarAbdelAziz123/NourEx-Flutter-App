import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';

class CustomDropdownButtonWidget<T> extends StatefulWidget {
  final String? hint;
  final List<T> items;
  final bool isString;
  final String Function(T)? getItemText;
  final String Function(T)? getItemIcon;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;
  final T? value; // Add this line

  const CustomDropdownButtonWidget({
    super.key,
    this.hint,
    this.isString = true,
    required this.items,
    this.getItemText,
    this.getItemIcon,
    this.onChanged,
    this.validator,
    this.value, // Add this line
  });

  @override
  _CustomDropdownButtonWidgetState<T> createState() =>
      _CustomDropdownButtonWidgetState<T>();
}

class _CustomDropdownButtonWidgetState<T>
    extends State<CustomDropdownButtonWidget<T>>
    with SingleTickerProviderStateMixin {
  T? selectedValue;
  bool isDropdownOpen = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
      if (isDropdownOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: toggleDropdown,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.neutralColor300, width: 1.w),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (selectedValue != null && widget.getItemIcon != null)
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Row(
                          children: [
                            if (widget.getItemIcon != null)
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10.w,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedValue = null;
                                    });
                                    widget.onChanged!(selectedValue);
                                  },
                                  child: SvgPicture.asset(
                                      'assets/images/svgs/close_icon.svg',
                                  ),
                                ),
                              ),
                            CachedNetworkImage(
                              imageUrl: widget.getItemIcon!(selectedValue as T),
                              width: 24.w,
                              height: 24.h,
                              fit: BoxFit.contain,   errorWidget: (context, url, error) => Center(
            child: Icon(Icons.error),
          ),
                            ),
                          ],
                        ),
                      ),
                    10.horizontalSpace,
                    Text(
                      selectedValue == null
                          ? (widget.hint ?? "Select an option")
                          : (widget.isString
                              ? selectedValue.toString()
                              : widget.getItemText!(selectedValue as T)),
                      style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                AnimatedRotation(
                  turns: isDropdownOpen ? 0.5 : 0, // Rotates 180° when open
                  duration: Duration(milliseconds: 300),
                  child: SvgPicture.asset('assets/images/svgs/arrow-down_icon.svg'),
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _fadeAnimation,
          axisAlignment: -1.0,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              margin: EdgeInsets.only(top: 5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border:
                    Border.all(color: AppColors.neutralColor300, width: 1.w),
                color: Colors.white,
              ),
              child: Column(
                children: widget.items.map((T item) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedValue = item;
                        isDropdownOpen = false;
                      });
                      _animationController.reverse();
                      if (widget.onChanged != null) widget.onChanged!(item);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      child: Row(
                        children: [
                          if (widget.getItemIcon != null)
                            Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              // child: CachedNetworkImage(
                              //   imageUrl: widget.getItemIcon!(item),
                              //   width: 24.w,
                              //   height: 24.h,
                              //   fit: BoxFit.contain,
                              // ),
                              child: CacheNetworkImagesWidget(
                                image: widget.getItemIcon!(item),
                                width: 24.w,
                                height: 24.h,
                                boxFit: BoxFit.contain,
                              ),
                            ),
                          10.horizontalSpace,
                          Expanded(
                            child: Text(
                              widget.isString
                                  ? item.toString()
                                  : widget.getItemText!(item),
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Radio<T>(
                            value: item,
                            visualDensity: VisualDensity.compact,
                            groupValue: widget.value,
                            onChanged: (T? newValue) {
                              setState(() {
                                selectedValue = newValue;
                                isDropdownOpen = false;
                              });
                              _animationController.reverse();
                              if (widget.onChanged != null) {
                                widget.onChanged!(newValue);
                              }
                            },
                            activeColor: Color(0xFF006638),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

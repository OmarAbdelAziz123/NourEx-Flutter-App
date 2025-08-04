import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                onTabChanged(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: isSelected ? 1.5.w : 1.w,
                      color: isSelected
                          ? AppColors.primaryColor700
                          : AppColors.neutralColor300,
                    ),
                  ),
                ),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  style: Styles.highlightEmphasis.copyWith(
                    color: isSelected
                        ? AppColors.primaryColor700
                        : AppColors.neutralColor600,
                  ),
                  child: Text(
                    tabs[index],
                    textAlign: TextAlign.center,
                    style: Styles.highlightEmphasis.copyWith(
                      color: isSelected
                          ? AppColors.primaryColor700
                          : AppColors.neutralColor600,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CustomTabBarWidget2 extends StatefulWidget {
  const CustomTabBarWidget2({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabChanged;

  @override
  State<CustomTabBarWidget2> createState() => _CustomTabBarWidget2State();
}

class _CustomTabBarWidget2State extends State<CustomTabBarWidget2>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(CustomTabBarWidget2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            children: widget.tabs.asMap().entries.map((entry) {
              final index = entry.key;
              final title = entry.value;
              final isSelected = widget.selectedIndex == index;

              return Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => widget.onTabChanged(index),
                    borderRadius: BorderRadius.circular(4.r),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: Styles.highlightEmphasis.copyWith(
                          color: isSelected
                              ? AppColors.primaryColor700
                              : AppColors.neutralColor600,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 2.h),
          Stack(
            children: [
              // Background line
              Container(
                height: 1.h,
                width: double.infinity,
                color: AppColors.neutralColor300,
              ),
              // Animated indicator
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final tabWidth = (MediaQuery.of(context).size.width - 32.w) / widget.tabs.length;
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: widget.selectedIndex * tabWidth,
                    child: Container(
                      height: 2.h,
                      width: tabWidth,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor700,
                        borderRadius: BorderRadius.circular(1.r),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class CustomTabBarWidget extends StatelessWidget {
//   final List<String> tabs;
//   final int selectedIndex;
//   final ValueChanged<int> onTabChanged;
//
//   const CustomTabBarWidget({
//     super.key,
//     required this.tabs,
//     required this.selectedIndex,
//     required this.onTabChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: List.generate(tabs.length, (index) {
//           final isSelected = selectedIndex == index;
//
//           return Expanded(
//             child: GestureDetector(
//               onTap: () => onTabChanged(index),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   18.verticalSpace,
//                   Text(
//                     tabs[index],
//                     textAlign: TextAlign.center,
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                     style: Styles.highlightEmphasis.copyWith(
//                       color: isSelected
//                           ? AppColors.primaryColor700
//                           : AppColors.neutralColor600,
//                     ),
//                   ),
//                   6.verticalSpace,
//                   Container(
//                     height: 2.h,
//                     width: 30.w,
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? AppColors.primaryColor700
//                           : Colors.transparent,
//                       borderRadius: BorderRadius.circular(2.r),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

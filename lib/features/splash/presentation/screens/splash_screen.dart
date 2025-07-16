import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/cache_helper/cache_helper.dart';
import 'package:nourex/core/cache_helper/cache_keys.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;

  late Animation<double> _logoAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Create animations
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.bounceOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    // Start animations sequence
    _startAnimations();
  }

  void _startAnimations() async {
    // Start background fade
    _fadeController.forward();

    // Wait a bit then start logo animation
    await Future.delayed(const Duration(milliseconds: 300));
    _scaleController.forward();

    // Start logo bounce animation
    await Future.delayed(const Duration(milliseconds: 200));
    _logoController.forward();

    // Auto-navigate after splash (optional)
    Future.delayed(const Duration(milliseconds: 3000), () async {
        String? token = await CacheHelper.getSecuredString(key: CacheKeys.userToken);

        if (token == null) {
          if (mounted) context.pushNamedAndRemoveUntil(Routes.chooseLoginOrRegisterScreen);
        } else {
          if (mounted) context.pushNamed(Routes.mainLayoutScreen);
        }

    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _logoAnimation,
          _fadeAnimation,
          _scaleAnimation,
        ]),
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.grey.shade50.withOpacity(_fadeAnimation.value),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Animated background circles
                ...List.generate(3, (index) {
                  return Positioned(
                    top: 100.h + (index * 50),
                    left: -50 + (index * 30),
                    child: Opacity(
                      opacity: _fadeAnimation.value * 0.1,
                      child: Container(
                        width: 200.w + (index * 50),
                        height: 200.h + (index * 50),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: const Color(0xFF4CAF50).withOpacity(0.1),
                          color: AppColors.primaryColor700.withAlpha(60),
                        ),
                      ),
                    ),
                  );
                }),

                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo with animations
                      Transform.scale(
                        scale:
                            _scaleAnimation.value *
                            (1 +
                                (_pulseAnimation.value - 1) *
                                    _logoAnimation.value),
                        child: Opacity(
                          opacity: _logoAnimation.value.clamp(0.0, 1.0),
                          child: Container(
                            width: 120.w,
                            height: 120.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              // color: const Color(0xFF4CAF50),
                              color: AppColors.primaryColor700,
                              boxShadow: [
                                BoxShadow(
                                  // color: const Color(
                                  //   0xFF4CAF50,
                                  // ).withOpacity(0.3),
                                  color: AppColors.primaryColor700.withAlpha(60),
                                  spreadRadius: 2,
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'N',
                                // style: TextStyle(
                                //   fontSize: 48.sp,
                                //   fontWeight: FontWeight.bold,
                                //   color: Colors.white,
                                // ),
                                style: Styles.display1.copyWith(
                                  color: Colors.white,
                                  fontSize: 48.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // App name with slide animation
                      Transform.translate(
                        offset: Offset(0, 30 * (1 - _logoAnimation.value)),
                        child: Opacity(
                          opacity: _logoAnimation.value.clamp(0.0, 1.0),
                          child: Text(
                            'Noorex',
                            // style: TextStyle(
                            //   fontSize: 28.sp,
                            //   fontWeight: FontWeight.bold,
                            //   color: const Color(0xFF333333),
                            //   letterSpacing: 1.2,
                            // ),
                            style: Styles.heading1.copyWith(
                              letterSpacing: 1.2,
                              color: AppColors.primaryColor700,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Subtitle with delayed animation
                      Transform.translate(
                        offset: Offset(0, 20 * (1 - _logoAnimation.value)),
                        child: Opacity(
                          opacity: (_logoAnimation.value * 0.8).clamp(0.0, 1.0),
                          child: Text(
                            'أحدث طريقة التسجيل الخاصة بك',
                            // style: TextStyle(
                            //   fontSize: 14.sp,
                            //   color: const Color(0xFF666666),
                            //   fontWeight: FontWeight.w400,
                            // ),
                            style: Styles.highlightSemiBold.copyWith(
                              color: AppColors.neutralColor600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Loading indicator at bottom
                Positioned(
                  bottom: 80.h,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 40.w,
                          height: 40.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              // const Color(0xFF4CAF50).withOpacity(0.7),
                              AppColors.primaryColor700.withAlpha(150),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'جاري التحميل...',
                          style: Styles.captionRegular.copyWith(
                            color: AppColors.neutralColor600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

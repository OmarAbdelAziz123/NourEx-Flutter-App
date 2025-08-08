import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/text/expandable_text_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'aboutUs'.tr(),
          isSubScreen: true,
          haveOnlyNotification: false,
          onTapBack: () {
            context.pop();
          },
          onTapSearch: () {},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('about'.tr(), style: Styles.highlightEmphasis),
              8.verticalSpace,

              ExpandableTextWidget(
                text:
                '''
🏬 حول نوريكس
نوريكس (Noorex) هو تطبيق تسوّق إلكتروني سوري صُمم خصيصًا ليوفّر لك تجربة شراء سهلة، آمنة، ومناسبة لواقعنا المحلي. نحن نربط بينك وبين مجموعة واسعة من المتاجر المحلية الموثوقة، لتختار المنتجات التي تحتاجها وتطلبها بخطوات بسيطة، مع إمكانية الدفع عند الاستلام وخدمة التوصيل إلى باب المنزل.

🎯 رؤيتنا
أن نكون المنصة الرائدة للتجارة الإلكترونية في سوريا، ونساهم في تطوير تجربة التسوق الرقمي بطريقة تليق بالمستخدم السوري وتدعم الاقتصاد المحلي.

🧭 رسالتنا
نوفّر للمستخدمين وسيلة تسوّق موثوقة وبسيطة، وللتجار المحليين مساحة لعرض منتجاتهم والوصول إلى زبائن جدد في مختلف المحافظات.

✅ ماذا يميز نوريكس؟
منتجات متنوعة: من متاجر محلية موثوقة في مختلف المحافظات.
الدفع عند الاستلام: لا حاجة لبطاقات مصرفية أو تحويلات.
توصيل مباشر: عبر شركاء توصيل موثوقين، أو من البائع نفسه.
واجهة سهلة الاستخدام: مصمّمة لتسهيل عملية التسوّق للجميع.
دعم محلي حقيقي: نوريكس ليس منصة أجنبية، بل مبادرة سورية بالكامل لخدمة السوق السوري.

🔒 الأمان والخصوصية
نحن نأخذ خصوصيتك على محمل الجد. جميع بياناتك الشخصية (مثل رقم الهاتف والعنوان) تُستخدم فقط لتنفيذ طلباتك، ولا تتم مشاركتها مع أي جهة خارجية غير مخوّلة. يمكنك دائمًا مراجعة [سياسة الخصوصية] داخل التطبيق لمعرفة المزيد.

ℹ️ توضيحات مهمة
نوريكس لا يبيع منتجاته الخاصة، بل هو وسيط رقمي بينك وبين البائع.
نحرص على اختيار المتاجر الموثوقة، لكن في حال واجهت أي مشكلة، فريق الدعم مستعد للمساعدة.
نحن نعمل باستمرار على تطوير المنصة، وسنُضيف قريبًا ميزات مثل:
تتبّع الطلبات.
الدفع الإلكتروني.
تقييم المتاجر.

📞 تواصل معنا
إذا واجهت أي مشكلة أو عندك استفسار، لا تتردد في التواصل معنا من خلال:
قسم الدعم داخل التطبيق.
البريد الإلكتروني: nour.noorex@gmail.com

أو صفحاتنا الرسمية على وسائل التواصل الاجتماعي.

🚀 المستقبل معنا
نحن في بداية طريق طويل، ونخطط للتوسّع تدريجيًا لتغطية جميع المحافظات السورية، وتحسين الخدمة باستمرار. بدعمكم، نوريكس رح يكون اسم رائد في عالم التسوّق الإلكتروني السوري.

شكرًا لاختيارك نوريكس ❤️ نعدك بأن نسعى دائمًا لنكون عند حسن ظنّك.

                ''',
                mainTextStyle: Styles.contentEmphasis.copyWith(
                  letterSpacing: 0.5.w,
                  height: 1.5.h,

                ),
                subTextStyles: Styles.contentEmphasis.copyWith(
                  decoration: TextDecoration.underline,
                  decorationThickness: 1.w,
                ),
              ),
              44.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'termsAndConditions'.tr(),
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
              Text(
                isArabic ?
                '''
شروط وأحكام استخدام تطبيق نوريكس
مرحبًا بكم في تطبيق نوريكس، منصة إلكترونية تتيح للمستخدمين شراء وبيع المنتجات ضمن الجمهورية العربية السورية. باستخدامك للتطبيق، فإنك توافق على الالتزام بهذه الشروط والأحكام. نذكّر أن جميع الأنشطة ضمن التطبيق يجب أن تكون متوافقة مع القوانين المحلية، ومع الضوابط الشرعية الإسلامية، ونرفض أي محتوى يخالف ذلك.
1. التعريفات
- المستخدم: أي شخص يستخدم التطبيق سواء كمشتري أو كبائع. - البائع: أي شخص أو جهة تقوم بعرض منتجاتها على منصة نوريكس. - المشتري: أي شخص يستخدم التطبيق لشراء منتجات. - نوريكس: المنصة التي تدير التطبيق وتوفر خدماته.
2. التسجيل واستخدام الحساب
يجب أن يكون عمر المستخدم 18 سنة أو أكثر. يلتزم المستخدم بإدخال معلومات صحيحة. لا يجوز مشاركة معلومات الدخول مع أطراف أخرى.
3. التزامات البائعين
 - يجب أن تكون المنتجات قانونية ومطابقة للشريعة الإسلامية. - يُمنع منعًا باتًا عرض أو بيع أي منتجات محرّمة شرعًا مثل: الخمور، التماثيل الدينية، المواد الإباحية... - في حال المخالفة: يتم حذف المنتج، إرسال إنذار، وحظر الحساب عند التكرار. - يلتزم البائع بالشحن في الموعد، بجودة المنتج، ودفع الرسوم الشهرية والعمولات. 
4. الدفع والتوصيل
يتم الدفع نقدًا عند الاستلام. التوصيل عبر شركات توصيل أو من قبل البائع. الرسوم تختلف حسب المنطقة.
5. الإرجاع والاسترداد
يحق للمشتري الإرجاع وفق سياسة البائع ويتحمل رسوم الشحن. لا تُحتسب عمولة نوريكس على المرتجعات.
6. حقوق الملكية
جميع المحتويات ملك لنوريكس ولا يجوز استخدامها دون إذن. المحتوى المقدم يجب ألا ينتهك حقوق الآخرين.
7. حدود المسؤولية
نوريكس غير مسؤولة عن مشاكل ناتجة عن تعامل مباشر بين المستخدمين.
8. تعديل الشروط
تحتفظ نوريكس بحق تعديل الشروط في أي وقت بعد إشعار المستخدمين.
9. القانون الناظم
تخضع الشروط للقوانين السورية. النزاعات تُحل في محاكم حمص.
10. الخصوصية
نوريكس تلتزم بحماية بيانات المستخدمين وعدم مشاركتها إلا لتقديم الخدمة أو بطلب قانوني.
11. إساءة الاستخدام
يمنع استخدام التطبيق لأغراض غير قانونية أو احتيالية.
12. رفض الاستلام المتكرر
يحق لنوريكس تعليق حساب أي مستخدم يرفض الطلبات بدون سبب مقنع أكثر من مرة.
13. التقييمات
يسمح بالتقييمات بشرط أن تكون لائقة وغير مسيئة. تحتفظ نوريكس بحق الحذف.
14. تعديل الأسعار والرسوم
يحق لنوريكس تعديل العمولات بعد إشعار مسبق لا يقل عن 15 يومًا.
                '''
                : '''
Welcome to Noorex, an electronic platform that enables users to buy and sell products within the Syrian Arab Republic. By using the application, you agree to abide by these terms and conditions. We remind you that all activities within the application must comply with local laws and Islamic Sharia regulations, and we reject any content that violates these standards.
1. Definitions

User: Any individual using the application, whether as a buyer or seller.
Seller: Any person or entity offering products on the Noorex platform.
Buyer: Any person using the application to purchase products.
Noorex: The platform that manages the application and provides its services.

2. Registration and Account Usage

Users must be 18 years or older.
Users must provide accurate information.
Sharing login credentials with third parties is prohibited.

3. Seller Obligations

Products must be legal and compliant with Islamic Sharia.
It is strictly forbidden to offer or sell products prohibited by Sharia, such as alcohol, religious statues, pornographic materials, etc.
In case of violation: The product will be removed, a warning issued, and the account will be banned upon repeated violations.
Sellers are responsible for shipping on time, ensuring product quality, and paying monthly fees and commissions.

4. Payment and Delivery

Payment is made via cash on delivery.
Delivery is handled through delivery companies or by the seller.
Fees vary depending on the region.

5. Returns and Refunds

Buyers have the right to return products according to the seller’s policy, bearing the shipping costs.
Noorex does not charge a commission on returns.

6. Intellectual Property Rights

All content belongs to Noorex and may not be used without permission.
Content provided by users must not infringe on the rights of others.

7. Limitation of Liability

Noorex is not responsible for issues arising from direct interactions between users.

8. Modification of Terms

Noorex reserves the right to modify these terms at any time after notifying users.

9. Governing Law

These terms are subject to Syrian laws. Disputes will be resolved in the courts of Homs.

10. Privacy

Noorex is committed to protecting user data and will not share it except to provide services or when required by law.

11. Misuse

Using the application for illegal or fraudulent purposes is prohibited.

12. Repeated Refusal of Delivery

Noorex reserves the right to suspend the account of any user who repeatedly refuses orders without a valid reason.

13. Reviews

Reviews are allowed provided they are appropriate and non-offensive. Noorex reserves the right to remove reviews.

14. Price and Fee Adjustments

Noorex reserves the right to adjust commissions after providing at least 15 days’ prior notice.
                ''',
                style: Styles.contentRegular,
              ),
              44.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

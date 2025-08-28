import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'privacyPolicy'.tr(),
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
                isArabic
                ? '''
سياسة الخصوصية – منصة نوريكس
آخر تحديث: [يرجى إدخال التاريخ]
نحن في نوريكس نولي أهمية قصوى لحماية خصوصيتك وبياناتك الشخصية. توضح سياسة الخصوصية هذه كيف نقوم بجمع واستخدام وحماية المعلومات الخاصة بك عند استخدامك لتطبيقنا أو موقعنا الإلكتروني أو لوحة التحكم الخاصة بنا، سواء كمستخدم أو كتاجر.

1. المعلومات التي نجمعها
أ. بيانات المستخدمين:
الاسم الكامل
رقم الهاتف
عنوان التوصيل
تفاصيل الطلبات والمشتريات
أي معلومات يتم إدخالها أثناء استخدام التطبيق
ب. بيانات التجار:
الاسم الكامل
رقم الهاتف والبريد الإلكتروني
عنوان المتجر
رقم الهوية (إن وُجد)
معلومات الحساب البنكي (عند تفعيل التحويلات)
تفاصيل المنتجات والمبيعات والعمولات
ج. بيانات الموقع الجغرافي (إن وُجد):
قد نقوم بجمع بيانات الموقع الجغرافي لتسهيل عمليات التوصيل أو عرض المنتجات المتاحة ضمن منطقتك.

2. استخدام المعلومات
نستخدم المعلومات التي نجمعها من أجل:
تنفيذ الطلبات وتوصيل المنتجات.
التواصل معك بشأن مشترياتك أو حسابك.
إدارة حسابات المستخدمين والتجار.
تسوية الأرباح والعمولات والمستحقات.
تحسين جودة الخدمات والتجربة العامة على المنصة.
حماية المنصة من الاحتيال أو الاستخدام غير المشروع.
إرسال تنبيهات أو إشعارات مهمة (مثل التنبيهات المالية أو تحديثات الحساب).

3. مشاركة المعلومات
لا نشارك معلوماتك الشخصية مع أي طرف ثالث، باستثناء الحالات التالية:
مع شركات التوصيل لتنفيذ وتسليم الطلبات.
مع التجار لتأكيد الطلبات ومعالجة المرتجعات.
مع الجهات القانونية إذا طُلب منا ذلك رسميًا بموجب القانون.
مع مزودي الخدمات المرتبطين بالتطبيق (مثل خدمات الدفع الإلكتروني مستقبلًا)، ضمن الحدود الضرورية لتقديم الخدمة.

4. ملفات تعريف الارتباط (Cookies)
نستخدم ملفات تعريف الارتباط لتحسين تجربتك داخل التطبيق، مثل:
تذكر تفضيلاتك وإعداداتك.
حفظ حالة تسجيل الدخول.
تحليل استخدامك للتطبيق لتحسين الأداء.
يمكنك تعطيل ملفات الكوكيز من خلال إعدادات جهازك أو المتصفح، ولكن ذلك قد يؤثر على بعض وظائف المنصة.

5. حماية البيانات
نلتزم بحماية بياناتك الشخصية باستخدام تدابير أمنية مناسبة تقنيًا وتنظيميًا، بهدف منع الوصول غير المصرح به أو التلاعب أو التسريب أو الضياع. رغم ذلك، لا يمكن ضمان الحماية بنسبة 100% عبر الإنترنت.

6. سياسة البيانات للأطفال
منصة نوريكس غير مخصصة للأطفال دون سن 18 عامًا. لا نقوم بجمع بيانات من الأطفال عن قصد، وإذا اكتشفنا أننا جمعنا بيانات من قاصر دون موافقة ولي الأمر، سنقوم بحذفها فورًا.

7. الاحتفاظ بالبيانات
نحتفظ ببياناتك الشخصية طالما كانت لازمة لتقديم الخدمة، أو للامتثال للمتطلبات القانونية أو المحاسبية. عند طلب حذف الحساب، سنقوم بحذف البيانات خلال 30 يومًا، ما لم يكن هناك سبب قانوني للاحتفاظ بها.

8. الحماية من الاحتيال
نعمل باستمرار على تطوير وسائل الحماية والمراقبة الداخلية لاكتشاف ومنع أي محاولات احتيال أو إساءة استخدام مثل الطلبات المزورة، استخدام بيانات وهمية، أو التلاعب بنظام العمولات.

9. حقوقك كمستخدم
يحق لك:
الوصول إلى بياناتك الشخصية.
طلب تعديلها أو تصحيحها.
طلب حذف حسابك (ما لم يكن مرتبطًا بمستحقات مالية أو قيود قانونية).
سحب الموافقة على استخدام بياناتك في أي وقت، ضمن الحدود الممكنة.

10. التعديلات على سياسة الخصوصية
قد نقوم بتحديث هذه السياسة من وقت لآخر. سيتم إعلامك بأي تعديلات جوهرية من خلال التطبيق أو عبر البريد الإلكتروني. استمرار استخدامك للمنصة بعد نشر التعديلات يعني موافقتك على السياسة المحدّثة.

11. التواصل معنا
لأي استفسار بخصوص سياسة الخصوصية أو ممارسة حقوقك، يُرجى التواصل معنا عبر:
📧 البريد الإلكتروني: nour.noorex@gmail.com 📞 رقم الدعم: +963 997 485 516 أو من خلال مركز المساعدة داخل التطبيق.
                '''
                : '''
At Noorex, we place the utmost importance on protecting your privacy and personal information. This Privacy Policy explains how we collect, use, and safeguard your information when you use our application, website, or control panel, whether as a user or a merchant.
1. Information We Collect
a. User Information:

Full name
Phone number
Delivery address
Order and purchase details
Any information entered while using the application

b. Merchant Information:

Full name
Phone number and email address
Store address
ID number (if applicable)
Bank account details (when bank transfers are enabled)
Product, sales, and commission details

c. Location Data (if applicable):

We may collect geolocation data to facilitate delivery or display products available in your area.

2. Use of Information
We use the information we collect to:

Process and deliver orders.
Communicate with you regarding your purchases or account.
Manage user and merchant accounts.
Settle profits, commissions, and dues.
Improve the quality of services and the overall platform experience.
Protect the platform from fraud or misuse.
Send important alerts or notifications (e.g., financial alerts or account updates).

3. Sharing of Information
We do not share your personal information with third parties, except in the following cases:

With delivery companies to fulfill and deliver orders.
With merchants to confirm orders and process returns.
With legal authorities if formally required by law.
With service providers associated with the application (e.g., future electronic payment services), within the limits necessary to provide the service.

4. Cookies
We use cookies to enhance your experience within the application, such as:

Remembering your preferences and settings.
Maintaining login status.
Analyzing your app usage to improve performance.
You can disable cookies through your device or browser settings, but this may affect some platform functionalities.

5. Data Protection
We are committed to protecting your personal information using appropriate technical and organizational security measures to prevent unauthorized access, manipulation, leakage, or loss. However, no online system can guarantee 100% security.
6. Children's Data Policy
The Noorex platform is not intended for children under 18 years of age. We do not intentionally collect data from children, and if we discover that we have collected data from a minor without parental consent, we will delete it immediately.
7. Data Retention
We retain your personal information as long as necessary to provide the service or comply with legal or accounting requirements. Upon account deletion requests, we will delete your data within 30 days, unless there is a legal reason to retain it.
8. Fraud Protection
We continuously develop protective measures and internal monitoring to detect and prevent fraud or misuse, such as fake orders, use of false information, or manipulation of the commission system.
9. Your Rights as a User
You have the right to:

Access your personal information.
Request corrections or updates to your data.
Request deletion of your account (unless linked to financial obligations or legal restrictions).
Withdraw consent for the use of your data at any time, within applicable limits.

10. Changes to the Privacy Policy
We may update this policy from time to time. You will be notified of any significant changes through the application or via email. Continued use of the platform after the publication of updates constitutes your agreement to the updated policy.
11. Contact Us
For any inquiries regarding the Privacy Policy or to exercise your rights, please contact us via:

📧 Email: nour.noorex@gmail.com
📞 Support Number: +963 997 485 516
Or through the Help Center within the application.
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

# تطبيق استشارات الأطباء / Doctor Consultation App

<div dir="rtl">

تطبيق Flutter للاستشارات الطبية بين الأطباء، مصمم خصيصاً للتواصل المهني وتبادل الخبرات الطبية.

</div>

A Flutter application for medical consultation between doctors, designed specifically for professional communication and medical expertise exchange.

---

## 🌟 الميزات الرئيسية / Key Features

<div dir="rtl">

### 🔐 المصادقة والأمان
- تسجيل دخول آمن بالبريد الإلكتروني المهني
- حسابات مخصصة للأطباء فقط
- نظام استعادة كلمة المرور

### 👨‍⚕️ إدارة الأطباء
- تصفح الأطباء حسب التخصص
- 20 تخصص طبي مختلف
- بحث متقدم بالاسم والتخصص
- عرض معلومات الطبيب الكاملة

### 📋 نظام الاستشارات
- إرسال واستقبال الاستشارات الطبية
- إرفاق ملفات (صور، PDF)
- تتبع حالة الاستشارة
- الرد على الاستشارات
- سجل كامل للاستشارات

### 💬 الدردشة الفورية
- محادثات نصية فورية بين الأطباء
- إرسال الصور والملفات
- إشعارات فورية للرسائل الجديدة

### 🌐 دعم متعدد اللغات
- واجهة بالعربية والإنجليزية
- تبديل سلس بين اللغات
- دعم RTL للعربية

### 📱 واجهة مستخدم احترافية
- تصميم عصري ونظيف (Material Design 3)
- ألوان طبية احترافية
- استجابة لجميع أحجام الشاشات
- رسوم متحركة سلسة

</div>

---

## 🛠 التقنيات المستخدمة / Tech Stack

| المكون / Component | التقنية / Technology |
|-------------------|----------------------|
| **Framework** | Flutter 3.0+ |
| **Language** | Dart 3.0+ |
| **State Management** | Riverpod |
| **Navigation** | Go Router |
| **Backend** | Firebase |
| **Authentication** | Firebase Auth |
| **Database** | Cloud Firestore |
| **Storage** | Firebase Storage |
| **Notifications** | FCM |
| **Localization** | Easy Localization |

---

## 📁 بنية المشروع / Project Structure

```
doctor_consultation/
├── lib/
│   ├── core/              # الوظائف الأساسية
│   ├── data/              # نماذج البيانات
│   ├── domain/            # الخدمات
│   └── presentation/      # الشاشات والودجات
├── assets/                # الأصول (صور، ترجمات)
├── android/               # ملفات Android
└── ios/                   # ملفات iOS
```

<div dir="rtl">

📖 **للتفاصيل الكاملة:** راجع ملف [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)

</div>

📖 **For full details:** See [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)

---

## 🚀 البدء السريع / Quick Start

### المتطلبات / Prerequisites

```bash
# تحقق من تثبيت Flutter
# Check Flutter installation
flutter --version

# يجب أن يكون الإصدار 3.0.0 أو أحدث
# Version should be 3.0.0 or higher
```

### التثبيت / Installation

```bash
# 1. استنساخ المشروع
# Clone the repository
git clone <repository-url>
cd doctor_consultation

# 2. تثبيت التبعيات
# Install dependencies
flutter pub get

# 3. إعداد Firebase (راجع SETUP.md)
# Setup Firebase (see SETUP.md)

# 4. تشغيل التطبيق
# Run the app
flutter run
```

---

## ⚙️ إعداد Firebase / Firebase Setup

<div dir="rtl">

### الخطوات الأساسية:

1. **إنشاء مشروع Firebase**
   - اذهب إلى [Firebase Console](https://console.firebase.google.com/)
   - أنشئ مشروع جديد

2. **تفعيل الخدمات المطلوبة:**
   - ✅ Authentication (Email/Password)
   - ✅ Cloud Firestore
   - ✅ Firebase Storage
   - ✅ Cloud Messaging

3. **إضافة ملفات التكوين:**
   - Android: `google-services.json` في `android/app/`
   - iOS: `GoogleService-Info.plist` في `ios/Runner/`

4. **تشغيل FlutterFire CLI:**
   ```bash
   flutter pub global activate flutterfire_cli
   flutterfire configure
   ```

📖 **دليل الإعداد الكامل:** راجع ملف [SETUP.md](SETUP.md)

</div>

📖 **Complete Setup Guide:** See [SETUP.md](SETUP.md)

---

## 📱 لقطات الشاشة / Screenshots

<div dir="rtl">

| الشاشة الرئيسية | الاستشارات | الدردشة | الملف الشخصي |
|-----------------|------------|---------|--------------|
| (قريباً) | (قريباً) | (قريباً) | (قريباً) |

</div>

---

## 📚 التوثيق / Documentation

| الملف / File | الوصف / Description |
|-------------|---------------------|
| [README.md](README.md) | الملف التوثيقي الرئيسي / Main documentation |
| [SETUP.md](SETUP.md) | دليل الإعداد والتشغيل / Setup and installation guide |
| [FEATURES.md](FEATURES.md) | قائمة الميزات الكاملة / Complete features list |
| [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) | بنية المشروع التفصيلية / Detailed project structure |

---

## 🔒 الأمان / Security

<div dir="rtl">

- ✅ تشفير جميع البيانات
- ✅ قواعد أمان Firestore و Storage
- ✅ مصادقة آمنة عبر Firebase Auth
- ✅ التحقق من صحة المدخلات
- ✅ وصول محدود للبيانات

</div>

---

## 🌍 اللغات المدعومة / Supported Languages

- 🇸🇦 العربية (Arabic)
- 🇬🇧 الإنجليزية (English)

---

## 🚀 البناء للإنتاج / Production Build

### Android
```bash
# APK
flutter build apk --release

# App Bundle (للنشر على Google Play)
# App Bundle (for Google Play Store)
flutter build appbundle --release
```

### iOS
```bash
# يتطلب macOS و Xcode
# Requires macOS and Xcode
flutter build ios --release
```

---

## 🧪 الاختبار / Testing

```bash
# تشغيل الاختبارات
# Run tests
flutter test

# فحص الكود
# Code analysis
flutter analyze
```

---

## 🤝 المساهمة / Contributing

<div dir="rtl">

هذا مشروع تعليمي. للمساهمة:
1. Fork المشروع
2. أنشئ فرع للميزة الجديدة
3. Commit التغييرات
4. Push للفرع
5. افتح Pull Request

</div>

This is an educational project. To contribute:
1. Fork the project
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

---

## 📝 الترخيص / License

<div dir="rtl">

مشروع خاص - جميع الحقوق محفوظة

</div>

Private project - All rights reserved

---

## 📞 التواصل / Contact

<div dir="rtl">

للأسئلة والاستفسارات:
- البريد الإلكتروني: support@doctorconsult.com
- الموقع: www.doctorconsult.com

</div>

For questions and inquiries:
- Email: support@doctorconsult.com
- Website: www.doctorconsult.com

---

## 🙏 شكر وتقدير / Acknowledgments

<div dir="rtl">

- Flutter Team لإطار العمل الرائع
- Firebase لخدمات Backend المتكاملة
- المجتمع البرمجي للدعم والمساهمات

</div>

- Flutter Team for the amazing framework
- Firebase for integrated backend services
- The developer community for support and contributions

---

<div align="center">

**صُنع بـ ❤️ باستخدام Flutter**

**Made with ❤️ using Flutter**

</div>


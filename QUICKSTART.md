# دليل البدء السريع / Quick Start Guide

<div dir="rtl">

## 🚀 البدء السريع (5 دقائق)

### الخطوة 1: تثبيت المتطلبات

1. **تثبيت Flutter:**
   ```bash
   # تحقق من التثبيت
   flutter --version
   ```
   يجب أن يكون الإصدار 3.0.0 أو أحدث

2. **تحميل التبعيات:**
   ```bash
   cd appconsult
   flutter pub get
   ```

### الخطوة 2: إعداد Firebase (أهم خطوة!)

#### أ. إنشاء مشروع Firebase
1. اذهب إلى https://console.firebase.google.com/
2. انقر "Add project"
3. أدخل اسم المشروع: `doctor-consultation`
4. فعّل Google Analytics (اختياري)
5. انقر "Create project"

#### ب. إضافة تطبيق Android
1. في Firebase Console، انقر على أيقونة Android
2. أدخل Package name: `com.example.doctor_consultation`
3. نزّل ملف `google-services.json`
4. ضع الملف في: `android/app/google-services.json`

#### ج. إضافة تطبيق iOS (اختياري)
1. في Firebase Console، انقر على أيقونة iOS
2. أدخل Bundle ID: `com.example.doctorConsultation`
3. نزّل ملف `GoogleService-Info.plist`
4. ضع الملف في: `ios/Runner/GoogleService-Info.plist`

#### د. تفعيل الخدمات المطلوبة

**1. Authentication:**
```
Firebase Console > Build > Authentication
- انقر "Get started"
- انقر "Sign-in method"
- فعّل "Email/Password"
- احفظ
```

**2. Firestore Database:**
```
Firebase Console > Build > Firestore Database
- انقر "Create database"
- اختر "Start in production mode"
- اختر Location (قريب من مستخدميك)
- انقر "Enable"
```

**3. Storage:**
```
Firebase Console > Build > Storage
- انقر "Get started"
- اختر "Start in production mode"
- انقر "Done"
```

**4. Cloud Messaging:**
```
Firebase Console > Build > Cloud Messaging
- الخدمة مفعلة افتراضياً
```

#### هـ. تحديث قواعد الأمان

**Firestore Rules:**
```
Firebase Console > Firestore Database > Rules
```
انسخ والصق:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    match /consultations/{consultationId} {
      allow read: if request.auth != null && 
        (resource.data.fromDoctorId == request.auth.uid || 
         resource.data.toDoctorId == request.auth.uid);
      allow create: if request.auth != null && 
        request.resource.data.fromDoctorId == request.auth.uid;
      allow update: if request.auth != null && 
        (resource.data.fromDoctorId == request.auth.uid || 
         resource.data.toDoctorId == request.auth.uid);
    }
    match /chats/{chatId} {
      allow read, write: if request.auth != null && 
        request.auth.uid in resource.data.participants;
      match /messages/{messageId} {
        allow read, write: if request.auth != null;
      }
    }
  }
}
```

**Storage Rules:**
```
Firebase Console > Storage > Rules
```
انسخ والصق:
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /profile_images/{userId}/{fileName} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    match /consultation_files/{allPaths=**} {
      allow read, write: if request.auth != null;
    }
    match /chat_files/{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

#### و. تحديث firebase_options.dart

استخدم FlutterFire CLI (الأسهل):
```bash
# تثبيت FlutterFire CLI
dart pub global activate flutterfire_cli

# تكوين Firebase تلقائياً
flutterfire configure
```

**أو** حدّث يدوياً ملف `lib/firebase_options.dart` بمعلومات مشروعك من Firebase Console > Project Settings.

### الخطوة 3: تشغيل التطبيق

```bash
# Android
flutter run

# iOS (يتطلب macOS)
flutter run -d ios
```

### الخطوة 4: إنشاء حساب تجريبي

1. افتح التطبيق
2. انقر "Sign Up"
3. أدخل المعلومات:
   - الاسم: د. أحمد علي
   - البريد: doctor@example.com
   - كلمة المرور: 123456
   - التخصص: Cardiology
4. انقر "Sign Up"
5. ستسجل دخول تلقائياً!

### الخطوة 5: اختبار الميزات

#### اختبار إرسال استشارة:
1. أنشئ حساب ثاني (طبيب آخر)
2. من الحساب الأول، اذهب للشاشة الرئيسية
3. اختر تخصص
4. انقر على بطاقة الطبيب الثاني
5. أرسل استشارة مع ملفات

#### اختبار الدردشة:
1. من الحساب الأول، انقر أيقونة الدردشة
2. ابدأ محادثة مع الطبيب الثاني
3. أرسل رسائل وملفات

---

## ⚡ حل المشاكل الشائعة

### مشكلة: "google-services.json not found"
**الحل:**
```bash
# تأكد من وجود الملف في المكان الصحيح
ls android/app/google-services.json
```

### مشكلة: "Firebase not initialized"
**الحل:**
1. تأكد من تشغيل `flutterfire configure`
2. تأكد من ملف `firebase_options.dart` موجود
3. أعد تشغيل التطبيق

### مشكلة: "Permission denied (Firestore)"
**الحل:**
1. تأكد من إضافة قواعد الأمان بشكل صحيح
2. تأكد من تسجيل الدخول قبل الوصول للبيانات

### مشكلة: "Build failed"
**الحل:**
```bash
flutter clean
flutter pub get
flutter run
```

---

## 📝 ملاحظات مهمة

### للتطوير:
- ✅ استخدم Android Studio أو VS Code
- ✅ فعّل Hot Reload للتطوير السريع
- ✅ استخدم Flutter DevTools للتصحيح

### للإنتاج:
- ⚠️ غيّر package name في `android/app/build.gradle`
- ⚠️ أضف توقيع للتطبيق (Android Signing)
- ⚠️ حدّث قواعد الأمان لتكون أكثر صرامة
- ⚠️ فعّل التحليلات (Analytics)

### الأمان:
- 🔒 لا تشارك `google-services.json`
- 🔒 لا تشارك `GoogleService-Info.plist`
- 🔒 أضف الملفات إلى `.gitignore`

---

## 🎯 الخطوات التالية

بعد التشغيل الناجح:

1. ✅ اقرأ [FEATURES.md](FEATURES.md) لمعرفة جميع الميزات
2. ✅ راجع [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) لفهم البنية
3. ✅ ابدأ بالتطوير والتخصيص
4. ✅ أضف ميزات جديدة حسب احتياجك

---

## 🆘 هل تحتاج مساعدة؟

### الموارد:
- 📚 [Flutter Docs](https://docs.flutter.dev/)
- 🔥 [Firebase Docs](https://firebase.google.com/docs)
- 🎓 [Riverpod Docs](https://riverpod.dev/)

### الدعم:
- 💬 افتح issue على GitHub
- 📧 راسلنا: support@doctorconsult.com
- 📱 اتصل بالدعم الفني

---

## ✅ قائمة التحقق

قبل البدء، تأكد من:

- [ ] تثبيت Flutter 3.0+
- [ ] إنشاء مشروع Firebase
- [ ] إضافة google-services.json
- [ ] تفعيل Authentication
- [ ] تفعيل Firestore
- [ ] تفعيل Storage
- [ ] إضافة قواعد الأمان
- [ ] تشغيل flutterfire configure
- [ ] تشغيل flutter pub get
- [ ] تشغيل التطبيق بنجاح

---

</div>

## 🚀 Quick Start (5 Minutes)

### Step 1: Install Requirements

1. **Install Flutter:**
   ```bash
   # Check installation
   flutter --version
   ```
   Version should be 3.0.0 or higher

2. **Get Dependencies:**
   ```bash
   cd appconsult
   flutter pub get
   ```

### Step 2: Firebase Setup (Most Important!)

#### A. Create Firebase Project
1. Go to https://console.firebase.google.com/
2. Click "Add project"
3. Enter project name: `doctor-consultation`
4. Enable Google Analytics (optional)
5. Click "Create project"

#### B. Add Android App
1. In Firebase Console, click Android icon
2. Enter Package name: `com.example.doctor_consultation`
3. Download `google-services.json`
4. Place file in: `android/app/google-services.json`

#### C. Add iOS App (Optional)
1. In Firebase Console, click iOS icon
2. Enter Bundle ID: `com.example.doctorConsultation`
3. Download `GoogleService-Info.plist`
4. Place file in: `ios/Runner/GoogleService-Info.plist`

#### D. Enable Required Services

**1. Authentication:**
```
Firebase Console > Build > Authentication
- Click "Get started"
- Click "Sign-in method"
- Enable "Email/Password"
- Save
```

**2. Firestore Database:**
```
Firebase Console > Build > Firestore Database
- Click "Create database"
- Choose "Start in production mode"
- Choose Location (close to your users)
- Click "Enable"
```

**3. Storage:**
```
Firebase Console > Build > Storage
- Click "Get started"
- Choose "Start in production mode"
- Click "Done"
```

**4. Cloud Messaging:**
```
Firebase Console > Build > Cloud Messaging
- Service is enabled by default
```

#### E. Update Security Rules

Follow the same rules as mentioned in the Arabic section above.

#### F. Update firebase_options.dart

Use FlutterFire CLI (easiest):
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Auto-configure Firebase
flutterfire configure
```

### Step 3: Run the App

```bash
# Android
flutter run

# iOS (requires macOS)
flutter run -d ios
```

### Step 4: Create Test Account

1. Open the app
2. Click "Sign Up"
3. Enter information:
   - Name: Dr. Ahmed Ali
   - Email: doctor@example.com
   - Password: 123456
   - Specialization: Cardiology
4. Click "Sign Up"
5. You'll be logged in automatically!

---

**Last Updated:** October 17, 2024


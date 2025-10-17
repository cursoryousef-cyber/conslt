# دليل الإعداد والتشغيل
# Setup and Installation Guide

## المتطلبات الأساسية / Prerequisites

### 1. تثبيت Flutter / Install Flutter
```bash
# تحقق من تثبيت Flutter / Check Flutter installation
flutter --version

# يجب أن يكون الإصدار 3.0.0 أو أحدث
# Version should be 3.0.0 or higher
```

### 2. تثبيت التبعيات / Install Dependencies
```bash
# في مجلد المشروع / In project directory
flutter pub get
```

## إعداد Firebase / Firebase Setup

### الخطوة 1: إنشاء مشروع Firebase / Step 1: Create Firebase Project

1. اذهب إلى [Firebase Console](https://console.firebase.google.com/)
   - Go to Firebase Console
2. أنشئ مشروع جديد / Create new project
3. أضف تطبيق Android و iOS / Add Android and iOS apps

### الخطوة 2: تفعيل الخدمات / Step 2: Enable Services

#### Authentication
```
1. اذهب إلى Authentication > Sign-in method
   Go to Authentication > Sign-in method
2. فعّل Email/Password
   Enable Email/Password
```

#### Firestore Database
```
1. اذهب إلى Firestore Database
   Go to Firestore Database
2. أنشئ قاعدة بيانات في وضع الإنتاج
   Create database in production mode
3. أضف قواعد الأمان التالية:
   Add the following security rules:
```

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Consultations collection
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
    
    // Chats collection
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

#### Storage
```
1. اذهب إلى Storage
   Go to Storage
2. أنشئ bucket افتراضي
   Create default bucket
3. أضف قواعد الأمان التالية:
   Add the following security rules:
```

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

#### Cloud Messaging
```
1. اذهب إلى Cloud Messaging
   Go to Cloud Messaging
2. فعّل الخدمة
   Enable the service
```

### الخطوة 3: تنزيل ملفات التكوين / Step 3: Download Configuration Files

#### Android
```
1. نزّل google-services.json
   Download google-services.json
2. ضعه في: android/app/google-services.json
   Place it in: android/app/google-services.json
```

#### iOS
```
1. نزّل GoogleService-Info.plist
   Download GoogleService-Info.plist
2. ضعه في: ios/Runner/GoogleService-Info.plist
   Place it in: ios/Runner/GoogleService-Info.plist
```

### الخطوة 4: تحديث ملف firebase_options.dart / Step 4: Update firebase_options.dart

```bash
# قم بتشغيل FlutterFire CLI
# Run FlutterFire CLI
flutter pub global activate flutterfire_cli
flutterfire configure
```

أو قم بتحديث الملف يدوياً في `lib/firebase_options.dart`
Or manually update the file in `lib/firebase_options.dart`

## إعداد الأصول / Assets Setup

### إنشاء المجلدات / Create Folders
```bash
mkdir -p assets/images
mkdir -p assets/icons
mkdir -p assets/fonts
mkdir -p assets/translations
```

### الخطوط العربية / Arabic Fonts (Optional)
```
1. نزّل خط Cairo من Google Fonts
   Download Cairo font from Google Fonts
2. ضع الملفات في assets/fonts/
   Place files in assets/fonts/
   - Cairo-Regular.ttf
   - Cairo-Bold.ttf
   - Cairo-SemiBold.ttf
```

## التشغيل / Running the App

### وضع التطوير / Development Mode
```bash
# Android
flutter run

# iOS (يتطلب macOS و Xcode)
# iOS (requires macOS and Xcode)
flutter run -d ios
```

### البناء للإنتاج / Production Build

#### Android
```bash
# APK
flutter build apk --release

# App Bundle (للنشر على Play Store)
# App Bundle (for Play Store)
flutter build appbundle --release
```

#### iOS
```bash
# يتطلب macOS و Xcode
# Requires macOS and Xcode
flutter build ios --release
```

## الاختبار / Testing

### إنشاء حسابات تجريبية / Create Test Accounts
```
1. سجّل دخول للتطبيق
   Sign up in the app
2. استخدم بريد إلكتروني مهني
   Use a professional email
3. اختر تخصص طبي
   Choose medical specialization
```

### اختبار الميزات / Test Features
- ✅ تسجيل الدخول / Login
- ✅ تصفح الأطباء / Browse doctors
- ✅ إرسال استشارة / Send consultation
- ✅ الدردشة / Chat
- ✅ رفع الملفات / File upload
- ✅ الإشعارات / Notifications
- ✅ تغيير اللغة / Change language

## استكشاف الأخطاء / Troubleshooting

### مشكلة التبعيات / Dependency Issues
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

### مشكلة Firebase / Firebase Issues
```bash
# تحقق من ملفات التكوين
# Check configuration files
ls android/app/google-services.json
ls ios/Runner/GoogleService-Info.plist

# أعد تشغيل FlutterFire
# Re-run FlutterFire
flutterfire configure
```

### مشكلة البناء / Build Issues
```bash
# Android
cd android
./gradlew clean
cd ..

# iOS
cd ios
pod deintegrate
pod install
cd ..
```

## الموارد / Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Riverpod Documentation](https://riverpod.dev/)
- [Go Router Documentation](https://pub.dev/packages/go_router)

## الدعم / Support

في حال واجهت أي مشاكل، يرجى:
If you encounter any issues, please:

1. راجع ملف README.md / Check README.md
2. راجع التوثيق الرسمي / Check official documentation
3. افتح issue على GitHub / Open a GitHub issue

---

**ملاحظة:** هذا المشروع تعليمي ويحتاج إلى إعداد إضافي للإنتاج
**Note:** This is an educational project and needs additional setup for production


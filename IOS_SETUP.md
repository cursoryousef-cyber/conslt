# إعداد iOS / iOS Setup

<div dir="rtl">

## 📱 إعداد Firebase لـ iOS

### ⚠️ ملاحظة مهمة
تطبيق iOS يحتاج إلى:
1. جهاز Mac مع Xcode
2. حساب Apple Developer (للتطبيق على جهاز حقيقي)
3. إضافة تطبيق iOS في Firebase Console

---

## 🔧 الخطوات المطلوبة

### 1️⃣ إضافة تطبيق iOS في Firebase Console

1. **اذهب إلى Firebase Console:**
   👉 https://console.firebase.google.com/project/conslt-b001a

2. **أضف تطبيق iOS:**
   ```
   - انقر على أيقونة iOS (+)
   - أدخل iOS bundle ID: com.conslt
   - App nickname: Conslt (اختياري)
   - App Store ID: (اتركه فارغاً الآن)
   - انقر "Register app"
   ```

3. **نزّل GoogleService-Info.plist:**
   ```
   - انقر "Download GoogleService-Info.plist"
   - احفظ الملف
   ```

4. **استبدل الملف الحالي:**
   ```
   - ضع الملف المُنزل في: ios/Runner/GoogleService-Info.plist
   - استبدل الملف الموجود
   ```

5. **انسخ معلومات iOS:**
   من ملف `GoogleService-Info.plist` المُنزل، انسخ:
   - `API_KEY`
   - `GOOGLE_APP_ID`

6. **حدّث firebase_options.dart:**
   في ملف `lib/firebase_options.dart`، استبدل:
   ```dart
   static const FirebaseOptions ios = FirebaseOptions(
     apiKey: 'YOUR_IOS_API_KEY',  // ضع API_KEY هنا
     appId: '1:1060334288533:ios:YOUR_IOS_APP_ID',  // ضع GOOGLE_APP_ID هنا
     messagingSenderId: '1060334288533',
     projectId: 'conslt-b001a',
     storageBucket: 'conslt-b001a.firebasestorage.app',
     iosBundleId: 'com.conslt',
   );
   ```

---

### 2️⃣ تثبيت CocoaPods (إذا لم يكن مثبتاً)

```bash
# على Mac فقط
sudo gem install cocoapods

# تحقق من التثبيت
pod --version
```

---

### 3️⃣ تثبيت Firebase Pods

```bash
cd ios
pod install
cd ..
```

**إذا واجهت مشاكل:**
```bash
cd ios
pod deintegrate
rm Podfile.lock
pod install
cd ..
```

---

### 4️⃣ تشغيل على iOS

```bash
# افتح workspace (ليس project!)
open ios/Runner.xcworkspace

# أو شغّل مباشرة
flutter run -d ios
```

---

## 📝 الملفات التي تم تحديثها

✅ **ios/Runner/GoogleService-Info.plist**
   - ملف إعدادات Firebase لـ iOS
   - ⚠️ يحتاج استبدال بالملف من Firebase Console

✅ **ios/Runner/AppDelegate.swift**
   - تمت إضافة `FirebaseApp.configure()`
   - يهيئ Firebase عند بدء التطبيق

✅ **ios/Podfile**
   - إضافة Firebase pods:
     - Firebase/Core
     - Firebase/Auth
     - Firebase/Firestore
     - Firebase/Storage
     - Firebase/Messaging
     - Firebase/Analytics

✅ **ios/Runner/Info.plist**
   - تحديث اسم التطبيق إلى "Conslt"

✅ **lib/firebase_options.dart**
   - إضافة إعدادات iOS (تحتاج تحديث)

---

## 🔧 استكشاف الأخطاء

### مشكلة: Pod install failed
```bash
cd ios
sudo gem install cocoapods
pod repo update
pod install
cd ..
```

### مشكلة: Xcode build failed
```bash
# نظف المشروع
cd ios
rm -rf Pods
rm Podfile.lock
pod install
cd ..
flutter clean
flutter pub get
```

### مشكلة: Firebase not initialized
تأكد من:
1. ملف GoogleService-Info.plist في المكان الصحيح
2. Bundle ID في Xcode = com.conslt
3. تحديث firebase_options.dart بالمعلومات الصحيحة

### مشكلة: Signing error
في Xcode:
1. اختر Runner من قائمة الأهداف
2. Signing & Capabilities
3. اختر Team أو استخدم "Automatically manage signing"

---

## ✅ قائمة التحقق

قبل تشغيل التطبيق على iOS:

- [ ] تثبيت CocoaPods
- [ ] إنشاء تطبيق iOS في Firebase Console
- [ ] تنزيل GoogleService-Info.plist الصحيح
- [ ] وضع الملف في ios/Runner/
- [ ] تحديث firebase_options.dart
- [ ] تشغيل `pod install`
- [ ] فتح Runner.xcworkspace في Xcode
- [ ] إعداد Signing في Xcode
- [ ] تشغيل على iOS Simulator أو جهاز

---

## 🎯 ملاحظات مهمة

### للتطوير:
- ✅ iOS Simulator يعمل بدون حساب Developer
- ✅ استخدم Xcode لإدارة المشروع
- ✅ Hot Reload يعمل على iOS أيضاً

### للإنتاج:
- ⚠️ تحتاج حساب Apple Developer ($99/سنة)
- ⚠️ إعداد Signing Certificates
- ⚠️ إنشاء Provisioning Profiles
- ⚠️ تكوين Push Notifications

### الأمان:
- 🔒 لا تشارك GoogleService-Info.plist
- 🔒 أضفه إلى .gitignore (موجود بالفعل)

---

## 📱 اختبار على iOS Simulator

```bash
# افتح iOS Simulator
open -a Simulator

# قائمة الأجهزة المتاحة
flutter devices

# شغّل على iOS
flutter run -d ios
```

---

## 🚀 الخطوات السريعة (ملخص)

1. أنشئ تطبيق iOS في Firebase Console
2. نزّل GoogleService-Info.plist
3. ضعه في ios/Runner/
4. حدّث firebase_options.dart
5. شغّل `cd ios && pod install && cd ..`
6. شغّل `flutter run -d ios`

---

</div>

## 📱 iOS Setup for Firebase

### ⚠️ Important Note
iOS app requires:
1. Mac with Xcode
2. Apple Developer account (for real device)
3. Add iOS app in Firebase Console

---

## 🔧 Required Steps

### 1️⃣ Add iOS App in Firebase Console

1. **Go to Firebase Console:**
   👉 https://console.firebase.google.com/project/conslt-b001a

2. **Add iOS app:**
   - Click iOS icon (+)
   - Enter iOS bundle ID: `com.conslt`
   - App nickname: Conslt (optional)
   - Click "Register app"

3. **Download GoogleService-Info.plist:**
   - Click "Download GoogleService-Info.plist"
   - Save the file

4. **Replace current file:**
   - Place downloaded file at: `ios/Runner/GoogleService-Info.plist`
   - Replace existing file

5. **Update firebase_options.dart:**
   Copy API_KEY and GOOGLE_APP_ID from downloaded file

---

### 2️⃣ Install Firebase Pods

```bash
cd ios
pod install
cd ..
```

---

### 3️⃣ Run on iOS

```bash
flutter run -d ios
```

---

## ✅ Checklist

- [ ] Install CocoaPods
- [ ] Create iOS app in Firebase Console
- [ ] Download correct GoogleService-Info.plist
- [ ] Place file in ios/Runner/
- [ ] Update firebase_options.dart
- [ ] Run `pod install`
- [ ] Open Runner.xcworkspace in Xcode
- [ ] Setup Signing in Xcode
- [ ] Run on iOS Simulator or device

---

## 🚀 Quick Steps (Summary)

1. Create iOS app in Firebase Console
2. Download GoogleService-Info.plist
3. Place in ios/Runner/
4. Update firebase_options.dart
5. Run `cd ios && pod install && cd ..`
6. Run `flutter run -d ios`

---

**Setup Complete! 🎉**


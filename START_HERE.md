# 🚀 ابدأ من هنا / START HERE

<div dir="rtl" style="background: #f0f9ff; padding: 20px; border-radius: 10px; margin: 20px 0;">

## ✅ تم إعداد Firebase بنجاح!

جميع الملفات جاهزة! اتبع الخطوات التالية لتشغيل التطبيق:

</div>

---

## 📋 خطوات التشغيل السريعة (5 دقائق)

### 1️⃣ نظف وجهز المشروع

```bash
flutter clean
flutter pub get
```

### 2️⃣ فعّل خدمات Firebase

**اذهب إلى Firebase Console:**
👉 https://console.firebase.google.com/project/conslt-b001a

**فعّل الخدمات التالية:**

#### أ. Authentication
```
Build > Authentication > Get started
Sign-in method > Enable "Email/Password"
```

#### ب. Firestore Database
```
Build > Firestore Database > Create database
اختر: "Start in production mode"
Location: europe-west (أو الأقرب لك)
```

**⚠️ مهم جداً! أضف قواعد الأمان:**

انسخ والصق في Firestore Rules:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    match /consultations/{consultationId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update: if request.auth != null;
    }
    match /chats/{chatId} {
      allow read, write: if request.auth != null;
      match /messages/{messageId} {
        allow read, write: if request.auth != null;
      }
    }
  }
}
```

#### ج. Storage
```
Build > Storage > Get started
اختر: "Start in production mode"
نفس Location كـ Firestore
```

**أضف قواعد Storage:**
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### 3️⃣ شغّل التطبيق!

```bash
flutter run
```

---

## 👥 إنشاء حسابات تجريبية

بعد تشغيل التطبيق:

### الحساب الأول:
```
👤 الاسم: د. أحمد علي
📧 البريد: doctor1@test.com
🔑 كلمة المرور: 123456
🏥 التخصص: Cardiology
```

### الحساب الثاني:
```
👤 الاسم: د. فاطمة محمد
📧 البريد: doctor2@test.com
🔑 كلمة المرور: 123456
🏥 التخصص: Pediatrics
```

---

## ✅ اختبر الميزات

من الحساب الأول:
1. ✅ تصفح الأطباء
2. ✅ اختر طبيب من تخصص آخر
3. ✅ أرسل استشارة مع رفع ملف
4. ✅ ابدأ محادثة
5. ✅ عدّل ملفك الشخصي

---

## ⚡ حل سريع للمشاكل

### خطأ في البناء؟
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Firebase لا يعمل؟
تأكد من:
- ✅ تفعيل Authentication في Console
- ✅ تفعيل Firestore في Console
- ✅ تفعيل Storage في Console
- ✅ إضافة قواعد الأمان

---

## 📚 الملفات التوثيقية

| الملف | ماذا يحتوي |
|------|-----------|
| **FIREBASE_SETUP_COMPLETE.md** | تفاصيل إعداد Firebase |
| **QUICKSTART.md** | دليل البدء السريع |
| **SETUP.md** | دليل الإعداد الكامل |
| **FEATURES.md** | قائمة جميع الميزات |
| **PROJECT_STRUCTURE.md** | بنية المشروع |
| **README.md** | معلومات المشروع |

---

## 🎯 معلومات المشروع

- **Package Name (Android):** `com.conslt`
- **Bundle ID (iOS):** `com.conslt`
- **Project ID:** `conslt-b001a`
- **Storage Bucket:** `conslt-b001a.firebasestorage.app`

---

## 📱 إعداد iOS (اختياري)

إذا كنت تريد تشغيل التطبيق على iOS:

👉 **راجع ملف:** [IOS_SETUP.md](IOS_SETUP.md)

**الخطوات السريعة:**
1. أنشئ تطبيق iOS في Firebase Console
2. نزّل GoogleService-Info.plist
3. ضعه في ios/Runner/
4. شغّل `cd ios && pod install && cd ..`
5. شغّل `flutter run -d ios`

---

## 🔥 Firebase Console

👉 **رابط المشروع:**
https://console.firebase.google.com/project/conslt-b001a

---

## 📞 هل تحتاج مساعدة؟

1. 📖 راجع **FIREBASE_SETUP_COMPLETE.md** للتفاصيل
2. 📖 راجع **QUICKSTART.md** للبدء السريع
3. 📖 راجع **SETUP.md** للإعداد الكامل

---

<div style="background: #dcfce7; padding: 15px; border-radius: 8px; border-left: 4px solid #22c55e;">

## ✨ جاهز للتشغيل!

كل شيء معد ومجهز. فقط:
1. فعّل الخدمات في Firebase Console (5 دقائق)
2. شغّل التطبيق: `flutter run`
3. استمتع! 🎉

</div>

---

<div align="center">

### 🚀 الآن شغّل التطبيق!

```bash
flutter run
```

**صُنع بـ ❤️ باستخدام Flutter & Firebase**

</div>


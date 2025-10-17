# 🪟 تشغيل على Windows / Running on Windows

## ✅ تم حل مشكلة intl!

تم تحديث `pubspec.yaml` وتغيير إصدار `intl` من `^0.18.1` إلى `^0.20.2`

---

## 🚀 خطوات التشغيل على Windows

### ⚠️ ملاحظة مهمة
في **PowerShell**، لا يعمل `&&` لتشغيل أوامر متعددة. استخدم `;` بدلاً منه أو شغل الأوامر منفصلة.

---

## 📋 الطريقة الصحيحة

### الخطوة 1: نظف المشروع

```powershell
flutter clean
```

انتظر حتى ينتهي، ثم:

```powershell
flutter pub get
```

---

## ✅ إذا نجح flutter pub get

يجب أن ترى رسالة مثل:
```
Resolving dependencies...
Got dependencies!
```

**الآن انتقل للخطوة التالية:**

### الخطوة 2: فعّل خدمات Firebase

اذهب إلى:
👉 **https://console.firebase.google.com/project/conslt-b001a**

**فعّل:**
1. **Authentication** → Sign-in method → Email/Password
2. **Firestore Database** → Create database → Production mode
3. **Storage** → Get started → Production mode

**أضف قواعد الأمان (مهم جداً!):**

#### Firestore Rules:
في Firestore Database > Rules، استبدل القواعد بهذا:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    match /consultations/{consultationId} {
      allow read, write: if request.auth != null;
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

#### Storage Rules:
في Storage > Rules، استبدل القواعد بهذا:
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

---

### الخطوة 3: شغّل التطبيق!

```powershell
flutter run
```

---

## 🔧 إذا واجهت مشاكل

### مشكلة: Gradle build failed

```powershell
cd android
.\gradlew clean
cd ..
flutter clean
flutter run
```

### مشكلة: Firebase not working

تأكد من:
- ✅ تفعيل Authentication
- ✅ تفعيل Firestore
- ✅ تفعيل Storage
- ✅ إضافة قواعد الأمان

### مشكلة: Dependencies error

```powershell
flutter clean
flutter pub cache clean
flutter pub get
```

---

## 📱 بعد تشغيل التطبيق

### أنشئ حسابات تجريبية:

**الحساب الأول:**
- الاسم: د. أحمد علي
- البريد: doctor1@test.com
- كلمة المرور: 123456
- التخصص: Cardiology

**الحساب الثاني:**
- الاسم: د. فاطمة محمد
- البريد: doctor2@test.com
- كلمة المرور: 123456
- التخصص: Pediatrics

---

## ✅ اختبار الميزات

من الحساب الأول:
1. ✅ تصفح الأطباء
2. ✅ بحث حسب التخصص
3. ✅ إرسال استشارة + رفع ملف
4. ✅ بدء محادثة
5. ✅ تعديل الملف الشخصي

من الحساب الثاني:
1. ✅ عرض الاستشارات المستلمة
2. ✅ الرد على الاستشارات

---

## 💡 نصائح PowerShell

### ✅ الصحيح:
```powershell
# تشغيل أوامر متعددة - استخدم سطر منفصل
flutter clean
flutter pub get
flutter run

# أو استخدم ;
flutter clean; flutter pub get; flutter run
```

### ❌ الخطأ:
```powershell
# هذا لا يعمل في PowerShell
flutter clean && flutter pub get  # ❌
flutter clean & flutter pub get   # ❌
```

---

## 🎯 ملخص سريع

```powershell
# 1. نظف
flutter clean

# 2. ثبت التبعيات
flutter pub get

# 3. فعّل الخدمات في Firebase Console
# اذهب إلى الرابط أعلاه

# 4. شغّل
flutter run

# 5. أنشئ حساب وجرب!
```

---

## 📊 معلومات المشروع

- **Package Name:** com.conslt
- **Project ID:** conslt-b001a
- **Firebase Console:** https://console.firebase.google.com/project/conslt-b001a

---

## 🔗 ملفات مفيدة

- **READY_TO_RUN.md** - خطوات التشغيل الكاملة
- **START_HERE.md** - دليل البدء
- **FIREBASE_SETUP_COMPLETE.md** - تفاصيل Firebase

---

## 🎊 كل شيء جاهز!

بعد `flutter pub get` الناجح:
1. فعّل الخدمات في Firebase (5 دقائق)
2. شغّل `flutter run`
3. استمتع! 🎉

---

**صُنع بـ ❤️ باستخدام Flutter & Firebase**


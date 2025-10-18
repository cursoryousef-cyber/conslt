# 📋 خطوة بخطوة - Android APK + iOS IPA

## 🎯 الهدف

بناء التطبيق للمنصتين:
1. ✅ **Android APK** (على Windows مباشرة)
2. ✅ **iOS IPA** (عبر Codemagic)

---

## 📱 الجزء الأول: Android APK (10 دقائق)

### الخطوة 1: افتح PowerShell جديد

```
اضغط Win + X
اختر "Windows PowerShell"
```

### الخطوة 2: اذهب للمشروع

```powershell
cd F:\appconsult
```

### الخطوة 3: نظف المشروع

```powershell
flutter clean
```

انتظر حتى ينتهي...

### الخطوة 4: اجلب التبعيات

```powershell
flutter pub get
```

انتظر حتى ترى "Got dependencies!"

### الخطوة 5: بناء APK

```powershell
flutter build apk --release
```

**⏱️ سينتظر 5-10 دقائق...**

سترى تحذيرات عن `file_picker` - **تجاهلها**!

### الخطوة 6: ✅ نجح!

عند النجاح سترى:
```
✓ Built build\app\outputs\flutter-apk\app-release.apk (XX.X MB)
```

**ملف APK موجود في:**
```
F:\appconsult\build\app\outputs\flutter-apk\app-release.apk
```

### الخطوة 7: نسخ APK

```powershell
# انسخ الملف من المجلد أعلاه
# يمكنك فتح المجلد:
explorer build\app\outputs\flutter-apk\
```

---

## 📱 الجزء الثاني: iOS IPA (عبر Codemagic)

### الخطوة 1: إصلاح ملفات iOS

**في نفس PowerShell:**

```powershell
flutter create --platforms=ios .
```

**عند السؤال:**
```
file.dart already exists. What should I do?
```

**اكتب: `a`** ثم **Enter** (للموافقة على الكل)

**انتظر حتى ترى:**
```
Wrote XX files.
All done!
```

---

### الخطوة 2: تحقق من إنشاء ملفات Xcode

```powershell
dir ios\Runner.xcodeproj
```

يجب أن ترى:
```
Runner.xcodeproj (مجلد)
```

**✅ ممتاز!** ملفات iOS جاهزة الآن.

---

### الخطوة 3: رفع على GitHub

#### أ. تهيئة Git (أول مرة فقط)

```powershell
git init
git add .
git commit -m "Doctor Consultation - Complete Android and iOS"
```

#### ب. إنشاء Repository على GitHub

```
1. افتح: https://github.com/new
2. Repository name: doctor-consultation
3. Private أو Public (اختر ما تفضل)
4. انقر "Create repository"
5. انسخ الرابط الذي يظهر
```

#### ج. ربط و Push

```powershell
# استبدل YOUR_USERNAME باسم حسابك
git remote add origin https://github.com/YOUR_USERNAME/doctor-consultation.git
git branch -M main
git push -u origin main
```

**⏱️ انتظر التحميل...**

---

### الخطوة 4: بناء على Codemagic

#### أ. التسجيل

```
1. افتح: https://codemagic.io/signup
2. انقر "Sign up with GitHub"
3. اسمح بالوصول
```

#### ب. إضافة التطبيق

```
1. في Dashboard: "Add application"
2. اختر "Flutter App"
3. اختر repository: doctor-consultation
4. انقر "Finish"
```

#### ج. إعداد Workflow

```
1. اختر التطبيق
2. "Start your first build"
3. Workflow editor
4. اختر "iOS"
5. اضبط:
   ├─ Flutter version: 3.16.0 (أو latest)
   ├─ Xcode version: Latest stable
   ├─ Build mode: Release
   └─ Build platform: iOS
```

#### د. Code Signing

```
1. Code signing section
2. اختر "Automatic"
3. "Connect Apple Developer Portal"
4. سجل دخول بحساب Apple Developer
5. اسمح لـ Codemagic
6. Codemagic سيعمل كل شيء تلقائياً
```

**⚠️ ملاحظة:** تحتاج حساب Apple Developer ($99/سنة)

**بدون حساب Developer:**
- لا يمكن بناء IPA للأجهزة الحقيقية
- يمكن فقط للـ Simulator

#### هـ. بدء البناء

```
1. احفظ Workflow
2. "Start new build"
3. اختر branch: main
4. "Start build"
```

**⏱️ انتظر 15-25 دقيقة...**

#### و. تنزيل IPA

```
بعد النجاح:
1. اذهب لصفحة Build
2. في Artifacts section
3. انقر على app.ipa
4. نزّل الملف!
```

**✅ IPA جاهز!**

---

## 📊 ملخص سريع

### Android (على Windows):
```
1. flutter build apk --release
2. انتظر 5-10 دقائق
3. APK في: build\app\outputs\flutter-apk\
```

### iOS (عبر Codemagic):
```
1. flutter create --platforms=ios .
2. git push إلى GitHub
3. بناء على Codemagic
4. انتظر 15-25 دقيقة
5. نزّل IPA
```

---

## 🔥 لا تنسَ Firebase!

قبل تثبيت التطبيقات:

👉 https://console.firebase.google.com/project/conslt-b001a

**فعّل:**
- Authentication
- Firestore + Rules
- Storage + Rules

**(القواعد موجودة أعلاه)**

---

## 🎊 النتيجة النهائية

بعد كل الخطوات:

✅ **app-release.apk** - للـ Android  
✅ **app.ipa** - للـ iOS  
✅ **Firebase** - مفعّل  
✅ **التطبيق** - يعمل على المنصتين!  

---

## 📝 نصائح

### للبناء الأول:
- التحذيرات عن file_picker **عادية**
- البناء الأول يأخذ وقت أطول
- تأكد من الإنترنت مستقر

### للتثبيت:
- على Android: اسمح بالتثبيت من مصادر غير معروفة
- على iOS: يحتاج تثبيت عبر Xcode أو TestFlight

### للاختبار:
- أنشئ حسابين مختلفين
- جرب إرسال استشارة
- جرب الدردشة
- جرب رفع ملفات

---

**الآن ابدأ بالخطوة 1! 🚀**


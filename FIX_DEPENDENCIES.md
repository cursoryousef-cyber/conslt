# حل مشكلة التبعيات / Fix Dependencies Issue

## ⚠️ المشكلة / The Problem

الأخطاء التي تراها ناتجة عن عدم تنزيل التبعيات بعد. يجب تشغيل `flutter pub get` بشكل صحيح.

---

## ✅ الحل السريع / Quick Solution

### الطريقة 1: استخدام ملف Setup (الأسهل)

```powershell
.\setup.bat
```

هذا الملف سيقوم بـ:
1. تنظيف المشروع
2. تنزيل جميع التبعيات
3. فحص Flutter

---

### الطريقة 2: يدوياً (Manual)

**افتح PowerShell جديد:**

```powershell
# 1. تأكد أنك في مجلد المشروع
cd F:\appconsult

# 2. نظف المشروع
flutter clean

# 3. احذف ملف pubspec.lock إذا كان موجوداً
if (Test-Path pubspec.lock) { Remove-Item pubspec.lock }

# 4. نزّل التبعيات
flutter pub get

# 5. تحقق من النجاح
flutter pub get
```

---

### الطريقة 3: من CMD (بدلاً من PowerShell)

```cmd
# افتح CMD (Command Prompt)
cd F:\appconsult
flutter clean
flutter pub get
```

---

## ✅ كيف تعرف أن التبعيات تم تنزيلها؟

بعد `flutter pub get` الناجح، يجب أن ترى:

```
Resolving dependencies...
+ badges 3.1.2
+ cached_network_image 3.3.1
+ cloud_firestore 4.13.6
+ easy_localization 3.0.3
+ equatable 2.0.5
+ file_picker 6.1.1
+ firebase_auth 4.15.3
+ firebase_core 2.24.2
+ firebase_messaging 14.7.9
+ firebase_storage 11.5.6
+ flutter_local_notifications 16.3.0
+ flutter_riverpod 2.4.9
+ go_router 12.1.3
+ image_picker 1.0.5
+ intl 0.20.2
+ ...
Got dependencies!
```

---

## ✅ بعد نجاح flutter pub get

### 1. تحقق من عدم وجود أخطاء:

```powershell
flutter analyze
```

يجب ألا ترى أخطاء عن "Target of URI doesn't exist"

---

### 2. فعّل خدمات Firebase:

اذهب إلى:
👉 **https://console.firebase.google.com/project/conslt-b001a**

**فعّل:**
- ✅ Authentication → Email/Password
- ✅ Firestore Database → Production mode
- ✅ Storage → Production mode

**أضف قواعد الأمان** (موجودة في READY_TO_RUN.md)

---

### 3. شغّل التطبيق:

```powershell
# باستخدام الملف
.\run.bat

# أو يدوياً
flutter run
```

---

## 🔧 مشاكل شائعة

### المشكلة: "Pub get has not been run"
**الحل:**
```powershell
flutter clean
del pubspec.lock
flutter pub get
```

### المشكلة: "Target of URI doesn't exist"
**الحل:**
- هذا يعني أن التبعيات لم تُنزّل
- شغّل `flutter pub get` مرة أخرى
- تأكد من رؤية "Got dependencies!"

### المشكلة: "Version solving failed"
**الحل:**
- تم حل هذه المشكلة بالفعل (intl ^0.20.2)
- إذا ظهرت مرة أخرى، شغّل:
```powershell
flutter clean
flutter pub get
```

### المشكلة: Terminal معلق
**الحل:**
1. اضغط Ctrl+C لإلغاء العملية
2. افتح PowerShell جديد
3. شغّل `flutter pub get`

---

## ✅ قائمة التحقق

- [ ] فتح PowerShell أو CMD جديد
- [ ] التأكد من المسار: `cd F:\appconsult`
- [ ] تشغيل `flutter clean`
- [ ] تشغيل `flutter pub get`
- [ ] رؤية رسالة "Got dependencies!"
- [ ] لا توجد أخطاء عند `flutter analyze`
- [ ] جاهز للتشغيل: `flutter run`

---

## 📝 ملاحظات مهمة

### ✅ الملفات التي أنشأتها لك:
- **setup.bat** - سكريبت تلقائي للإعداد
- **run.bat** - سكريبت تلقائي للتشغيل

### ⚡ استخدام سريع:
```powershell
# إعداد المشروع (مرة واحدة فقط)
.\setup.bat

# تشغيل التطبيق (كل مرة)
.\run.bat
```

---

## 🎯 الخطوات التالية

بعد نجاح `flutter pub get`:

1. ✅ لن ترى أي أخطاء عن "Target of URI doesn't exist"
2. ✅ فعّل خدمات Firebase (5 دقائق)
3. ✅ شغّل التطبيق: `flutter run`
4. ✅ أنشئ حساب واستمتع!

---

## 📞 هل لا يزال هناك مشكلة؟

إذا استمرت المشكلة بعد `flutter pub get`:

1. **تحقق من إصدار Flutter:**
   ```powershell
   flutter --version
   ```
   يجب أن يكون 3.0.0 أو أحدث

2. **حدّث Flutter:**
   ```powershell
   flutter upgrade
   ```

3. **نظف الكاش:**
   ```powershell
   flutter pub cache clean
   flutter clean
   flutter pub get
   ```

---

**الآن جرب setup.bat أو شغّل flutter pub get في terminal جديد!**


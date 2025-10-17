# 🚀 بناء IPA باستخدام Codemagic (بدون Mac!)

<div dir="rtl">

## 🌟 لماذا Codemagic؟

- ✅ **لا تحتاج Mac!** - كل شيء في السحابة
- ✅ **مجاني** للمشاريع الصغيرة
- ✅ **سهل الإعداد** - بضع نقرات فقط
- ✅ **بناء تلقائي** - عند كل Push
- ✅ **دعم Flutter** - مدمج ومُحسّن

</div>

---

## 📋 الخطوات الكاملة

### 1️⃣ إنشاء حساب Codemagic

```
1. اذهب إلى: https://codemagic.io/signup
2. سجل باستخدام GitHub
3. اسمح بالوصول لـ repositories
```

---

### 2️⃣ إضافة المشروع

```
1. في Codemagic Dashboard
2. انقر "Add application"
3. اختر "Flutter App"
4. اختر repository الخاص بك
5. انقر "Finish: Add application"
```

---

### 3️⃣ إعداد iOS Workflow

```
1. اختر التطبيق
2. انقر "Start your first build"
3. Workflow editor > iOS
4. اضبط:
   - Flutter version: 3.16.0
   - Xcode version: أحدث إصدار
   - Build mode: Release
```

---

### 4️⃣ إعداد Code Signing

#### خيار 1: Automatic (الأسهل)

```
1. في Workflow settings
2. Code signing
3. اختر "Automatic"
4. سجل دخول بحساب Apple Developer
5. Codemagic سيتعامل مع كل شيء تلقائياً
```

#### خيار 2: Manual

```
1. نزّل Certificates من Apple Developer
2. نزّل Provisioning Profiles
3. في Codemagic:
   - Code signing
   - Upload certificate (.p12)
   - Upload provisioning profile
```

---

### 5️⃣ إعداد Environment Variables

```
1. في Workflow settings > Environment variables
2. أضف:
   - FIREBASE_API_KEY (اختياري)
   - أي متغيرات أخرى
```

---

### 6️⃣ بناء التطبيق

```
1. احفظ Workflow
2. انقر "Start new build"
3. اختر branch (main/master)
4. انقر "Start build"
5. انتظر (10-20 دقيقة)
```

---

### 7️⃣ تنزيل IPA

```
بعد انتهاء البناء:
1. انقر على Build
2. في Artifacts
3. نزّل ملف .ipa
```

---

## 🔧 إعداد codemagic.yaml (متقدم)

أنشئ ملف في مجلد المشروع:

```yaml
# codemagic.yaml
workflows:
  ios-workflow:
    name: iOS Workflow
    max_build_duration: 120
    instance_type: mac_mini_m1
    environment:
      flutter: 3.16.0
      xcode: 15.0
      cocoapods: default
      vars:
        BUNDLE_ID: "com.conslt"
        APP_STORE_ID: YOUR_APP_STORE_ID
    scripts:
      - name: Install dependencies
        script: |
          flutter pub get
          cd ios && pod install
      - name: Build IPA
        script: |
          flutter build ipa --release \
            --export-options-plist=ios/ExportOptions.plist
    artifacts:
      - build/ios/ipa/*.ipa
    publishing:
      email:
        recipients:
          - your-email@example.com
      app_store_connect:
        api_key: $APP_STORE_CONNECT_PRIVATE_KEY
        key_id: $APP_STORE_CONNECT_KEY_ID
        issuer_id: $APP_STORE_CONNECT_ISSUER_ID
```

---

## 🎯 الطريقة الأسهل (خطوة بخطوة)

### الخطوة 1: ارفع المشروع على GitHub

```bash
# في مجلد المشروع
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/doctor-consultation.git
git push -u origin main
```

---

### الخطوة 2: سجل في Codemagic

1. اذهب لـ: https://codemagic.io/signup
2. انقر "Sign up with GitHub"
3. اسمح بالوصول

---

### الخطوة 3: أضف التطبيق

1. في Dashboard، انقر "Add application"
2. اختر repository: doctor-consultation
3. اختر "Flutter App"
4. انقر "Finish"

---

### الخطوة 4: اضبط iOS Workflow

```
1. في التطبيق، اذهب لـ "Workflow settings"
2. اختر "iOS"
3. اضبط:
   ├─ Build for platforms: ✅ iOS
   ├─ Flutter version: 3.16.0
   ├─ Xcode version: latest
   └─ Build mode: Release
```

---

### الخطوة 5: Code Signing

#### الطريقة السهلة (موصى بها):

```
1. Code signing section
2. اختر "Automatic"
3. انقر "Connect Apple Developer"
4. سجل دخول بحساب Apple Developer
5. Codemagic سيعمل كل شيء تلقائياً!
```

#### الطريقة اليدوية:

```
1. نزّل من Apple Developer:
   - Certificate (.p12)
   - Provisioning Profile (.mobileprovision)

2. في Codemagic > Code signing:
   - Upload certificate
   - أدخل password
   - Upload provisioning profile
```

---

### الخطوة 6: ابدأ البناء!

```
1. احفظ الإعدادات
2. انقر "Start new build"
3. اختر branch: main
4. انقر "Start build"
5. انتظر 10-20 دقيقة
6. نزّل IPA من Artifacts!
```

---

## 💰 التسعير

### Free Tier (مجاني):
- ✅ 500 دقيقة بناء/شهر
- ✅ كافي لـ 5-10 builds
- ✅ مثالي للتطوير والتجربة

### Pay-as-you-go:
- 💰 $0.095/دقيقة للـ Mac
- 💰 مناسب للاستخدام المتوسط

### Professional:
- 💰 $99/شهر
- ✅ 1500 دقيقة بناء
- ✅ مناسب للفرق الصغيرة

---

## 🎬 فيديو توضيحي

البحث عن:
```
"Codemagic Flutter iOS build tutorial"
```

على YouTube للحصول على دليل مرئي.

---

## 📦 بدائل أخرى

### 1. GitHub Actions (مجاني)
```yaml
# راجع: .github/workflows/ios-build.yml
# موجود في المشروع
```

### 2. Bitrise
```
الموقع: https://www.bitrise.io
Free tier: 10 builds/شهر
```

### 3. CircleCI
```
الموقع: https://circleci.com
Free tier: محدود
```

---

## 🎯 التوصية النهائية

<div dir="rtl">

### إذا كان لديك Mac:
```bash
cd ios && pod install && cd ..
flutter build ipa --release
```
**الأسرع والأسهل!**

### إذا لم يكن لديك Mac:
1. ✅ استخدم **Codemagic** (موصى به)
2. ✅ أو GitHub Actions
3. ✅ أو استأجر Mac سحابي

### للتجربة فقط:
```bash
# لا تحتاج IPA!
flutter run -d ios
# على iOS Simulator أو جهاز متصل
```

</div>

---

## 📝 ملاحظات

- **التطوير:** لا تحتاج IPA، استخدم `flutter run`
- **التوزيع الداخلي:** TestFlight أو Firebase App Distribution
- **النشر على App Store:** تحتاج IPA مع Code Signing

---

**بالتوفيق مع بناء تطبيقك! 🚀**



# بنية المشروع / Project Structure

## هيكل المجلدات / Folder Structure

```
doctor_consultation/
├── android/                    # ملفات Android / Android files
│   ├── app/
│   │   ├── src/
│   │   │   └── main/
│   │   │       ├── AndroidManifest.xml
│   │   │       └── kotlin/
│   │   ├── build.gradle
│   │   └── google-services.json (يجب إضافته / to be added)
│   └── build.gradle
│
├── ios/                        # ملفات iOS / iOS files
│   ├── Runner/
│   │   ├── Info.plist
│   │   └── GoogleService-Info.plist (يجب إضافته / to be added)
│   └── Podfile
│
├── assets/                     # الأصول / Assets
│   ├── images/                 # الصور / Images
│   ├── icons/                  # الأيقونات / Icons
│   ├── fonts/                  # الخطوط / Fonts
│   └── translations/           # الترجمات / Translations
│       ├── ar.json            # العربية / Arabic
│       └── en.json            # الإنجليزية / English
│
├── lib/                        # الكود الرئيسي / Main code
│   ├── main.dart              # نقطة البداية / Entry point
│   ├── firebase_options.dart  # إعدادات Firebase / Firebase config
│   │
│   ├── core/                  # الوظائف الأساسية / Core functionality
│   │   ├── constants/         # الثوابت / Constants
│   │   │   └── app_constants.dart
│   │   ├── theme/             # السمات / Themes
│   │   │   └── app_theme.dart
│   │   ├── utils/             # الأدوات المساعدة / Utilities
│   │   │   ├── validators.dart
│   │   │   ├── file_helper.dart
│   │   │   ├── snackbar_helper.dart
│   │   │   └── date_formatter.dart
│   │   └── router/            # التوجيه / Routing
│   │       └── app_router.dart
│   │
│   ├── data/                  # طبقة البيانات / Data layer
│   │   └── models/            # النماذج / Models
│   │       ├── doctor.dart
│   │       ├── consultation.dart
│   │       └── chat.dart
│   │
│   ├── domain/                # طبقة المنطق / Domain layer
│   │   └── services/          # الخدمات / Services
│   │       ├── auth_service.dart
│   │       ├── firestore_service.dart
│   │       ├── storage_service.dart
│   │       └── notification_service.dart
│   │
│   └── presentation/          # طبقة العرض / Presentation layer
│       ├── providers/         # إدارة الحالة / State management
│       │   ├── auth_provider.dart
│       │   ├── doctors_provider.dart
│       │   ├── consultations_provider.dart
│       │   └── chat_provider.dart
│       │
│       ├── screens/           # الشاشات / Screens
│       │   ├── auth/
│       │   │   ├── login_screen.dart
│       │   │   └── signup_screen.dart
│       │   ├── home/
│       │   │   └── home_screen.dart
│       │   ├── consultations/
│       │   │   ├── consultations_screen.dart
│       │   │   └── send_consultation_screen.dart
│       │   ├── chat/
│       │   │   ├── chats_screen.dart
│       │   │   └── chat_detail_screen.dart
│       │   ├── profile/
│       │   │   ├── profile_screen.dart
│       │   │   └── edit_profile_screen.dart
│       │   ├── settings/
│       │   │   └── settings_screen.dart
│       │   └── support/
│       │       └── support_screen.dart
│       │
│       └── widgets/           # الودجات المشتركة / Shared widgets
│           ├── doctor_card.dart
│           ├── specialization_chip.dart
│           ├── consultation_card.dart
│           └── message_bubble.dart
│
├── test/                       # الاختبارات / Tests
│
├── .gitignore                 # ملفات Git المستبعدة / Git ignored files
├── .metadata                  # معلومات Flutter / Flutter metadata
├── analysis_options.yaml      # إعدادات التحليل / Analysis options
├── pubspec.yaml               # التبعيات / Dependencies
├── README.md                  # الملف التوثيقي الرئيسي / Main documentation
├── SETUP.md                   # دليل الإعداد / Setup guide
├── FEATURES.md                # قائمة الميزات / Features list
└── PROJECT_STRUCTURE.md       # هذا الملف / This file
```

---

## الملفات الرئيسية / Main Files

### 1. main.dart
**الوصف / Description:** نقطة دخول التطبيق وإعداد Firebase و EasyLocalization
- تهيئة Firebase / Initialize Firebase
- إعداد دعم اللغات / Setup localization
- إعداد Riverpod / Setup Riverpod

### 2. firebase_options.dart
**الوصف / Description:** إعدادات Firebase للمنصات المختلفة
- إعدادات Android / Android configuration
- إعدادات iOS / iOS configuration

### 3. app_constants.dart
**الوصف / Description:** جميع الثوابت المستخدمة في التطبيق
- أسماء المجموعات في Firestore / Firestore collection names
- مسارات التخزين / Storage paths
- التخصصات الطبية / Medical specializations
- أنماط التعبيرات النمطية / Regex patterns

### 4. app_theme.dart
**الوصف / Description:** تخصيص الثيم والألوان
- الألوان الأساسية / Primary colors
- ثيم فاتح وداكن / Light and dark themes
- المسافات / Spacing
- نصف القطر / Border radius

---

## نماذج البيانات / Data Models

### Doctor
**الخصائص / Properties:**
- id, email, fullName, specialization
- phoneNumber, profileImageUrl, bio
- licenseNumber, hospital, languages
- yearsOfExperience, createdAt, updatedAt
- isActive, fcmToken

### Consultation
**الخصائص / Properties:**
- id, fromDoctorId, toDoctorId
- title, description, attachments
- status, createdAt, updatedAt, completedAt
- response, responseAttachments

### Chat & ChatMessage
**الخصائص / Properties:**
- Chat: id, participants, lastMessage, lastMessageTime, unreadCount
- Message: id, chatId, senderId, message, type, fileUrl, createdAt, isRead

---

## الخدمات / Services

### AuthService
**الوظائف / Functions:**
- signIn() - تسجيل الدخول / Login
- signUp() - التسجيل / Sign up
- signOut() - تسجيل الخروج / Logout
- resetPassword() - إعادة تعيين كلمة المرور / Reset password
- getCurrentDoctor() - الحصول على الطبيب الحالي / Get current doctor
- updateDoctorProfile() - تحديث البروفايل / Update profile

### FirestoreService
**الوظائف / Functions:**
- Doctors: getAllDoctors(), getDoctorsBySpecialization(), searchDoctors()
- Consultations: createConsultation(), getSentConsultations(), getReceivedConsultations()
- Chats: getOrCreateChat(), getUserChats(), sendMessage(), getMessages()

### StorageService
**الوظائف / Functions:**
- uploadProfileImage() - رفع صورة البروفايل / Upload profile image
- uploadConsultationFile() - رفع ملف استشارة / Upload consultation file
- uploadChatFile() - رفع ملف محادثة / Upload chat file
- deleteFile() - حذف ملف / Delete file

### NotificationService
**الوظائف / Functions:**
- initialize() - تهيئة الإشعارات / Initialize notifications
- getToken() - الحصول على FCM token
- subscribeToTopic() - الاشتراك في موضوع / Subscribe to topic
- unsubscribeFromTopic() - إلغاء الاشتراك / Unsubscribe from topic

---

## إدارة الحالة / State Management

### Providers (Riverpod)

#### Auth Providers
- `authServiceProvider` - خدمة المصادقة / Auth service
- `authStateProvider` - حالة المصادقة / Auth state
- `currentDoctorProvider` - الطبيب الحالي / Current doctor
- `loginProvider` - حالة تسجيل الدخول / Login state
- `signupProvider` - حالة التسجيل / Signup state

#### Doctors Providers
- `firestoreServiceProvider` - خدمة Firestore
- `allDoctorsProvider` - جميع الأطباء / All doctors
- `doctorsBySpecializationProvider` - أطباء حسب التخصص / Doctors by specialization
- `searchDoctorsProvider` - بحث الأطباء / Search doctors
- `selectedSpecializationProvider` - التخصص المختار / Selected specialization

#### Consultations Providers
- `sentConsultationsProvider` - الاستشارات المرسلة / Sent consultations
- `receivedConsultationsProvider` - الاستشارات المستلمة / Received consultations
- `createConsultationProvider` - إنشاء استشارة / Create consultation

#### Chat Providers
- `userChatsProvider` - محادثات المستخدم / User chats
- `chatMessagesProvider` - رسائل المحادثة / Chat messages
- `sendMessageProvider` - إرسال رسالة / Send message

---

## التوجيه / Routing

### Go Router Routes

```dart
/login              -> LoginScreen
/signup             -> SignupScreen
/home               -> HomeScreen
/consultations      -> ConsultationsScreen
/send-consultation/:doctorId -> SendConsultationScreen
/chats              -> ChatsScreen
/chat/:chatId       -> ChatDetailScreen
/profile            -> ProfileScreen
/edit-profile       -> EditProfileScreen
/settings           -> SettingsScreen
/support            -> SupportScreen
```

### Route Guards
- المسارات المحمية تتحقق من حالة المصادقة
- Protected routes check authentication state
- إعادة توجيه تلقائية للمستخدمين غير المصرح لهم
- Auto redirect for unauthorized users

---

## الترجمة / Localization

### اللغات المدعومة / Supported Languages
- العربية (ar) / Arabic
- الإنجليزية (en) / English

### الملفات / Files
- `assets/translations/ar.json` - ترجمات عربية
- `assets/translations/en.json` - English translations

### الاستخدام / Usage
```dart
Text('welcome'.tr())  // يترجم حسب اللغة المختارة
```

---

## Firebase Collections

### users
```json
{
  "email": "doctor@example.com",
  "fullName": "Dr. Ahmed Ali",
  "specialization": "cardiology",
  "phoneNumber": "+1234567890",
  "profileImageUrl": "...",
  "bio": "...",
  "licenseNumber": "...",
  "hospital": "...",
  "languages": ["ar", "en"],
  "yearsOfExperience": 10,
  "createdAt": "Timestamp",
  "updatedAt": "Timestamp",
  "isActive": true,
  "fcmToken": "..."
}
```

### consultations
```json
{
  "fromDoctorId": "...",
  "toDoctorId": "...",
  "title": "...",
  "description": "...",
  "attachments": ["url1", "url2"],
  "status": "pending",
  "createdAt": "Timestamp",
  "updatedAt": "Timestamp",
  "completedAt": "Timestamp",
  "response": "...",
  "responseAttachments": ["url1"]
}
```

### chats
```json
{
  "participants": ["doctorId1", "doctorId2"],
  "lastMessage": "...",
  "lastMessageTime": "Timestamp",
  "unreadCount": {
    "doctorId1": 0,
    "doctorId2": 3
  },
  "createdAt": "Timestamp",
  "updatedAt": "Timestamp"
}
```

### chats/{chatId}/messages
```json
{
  "chatId": "...",
  "senderId": "...",
  "message": "...",
  "type": "text|image|file",
  "fileUrl": "...",
  "fileName": "...",
  "createdAt": "Timestamp",
  "isRead": false
}
```

---

## Storage Structure

```
firebase-storage/
├── profile_images/
│   └── {userId}/
│       └── {fileName}
├── consultation_files/
│   └── {consultationId}_{uuid}.{ext}
└── chat_files/
    └── {chatId}_{uuid}.{ext}
```

---

## Dependencies

### الإنتاج / Production
- **flutter_riverpod** - إدارة الحالة / State management
- **firebase_core** - Firebase أساسي / Core Firebase
- **firebase_auth** - المصادقة / Authentication
- **cloud_firestore** - قاعدة البيانات / Database
- **firebase_storage** - التخزين / Storage
- **firebase_messaging** - الإشعارات / Push notifications
- **go_router** - التوجيه / Routing
- **easy_localization** - الترجمة / Localization
- **image_picker** - اختيار الصور / Image picking
- **file_picker** - اختيار الملفات / File picking

### التطوير / Development
- **flutter_lints** - فحص الكود / Code linting
- **build_runner** - توليد الكود / Code generation

---

## أفضل الممارسات / Best Practices

### 1. بنية الكود / Code Structure
- ✅ فصل المسؤوليات (Clean Architecture)
- ✅ إعادة استخدام الكود
- ✅ تسمية واضحة ومعبرة

### 2. إدارة الحالة / State Management
- ✅ استخدام Riverpod
- ✅ Providers منفصلة لكل ميزة
- ✅ AsyncValue للحالات غير المتزامنة

### 3. الأمان / Security
- ✅ قواعد أمان Firestore
- ✅ قواعد أمان Storage
- ✅ التحقق من المدخلات

### 4. الأداء / Performance
- ✅ تحميل كسول / Lazy loading
- ✅ تخزين مؤقت / Caching
- ✅ تحسين الصور / Image optimization

### 5. تجربة المستخدم / UX
- ✅ رسائل خطأ واضحة
- ✅ مؤشرات تحميل
- ✅ ردود فعل بصرية

---

**آخر تحديث / Last Updated:** أكتوبر 2024 / October 2024


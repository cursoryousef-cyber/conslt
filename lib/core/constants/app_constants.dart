class AppConstants {
  // App Info
  static const String appName = 'Doctor Consultation';
  static const String appVersion = '1.0.0';

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String consultationsCollection = 'consultations';
  static const String messagesCollection = 'messages';
  static const String chatsCollection = 'chats';
  static const String notificationsCollection = 'notifications';

  // Storage Paths
  static const String profileImagesPath = 'profile_images';
  static const String consultationFilesPath = 'consultation_files';
  static const String chatFilesPath = 'chat_files';

  // Medical Specializations
  static const List<String> medicalSpecializations = [
    'general_medicine',
    'cardiology',
    'neurology',
    'pediatrics',
    'orthopedics',
    'dermatology',
    'ophthalmology',
    'psychiatry',
    'surgery',
    'gynecology',
    'urology',
    'oncology',
    'endocrinology',
    'gastroenterology',
    'nephrology',
    'pulmonology',
    'rheumatology',
    'radiology',
    'anesthesiology',
    'emergency_medicine',
  ];

  // Consultation Status
  static const String consultationPending = 'pending';
  static const String consultationInProgress = 'in_progress';
  static const String consultationCompleted = 'completed';
  static const String consultationCancelled = 'cancelled';

  // Shared Preferences Keys
  static const String keyLanguage = 'language';
  static const String keyThemeMode = 'theme_mode';
  static const String keyUserId = 'user_id';
  static const String keyFcmToken = 'fcm_token';

  // Regex Patterns
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^\+?[1-9]\d{1,14}$';

  // Pagination
  static const int pageSize = 20;
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB

  // Animation Durations
  static const Duration shortDuration = Duration(milliseconds: 200);
  static const Duration mediumDuration = Duration(milliseconds: 300);
  static const Duration longDuration = Duration(milliseconds: 500);
}


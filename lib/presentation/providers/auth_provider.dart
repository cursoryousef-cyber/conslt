import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/models/doctor.dart';
import '../../domain/services/auth_service.dart';

// Auth Service Provider
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// Auth State Provider
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

// Current Doctor Provider
final currentDoctorProvider = FutureProvider<Doctor?>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.getCurrentDoctor();
});

// Login Provider
final loginProvider = StateNotifierProvider<LoginNotifier, AsyncValue<void>>(
  (ref) => LoginNotifier(ref.watch(authServiceProvider)),
);

class LoginNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthService _authService;

  LoginNotifier(this._authService) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authService.signIn(email, password);
    });
  }
}

// Signup Provider
final signupProvider = StateNotifierProvider<SignupNotifier, AsyncValue<void>>(
  (ref) => SignupNotifier(ref.watch(authServiceProvider)),
);

class SignupNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthService _authService;

  SignupNotifier(this._authService) : super(const AsyncValue.data(null));

  Future<void> signup({
    required String email,
    required String password,
    required String fullName,
    required String specialization,
    String? phoneNumber,
    String? licenseNumber,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authService.signUp(
        email: email,
        password: password,
        fullName: fullName,
        specialization: specialization,
        phoneNumber: phoneNumber,
        licenseNumber: licenseNumber,
      );
    });
  }
}


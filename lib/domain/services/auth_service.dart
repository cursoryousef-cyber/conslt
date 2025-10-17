import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/doctor.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<Doctor?> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final doctorDoc = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (doctorDoc.exists) {
          return Doctor.fromFirestore(doctorDoc);
        }
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign up with email and password
  Future<Doctor?> signUp({
    required String email,
    required String password,
    required String fullName,
    required String specialization,
    String? phoneNumber,
    String? licenseNumber,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final doctor = Doctor(
          id: userCredential.user!.uid,
          email: email,
          fullName: fullName,
          specialization: specialization,
          phoneNumber: phoneNumber,
          licenseNumber: licenseNumber,
          createdAt: DateTime.now(),
          isActive: true,
        );

        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(doctor.toFirestore());

        return doctor;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Get current doctor
  Future<Doctor?> getCurrentDoctor() async {
    final user = currentUser;
    if (user == null) return null;

    try {
      final doctorDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (doctorDoc.exists) {
        return Doctor.fromFirestore(doctorDoc);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Update doctor profile
  Future<void> updateDoctorProfile(String doctorId, Map<String, dynamic> data) async {
    data['updatedAt'] = FieldValue.serverTimestamp();
    await _firestore.collection('users').doc(doctorId).update(data);
  }

  // Handle auth exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'Authentication error: ${e.message}';
    }
  }
}


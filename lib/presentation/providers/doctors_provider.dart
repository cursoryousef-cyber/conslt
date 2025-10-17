import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/doctor.dart';
import '../../domain/services/firestore_service.dart';

// Firestore Service Provider
final firestoreServiceProvider = Provider<FirestoreService>(
  (ref) => FirestoreService(),
);

// All Doctors Provider
final allDoctorsProvider = StreamProvider<List<Doctor>>((ref) {
  return ref.watch(firestoreServiceProvider).getAllDoctors();
});

// Doctors by Specialization Provider
final doctorsBySpecializationProvider = StreamProvider.family<List<Doctor>, String>(
  (ref, specialization) {
    return ref.watch(firestoreServiceProvider).getDoctorsBySpecialization(specialization);
  },
);

// Search Doctors Provider
final searchDoctorsProvider = StreamProvider.family<List<Doctor>, String>(
  (ref, query) {
    if (query.isEmpty) {
      return ref.watch(firestoreServiceProvider).getAllDoctors();
    }
    return ref.watch(firestoreServiceProvider).searchDoctors(query);
  },
);

// Selected Specialization Provider
final selectedSpecializationProvider = StateProvider<String?>((ref) => null);

// Search Query Provider
final searchQueryProvider = StateProvider<String>((ref) => '');


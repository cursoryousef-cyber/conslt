import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/consultation.dart';
import '../../domain/services/firestore_service.dart';
import 'auth_provider.dart';

// Sent Consultations Provider
final sentConsultationsProvider = StreamProvider<List<Consultation>>((ref) {
  final currentDoctor = ref.watch(currentDoctorProvider).value;
  if (currentDoctor == null) {
    return Stream.value([]);
  }
  return ref.watch(firestoreServiceProvider).getSentConsultations(currentDoctor.id);
});

// Received Consultations Provider
final receivedConsultationsProvider = StreamProvider<List<Consultation>>((ref) {
  final currentDoctor = ref.watch(currentDoctorProvider).value;
  if (currentDoctor == null) {
    return Stream.value([]);
  }
  return ref.watch(firestoreServiceProvider).getReceivedConsultations(currentDoctor.id);
});

// Consultation Tab Provider
final consultationTabProvider = StateProvider<int>((ref) => 0);

// Create Consultation Provider
final createConsultationProvider = StateNotifierProvider<CreateConsultationNotifier, AsyncValue<void>>(
  (ref) => CreateConsultationNotifier(ref.watch(firestoreServiceProvider)),
);

class CreateConsultationNotifier extends StateNotifier<AsyncValue<void>> {
  final FirestoreService _firestoreService;

  CreateConsultationNotifier(this._firestoreService) : super(const AsyncValue.data(null));

  Future<void> createConsultation(Consultation consultation) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _firestoreService.createConsultation(consultation);
    });
  }
}


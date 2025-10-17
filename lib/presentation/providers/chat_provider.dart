import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/chat.dart';
import '../../domain/services/firestore_service.dart';
import 'auth_provider.dart';

// User Chats Provider
final userChatsProvider = StreamProvider<List<Chat>>((ref) {
  final currentDoctor = ref.watch(currentDoctorProvider).value;
  if (currentDoctor == null) {
    return Stream.value([]);
  }
  return ref.watch(firestoreServiceProvider).getUserChats(currentDoctor.id);
});

// Chat Messages Provider
final chatMessagesProvider = StreamProvider.family<List<ChatMessage>, String>(
  (ref, chatId) {
    return ref.watch(firestoreServiceProvider).getMessages(chatId);
  },
);

// Send Message Provider
final sendMessageProvider = StateNotifierProvider<SendMessageNotifier, AsyncValue<void>>(
  (ref) => SendMessageNotifier(ref.watch(firestoreServiceProvider)),
);

class SendMessageNotifier extends StateNotifier<AsyncValue<void>> {
  final FirestoreService _firestoreService;

  SendMessageNotifier(this._firestoreService) : super(const AsyncValue.data(null));

  Future<void> sendMessage(ChatMessage message) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _firestoreService.sendMessage(message);
    });
  }
}


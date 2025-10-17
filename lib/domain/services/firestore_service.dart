import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/doctor.dart';
import '../../data/models/consultation.dart';
import '../../data/models/chat.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ========== Doctors ==========

  // Get all doctors
  Stream<List<Doctor>> getAllDoctors() {
    return _firestore
        .collection(AppConstants.usersCollection)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Doctor.fromFirestore(doc)).toList());
  }

  // Get doctors by specialization
  Stream<List<Doctor>> getDoctorsBySpecialization(String specialization) {
    return _firestore
        .collection(AppConstants.usersCollection)
        .where('specialization', isEqualTo: specialization)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Doctor.fromFirestore(doc)).toList());
  }

  // Get doctor by ID
  Future<Doctor?> getDoctorById(String doctorId) async {
    final doc =
        await _firestore.collection(AppConstants.usersCollection).doc(doctorId).get();
    if (doc.exists) {
      return Doctor.fromFirestore(doc);
    }
    return null;
  }

  // Search doctors
  Stream<List<Doctor>> searchDoctors(String query) {
    return _firestore
        .collection(AppConstants.usersCollection)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Doctor.fromFirestore(doc))
            .where((doctor) =>
                doctor.fullName.toLowerCase().contains(query.toLowerCase()) ||
                doctor.specialization.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }

  // ========== Consultations ==========

  // Create consultation
  Future<String> createConsultation(Consultation consultation) async {
    final docRef = await _firestore
        .collection(AppConstants.consultationsCollection)
        .add(consultation.toFirestore());
    return docRef.id;
  }

  // Get consultations sent by doctor
  Stream<List<Consultation>> getSentConsultations(String doctorId) {
    return _firestore
        .collection(AppConstants.consultationsCollection)
        .where('fromDoctorId', isEqualTo: doctorId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Consultation.fromFirestore(doc))
            .toList());
  }

  // Get consultations received by doctor
  Stream<List<Consultation>> getReceivedConsultations(String doctorId) {
    return _firestore
        .collection(AppConstants.consultationsCollection)
        .where('toDoctorId', isEqualTo: doctorId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Consultation.fromFirestore(doc))
            .toList());
  }

  // Update consultation
  Future<void> updateConsultation(
      String consultationId, Map<String, dynamic> data) async {
    data['updatedAt'] = FieldValue.serverTimestamp();
    await _firestore
        .collection(AppConstants.consultationsCollection)
        .doc(consultationId)
        .update(data);
  }

  // ========== Chats ==========

  // Create or get chat
  Future<String> getOrCreateChat(String currentUserId, String otherUserId) async {
    final participants = [currentUserId, otherUserId]..sort();
    final chatQuery = await _firestore
        .collection(AppConstants.chatsCollection)
        .where('participants', isEqualTo: participants)
        .limit(1)
        .get();

    if (chatQuery.docs.isNotEmpty) {
      return chatQuery.docs.first.id;
    }

    final chat = Chat(
      id: '',
      participants: participants,
      createdAt: DateTime.now(),
      unreadCount: {currentUserId: 0, otherUserId: 0},
    );

    final docRef = await _firestore
        .collection(AppConstants.chatsCollection)
        .add(chat.toFirestore());
    return docRef.id;
  }

  // Get user chats
  Stream<List<Chat>> getUserChats(String userId) {
    return _firestore
        .collection(AppConstants.chatsCollection)
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Chat.fromFirestore(doc)).toList());
  }

  // Send message
  Future<void> sendMessage(ChatMessage message) async {
    await _firestore
        .collection(AppConstants.chatsCollection)
        .doc(message.chatId)
        .collection(AppConstants.messagesCollection)
        .add(message.toFirestore());

    // Update chat last message
    await _firestore
        .collection(AppConstants.chatsCollection)
        .doc(message.chatId)
        .update({
      'lastMessage': message.message,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Get messages
  Stream<List<ChatMessage>> getMessages(String chatId) {
    return _firestore
        .collection(AppConstants.chatsCollection)
        .doc(chatId)
        .collection(AppConstants.messagesCollection)
        .orderBy('createdAt', descending: true)
        .limit(100)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessage.fromFirestore(doc))
            .toList());
  }

  // Mark messages as read
  Future<void> markMessagesAsRead(String chatId, String userId) async {
    final messagesSnapshot = await _firestore
        .collection(AppConstants.chatsCollection)
        .doc(chatId)
        .collection(AppConstants.messagesCollection)
        .where('senderId', isNotEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .get();

    final batch = _firestore.batch();
    for (var doc in messagesSnapshot.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }
}


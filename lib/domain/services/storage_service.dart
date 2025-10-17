import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  // Upload profile image
  Future<String> uploadProfileImage(File file, String userId) async {
    try {
      final fileName = '${userId}_${_uuid.v4()}.jpg';
      final ref = _storage.ref().child('profile_images/$fileName');
      
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }

  // Upload consultation file
  Future<String> uploadConsultationFile(File file, String consultationId) async {
    try {
      final extension = file.path.split('.').last;
      final fileName = '${consultationId}_${_uuid.v4()}.$extension';
      final ref = _storage.ref().child('consultation_files/$fileName');
      
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload consultation file: $e');
    }
  }

  // Upload chat file
  Future<String> uploadChatFile(File file, String chatId) async {
    try {
      final extension = file.path.split('.').last;
      final fileName = '${chatId}_${_uuid.v4()}.$extension';
      final ref = _storage.ref().child('chat_files/$fileName');
      
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload chat file: $e');
    }
  }

  // Delete file
  Future<void> deleteFile(String fileUrl) async {
    try {
      final ref = _storage.refFromURL(fileUrl);
      await ref.delete();
    } catch (e) {
      // Silently fail if file doesn't exist
    }
  }

  // Get upload progress
  Stream<double> getUploadProgress(UploadTask task) {
    return task.snapshotEvents.map((snapshot) {
      return snapshot.bytesTransferred / snapshot.totalBytes;
    });
  }
}


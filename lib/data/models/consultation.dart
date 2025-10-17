import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Consultation extends Equatable {
  final String id;
  final String fromDoctorId;
  final String toDoctorId;
  final String title;
  final String description;
  final List<String> attachments;
  final String status; // pending, in_progress, completed, cancelled
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? completedAt;
  final String? response;
  final List<String>? responseAttachments;

  const Consultation({
    required this.id,
    required this.fromDoctorId,
    required this.toDoctorId,
    required this.title,
    required this.description,
    this.attachments = const [],
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.completedAt,
    this.response,
    this.responseAttachments,
  });

  factory Consultation.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Consultation(
      id: doc.id,
      fromDoctorId: data['fromDoctorId'] ?? '',
      toDoctorId: data['toDoctorId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      attachments: List<String>.from(data['attachments'] ?? []),
      status: data['status'] ?? 'pending',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      completedAt: data['completedAt'] != null
          ? (data['completedAt'] as Timestamp).toDate()
          : null,
      response: data['response'],
      responseAttachments: data['responseAttachments'] != null
          ? List<String>.from(data['responseAttachments'])
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'fromDoctorId': fromDoctorId,
      'toDoctorId': toDoctorId,
      'title': title,
      'description': description,
      'attachments': attachments,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'completedAt':
          completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      'response': response,
      'responseAttachments': responseAttachments,
    };
  }

  Consultation copyWith({
    String? id,
    String? fromDoctorId,
    String? toDoctorId,
    String? title,
    String? description,
    List<String>? attachments,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    String? response,
    List<String>? responseAttachments,
  }) {
    return Consultation(
      id: id ?? this.id,
      fromDoctorId: fromDoctorId ?? this.fromDoctorId,
      toDoctorId: toDoctorId ?? this.toDoctorId,
      title: title ?? this.title,
      description: description ?? this.description,
      attachments: attachments ?? this.attachments,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      response: response ?? this.response,
      responseAttachments: responseAttachments ?? this.responseAttachments,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fromDoctorId,
        toDoctorId,
        title,
        description,
        attachments,
        status,
        createdAt,
        updatedAt,
        completedAt,
        response,
        responseAttachments,
      ];
}


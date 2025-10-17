import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String specialization;
  final String? phoneNumber;
  final String? profileImageUrl;
  final String? bio;
  final String? licenseNumber;
  final String? hospital;
  final List<String> languages;
  final int yearsOfExperience;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final String? fcmToken;

  const Doctor({
    required this.id,
    required this.email,
    required this.fullName,
    required this.specialization,
    this.phoneNumber,
    this.profileImageUrl,
    this.bio,
    this.licenseNumber,
    this.hospital,
    this.languages = const ['en'],
    this.yearsOfExperience = 0,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
    this.fcmToken,
  });

  factory Doctor.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Doctor(
      id: doc.id,
      email: data['email'] ?? '',
      fullName: data['fullName'] ?? '',
      specialization: data['specialization'] ?? '',
      phoneNumber: data['phoneNumber'],
      profileImageUrl: data['profileImageUrl'],
      bio: data['bio'],
      licenseNumber: data['licenseNumber'],
      hospital: data['hospital'],
      languages: List<String>.from(data['languages'] ?? ['en']),
      yearsOfExperience: data['yearsOfExperience'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      isActive: data['isActive'] ?? true,
      fcmToken: data['fcmToken'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'fullName': fullName,
      'specialization': specialization,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'licenseNumber': licenseNumber,
      'hospital': hospital,
      'languages': languages,
      'yearsOfExperience': yearsOfExperience,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'isActive': isActive,
      'fcmToken': fcmToken,
    };
  }

  Doctor copyWith({
    String? id,
    String? email,
    String? fullName,
    String? specialization,
    String? phoneNumber,
    String? profileImageUrl,
    String? bio,
    String? licenseNumber,
    String? hospital,
    List<String>? languages,
    int? yearsOfExperience,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    String? fcmToken,
  }) {
    return Doctor(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      specialization: specialization ?? this.specialization,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      hospital: hospital ?? this.hospital,
      languages: languages ?? this.languages,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        fullName,
        specialization,
        phoneNumber,
        profileImageUrl,
        bio,
        licenseNumber,
        hospital,
        languages,
        yearsOfExperience,
        createdAt,
        updatedAt,
        isActive,
        fcmToken,
      ];
}


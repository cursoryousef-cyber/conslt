import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/file_helper.dart';
import '../../../core/utils/validators.dart';
import '../../providers/auth_provider.dart';
import '../consultations/send_consultation_screen.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  late TextEditingController _hospitalController;
  late TextEditingController _bioController;
  File? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _phoneController = TextEditingController();
    _hospitalController = TextEditingController();
    _bioController = TextEditingController();

    // Load current doctor data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final doctor = ref.read(currentDoctorProvider).value;
      if (doctor != null) {
        _fullNameController.text = doctor.fullName;
        _phoneController.text = doctor.phoneNumber ?? '';
        _hospitalController.text = doctor.hospital ?? '';
        _bioController.text = doctor.bio ?? '';
      }
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _hospitalController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final file = await FileHelper.pickImageFromGallery();
    if (file != null) {
      setState(() {
        _selectedImage = file;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final doctor = ref.read(currentDoctorProvider).value;
      if (doctor == null) throw Exception('Doctor not found');

      String? imageUrl = doctor.profileImageUrl;

      // Upload new image if selected
      if (_selectedImage != null) {
        final storageService = ref.read(storageServiceProvider);
        imageUrl = await storageService.uploadProfileImage(
          _selectedImage!,
          doctor.id,
        );
      }

      // Update profile
      await ref.read(authServiceProvider).updateDoctorProfile(
        doctor.id,
        {
          'fullName': _fullNameController.text.trim(),
          'phoneNumber': _phoneController.text.trim(),
          'hospital': _hospitalController.text.trim(),
          'bio': _bioController.text.trim(),
          if (imageUrl != null) 'profileImageUrl': imageUrl,
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('profile_updated'.tr())),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${'error'.tr()}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctorAsync = ref.watch(currentDoctorProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('edit_profile'.tr()),
      ),
      body: doctorAsync.when(
        data: (doctor) {
          if (doctor == null) {
            return Center(child: Text('error'.tr()));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Profile Image
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : (doctor.profileImageUrl != null
                                  ? NetworkImage(doctor.profileImageUrl!)
                                  : null) as ImageProvider?,
                          child: _selectedImage == null &&
                                  doctor.profileImageUrl == null
                              ? Text(
                                  doctor.fullName.isNotEmpty
                                      ? doctor.fullName[0].toUpperCase()
                                      : 'D',
                                  style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                  ),
                                )
                              : null,
                        ),
                        const Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: AppTheme.primaryColor,
                            radius: 18,
                            child: Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXl),

                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: 'full_name'.tr(),
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                    validator: Validators.validateRequired,
                  ),
                  const SizedBox(height: AppTheme.spacingMd),

                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'phone_number'.tr(),
                      prefixIcon: const Icon(Icons.phone_outlined),
                    ),
                    validator: Validators.validatePhone,
                  ),
                  const SizedBox(height: AppTheme.spacingMd),

                  TextFormField(
                    controller: _hospitalController,
                    decoration: InputDecoration(
                      labelText: 'hospital'.tr(),
                      prefixIcon: const Icon(Icons.local_hospital_outlined),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMd),

                  TextFormField(
                    controller: _bioController,
                    decoration: InputDecoration(
                      labelText: 'bio'.tr(),
                      prefixIcon: const Icon(Icons.info_outline),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: AppTheme.spacingXl),

                  ElevatedButton(
                    onPressed: _isLoading ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text('save'.tr()),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('${'error'.tr()}: $error'),
        ),
      ),
    );
  }
}


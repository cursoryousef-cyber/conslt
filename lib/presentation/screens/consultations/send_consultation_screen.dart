import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/file_helper.dart';
import '../../../core/utils/validators.dart';
import '../../../data/models/consultation.dart';
import '../../providers/consultations_provider.dart';
import '../../providers/auth_provider.dart';
import '../../../domain/services/storage_service.dart';

final storageServiceProvider = Provider<StorageService>((ref) => StorageService());

class SendConsultationScreen extends ConsumerStatefulWidget {
  final String doctorId;

  const SendConsultationScreen({
    super.key,
    required this.doctorId,
  });

  @override
  ConsumerState<SendConsultationScreen> createState() => _SendConsultationScreenState();
}

class _SendConsultationScreenState extends ConsumerState<SendConsultationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<File> _attachedFiles = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickFiles() async {
    final files = await FileHelper.pickMultipleFiles(
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (files != null) {
      setState(() {
        _attachedFiles.addAll(files);
      });
    }
  }

  Future<void> _pickImages() async {
    final files = await FileHelper.pickMultipleImages();
    if (files != null) {
      setState(() {
        _attachedFiles.addAll(files);
      });
    }
  }

  void _removeFile(int index) {
    setState(() {
      _attachedFiles.removeAt(index);
    });
  }

  Future<void> _sendConsultation() async {
    if (!_formKey.currentState!.validate()) return;

    final currentDoctor = ref.read(currentDoctorProvider).value;
    if (currentDoctor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error'.tr())),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final consultationId = const Uuid().v4();
      final storageService = ref.read(storageServiceProvider);
      final List<String> uploadedUrls = [];

      // Upload files
      for (var file in _attachedFiles) {
        final url = await storageService.uploadConsultationFile(file, consultationId);
        uploadedUrls.add(url);
      }

      // Create consultation
      final consultation = Consultation(
        id: consultationId,
        fromDoctorId: currentDoctor.id,
        toDoctorId: widget.doctorId,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        attachments: uploadedUrls,
        status: 'pending',
        createdAt: DateTime.now(),
      );

      await ref.read(createConsultationProvider.notifier).createConsultation(consultation);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('consultation_sent'.tr())),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('send_consultation'.tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'consultation_title'.tr(),
                  prefixIcon: const Icon(Icons.title),
                ),
                validator: Validators.validateRequired,
              ),
              const SizedBox(height: AppTheme.spacingMd),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'consultation_description'.tr(),
                  prefixIcon: const Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: Validators.validateRequired,
              ),
              const SizedBox(height: AppTheme.spacingMd),
              
              // Attached Files
              if (_attachedFiles.isNotEmpty) ...[
                Text(
                  '${'attach_files'.tr()} (${_attachedFiles.length})',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingSm),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _attachedFiles.length,
                  itemBuilder: (context, index) {
                    final file = _attachedFiles[index];
                    final isImage = FileHelper.isImageFile(file);
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
                      child: ListTile(
                        leading: Icon(
                          isImage ? Icons.image : Icons.attach_file,
                          color: AppTheme.primaryColor,
                        ),
                        title: Text(
                          file.path.split('/').last,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '${FileHelper.getFileSizeInMB(file).toStringAsFixed(2)} MB',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => _removeFile(index),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppTheme.spacingMd),
              ],

              // Attach Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isLoading ? null : _pickImages,
                      icon: const Icon(Icons.image),
                      label: Text('attach_files'.tr()),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingSm),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isLoading ? null : _pickFiles,
                      icon: const Icon(Icons.attach_file),
                      label: Text('attach_files'.tr()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingXl),

              // Send Button
              ElevatedButton(
                onPressed: _isLoading ? null : _sendConsultation,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text('send'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


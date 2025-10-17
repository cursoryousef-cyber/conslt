import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorAsync = ref.watch(currentDoctorProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/edit-profile'),
          ),
        ],
      ),
      body: doctorAsync.when(
        data: (doctor) {
          if (doctor == null) {
            return Center(child: Text('error'.tr()));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Column(
              children: [
                // Profile Image
                CircleAvatar(
                  radius: 60,
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                  backgroundImage: doctor.profileImageUrl != null
                      ? NetworkImage(doctor.profileImageUrl!)
                      : null,
                  child: doctor.profileImageUrl == null
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
                const SizedBox(height: AppTheme.spacingMd),

                // Name
                Text(
                  doctor.fullName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingSm),

                // Specialization
                Chip(
                  label: Text(doctor.specialization.tr()),
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                  labelStyle: const TextStyle(color: AppTheme.primaryColor),
                ),
                const SizedBox(height: AppTheme.spacingLg),

                // Info Cards
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingMd),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          Icons.email_outlined,
                          'email'.tr(),
                          doctor.email,
                        ),
                        if (doctor.phoneNumber != null) ...[
                          const Divider(),
                          _buildInfoRow(
                            Icons.phone_outlined,
                            'phone_number'.tr(),
                            doctor.phoneNumber!,
                          ),
                        ],
                        if (doctor.hospital != null) ...[
                          const Divider(),
                          _buildInfoRow(
                            Icons.local_hospital_outlined,
                            'hospital'.tr(),
                            doctor.hospital!,
                          ),
                        ],
                        if (doctor.licenseNumber != null) ...[
                          const Divider(),
                          _buildInfoRow(
                            Icons.badge_outlined,
                            'license_number'.tr(),
                            doctor.licenseNumber!,
                          ),
                        ],
                        if (doctor.yearsOfExperience > 0) ...[
                          const Divider(),
                          _buildInfoRow(
                            Icons.work_outline,
                            'years_of_experience'.tr(),
                            '${doctor.yearsOfExperience}',
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // Bio
                if (doctor.bio != null) ...[
                  const SizedBox(height: AppTheme.spacingMd),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.spacingMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'bio'.tr(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingSm),
                          Text(doctor.bio!),
                        ],
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: AppTheme.spacingLg),

                // Logout Button
                ElevatedButton.icon(
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('logout'.tr()),
                        content: Text('${'logout'.tr()}?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text('cancel'.tr()),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text('logout'.tr()),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true && context.mounted) {
                      await ref.read(authServiceProvider).signOut();
                      if (context.mounted) {
                        context.go('/login');
                      }
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: Text('logout'.tr()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('${'error'.tr()}: $error'),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 3),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSm),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryColor),
          const SizedBox(width: AppTheme.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, int selectedIndex) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/consultations');
            break;
          case 2:
            context.go('/chats');
            break;
          case 3:
            context.go('/profile');
            break;
        }
      },
      selectedItemColor: AppTheme.primaryColor,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: 'home'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.medical_services_outlined),
          activeIcon: const Icon(Icons.medical_services),
          label: 'consultations'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.chat_outlined),
          activeIcon: const Icon(Icons.chat),
          label: 'chats'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          activeIcon: const Icon(Icons.person),
          label: 'profile'.tr(),
        ),
      ],
    );
  }
}


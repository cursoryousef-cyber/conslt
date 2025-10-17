import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/doctors_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/doctor_card.dart';
import '../../widgets/specialization_chip.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

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
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final selectedSpecialization = ref.watch(selectedSpecializationProvider);
    final doctorsAsync = selectedSpecialization != null
        ? ref.watch(doctorsBySpecializationProvider(selectedSpecialization))
        : searchQuery.isNotEmpty
            ? ref.watch(searchDoctorsProvider(searchQuery))
            : ref.watch(allDoctorsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('app_name'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'search'.tr(),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          ref.read(searchQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
                ref.read(selectedSpecializationProvider.notifier).state = null;
              },
            ),
          ),

          // Specializations
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
              children: [
                SpecializationChip(
                  label: 'all'.tr(),
                  isSelected: selectedSpecialization == null,
                  onTap: () {
                    ref.read(selectedSpecializationProvider.notifier).state = null;
                  },
                ),
                const SizedBox(width: AppTheme.spacingSm),
                ...AppConstants.medicalSpecializations.map(
                  (spec) => Padding(
                    padding: const EdgeInsets.only(right: AppTheme.spacingSm),
                    child: SpecializationChip(
                      label: spec.tr(),
                      isSelected: selectedSpecialization == spec,
                      onTap: () {
                        ref.read(selectedSpecializationProvider.notifier).state = spec;
                        ref.read(searchQueryProvider.notifier).state = '';
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppTheme.spacingMd),

          // Doctors List
          Expanded(
            child: doctorsAsync.when(
              data: (doctors) {
                if (doctors.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_search,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: AppTheme.spacingMd),
                        Text(
                          'no_data'.tr(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    final currentDoctor = ref.watch(currentDoctorProvider).value;
                    
                    // Don't show current doctor
                    if (currentDoctor?.id == doctor.id) {
                      return const SizedBox.shrink();
                    }

                    return DoctorCard(
                      doctor: doctor,
                      onTap: () {
                        context.push('/send-consultation/${doctor.id}');
                      },
                      onChatTap: () async {
                        // Create or get chat and navigate
                        context.push('/chats');
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('${'error'.tr()}: $error'),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
      ),
    );
  }
}


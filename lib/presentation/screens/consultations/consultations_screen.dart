import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/consultations_provider.dart';
import '../../widgets/consultation_card.dart';

class ConsultationsScreen extends ConsumerWidget {
  const ConsultationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(consultationTabProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('consultations'.tr()),
        bottom: TabBar(
          controller: DefaultTabController.of(context),
          onTap: (index) {
            ref.read(consultationTabProvider.notifier).state = index;
          },
          tabs: [
            Tab(text: 'received_consultations'.tr()),
            Tab(text: 'sent_consultations'.tr()),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: TabBarView(
          children: [
            // Received Consultations
            _ConsultationsList(
              consultationsProvider: receivedConsultationsProvider,
              isReceived: true,
            ),
            // Sent Consultations
            _ConsultationsList(
              consultationsProvider: sentConsultationsProvider,
              isReceived: false,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 1),
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

class _ConsultationsList extends ConsumerWidget {
  final ProviderListenable consultationsProvider;
  final bool isReceived;

  const _ConsultationsList({
    required this.consultationsProvider,
    required this.isReceived,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consultationsAsync = ref.watch(consultationsProvider);

    return consultationsAsync.when(
      data: (consultations) {
        if (consultations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.medical_services_outlined,
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
          padding: const EdgeInsets.all(AppTheme.spacingMd),
          itemCount: consultations.length,
          itemBuilder: (context, index) {
            return ConsultationCard(
              consultation: consultations[index],
              isReceived: isReceived,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('${'error'.tr()}: $error'),
      ),
    );
  }
}


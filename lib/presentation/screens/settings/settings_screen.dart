import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        children: [
          // Language Settings
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text('language'.tr()),
                  subtitle: Text(
                    context.locale.languageCode == 'ar'
                        ? 'arabic'.tr()
                        : 'english'.tr(),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showLanguageDialog(context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // Account Settings
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: Text('edit_profile'.tr()),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/edit-profile'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.lock_outline),
                  title: Text('change_password'.tr()),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Implement change password
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // Support & Info
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.support_agent),
                  title: Text('support'.tr()),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/support'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text('about'.tr()),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showAboutDialog(context);
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: Text('privacy_policy'.tr()),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Open privacy policy
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: Text('terms_conditions'.tr()),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Open terms
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // Version
          Card(
            child: ListTile(
              leading: const Icon(Icons.info),
              title: Text('version'.tr()),
              trailing: Text(
                AppConstants.appVersion,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('language'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: Text('english'.tr()),
              value: 'en',
              groupValue: context.locale.languageCode,
              onChanged: (value) {
                context.setLocale(const Locale('en'));
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: Text('arabic'.tr()),
              value: 'ar',
              groupValue: context.locale.languageCode,
              onChanged: (value) {
                context.setLocale(const Locale('ar'));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('about'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppConstants.appName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('${'version'.tr()}: ${AppConstants.appVersion}'),
            const SizedBox(height: 16),
            const Text(
              'A medical consultation app for doctors to communicate and collaborate.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}


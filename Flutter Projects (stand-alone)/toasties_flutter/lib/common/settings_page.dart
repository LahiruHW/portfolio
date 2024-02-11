import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toasties_flutter/common/widgets/colour_switch_toggle.dart';

const statusBarHeight = 35.0;

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: statusBarHeight,
            width: double.infinity,
          ),
          SizedBox(
            width: double.infinity,
            height: 70,
            child: NavigationToolbar(
              centerMiddle: false,
              leading: IconButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.transparent,
                  ),
                ),
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context)
                              .colorScheme
                              .background
                              .computeLuminance() >
                          0.5
                      ? Colors.black
                      : Colors.white,
                ),
                onPressed: () => GoRouter.of(context).pop(),
              ),
              middle: Text(
                "Settings",
                style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                      color: Theme.of(context)
                                  .colorScheme
                                  .background
                                  .computeLuminance() >
                              0.5
                          ? Colors.black
                          : Colors.white,
                    ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy'),
            titleTextStyle: Theme.of(context).textTheme.headlineSmall,
            onTap: null,
          ),
          ListTile(
            leading: const Icon(Icons.notifications_none_outlined),
            title: const Text('Notifications'),
            titleTextStyle: Theme.of(context).textTheme.headlineSmall,
            onTap: null,
          ),
          ExpansionTile(
            leading: const Icon(Icons.design_services_outlined),
            title: Text(
              'Personalisation',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            maintainState: true,
            children: const [
              ListTile(
                title: Text('Dark Mode'),
                trailing: ToastiesThemeModeToggle(),
              )
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.info),
            title: Text(
              'About',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            maintainState: false,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'LegalEase is a mobile application that aims to provide a platform for users to access legal services and information.\n\nIt is a project by the Toasties team for Kitahack 2024.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Version 1.0.0',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

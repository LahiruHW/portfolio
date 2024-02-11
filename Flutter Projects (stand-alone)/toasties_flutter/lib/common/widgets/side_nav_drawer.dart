import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/providers/state_provider.dart';
import 'package:toasties_flutter/common/providers/index.dart';

class ToastiesSideNavMenu extends StatelessWidget {
  const ToastiesSideNavMenu({
    super.key,
    this.currentIndex,
  });

  final int? currentIndex;

  // final homeMenuOptions = [
  //   ['Settings', '/settings'],
  //   ['Log Out', '/login-base'],
  // ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ToastieStateProvider>(
      builder: (context, authProvider, child) => NavigationDrawer(
        children: [
          Container(
            width: double.infinity,
            height: 75,
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'LegalEase',
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
          // ListTile(
          //   leading: const Icon(Icons.notifications_none_outlined),
          //   title: const Text('Notifications'),
          //   titleTextStyle: Theme.of(context).textTheme.headlineSmall,
          //   onTap: () {},
          // ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            titleTextStyle: Theme.of(context).textTheme.headlineSmall,
            // onTap: () {},
            onTap: () => GoRouter.of(context).push('/settings'),
          ),
        ]..add(
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text('Log Out'),
              titleTextStyle:
                  Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
              onTap: () {
                Future.delayed(
                  const Duration(milliseconds: 0),
                  () => GoRouter.of(context).go('/login-base'),
                ).then(
                  (value) {
                    Future.delayed(
                      const Duration(milliseconds: 3500),
                      () => authProvider.signOut(),
                    );
                    // stateProvider.clearUserProfileInstance();  <------ this should go here
                  },
                );
              },
            ),
          ),
      ),
    );
  }
}

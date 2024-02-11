import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

import 'package:toasties_flutter/screens/base.dart';
// import 'package:toasties_flutter/common/providers/state_provider.dart';
import 'package:toasties_flutter/screens/login/entrance_base.dart';
import 'package:toasties_flutter/screens/login/login_legalease.dart';
import 'package:toasties_flutter/screens/login/login_select.dart';
import 'package:toasties_flutter/screens/login/signup_legalease.dart';
import 'package:toasties_flutter/screens/home_page.dart';
import 'package:toasties_flutter/screens/chat_page.dart';
import 'package:toasties_flutter/screens/saved_page.dart';
import 'package:toasties_flutter/screens/profile_page.dart';
import 'package:toasties_flutter/screens/testpages.dart';
import 'package:toasties_flutter/common/settings_page.dart';

class ToastieRouter {
  static final _rootNavKey = GlobalKey<NavigatorState>();
  static final _homeNavKey = GlobalKey<NavigatorState>();
  static final _chatNavKey = GlobalKey<NavigatorState>();
  static final _savedNavKey = GlobalKey<NavigatorState>();
  static final _profileNavKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavKey,
    initialLocation: '/login-base',
    routes: <RouteBase>[
      // ShellRoute for the app BEFORE user login (i.e. during login/signup)
      ShellRoute(
        routes: [
          GoRoute(
            name: "login-base",
            path: '/login-base',
            pageBuilder: (context, state) =>
                const MaterialPage(child: LoginTypeSelectPage()),
          ),
          GoRoute(
            name: "login-uac",
            path: '/login-uac',
            pageBuilder: (context, state) => CustomTransitionPage(
              barrierColor:
                  Theme.of(context).colorScheme.background.computeLuminance() <
                          0.5
                      ? Colors.black.withOpacity(0.5)
                      : Colors.white.withOpacity(0.5),
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 500),
              child: const LoginLegalEase(),
              transitionsBuilder: (context, anim1, anim2, child) {
                // ideally I prefer a PageView-like slide transition,
                // but I got no idea how to do that within GoRouter()
                // (the normal SlideTransition only works for the incoming page)
                return FadeTransition(opacity: anim1, child: child);
              },
              maintainState: true,
            ),
          ),
          GoRoute(
            name: "signup-uac",
            path: '/signup-uac',
            pageBuilder: (context, state) => CustomTransitionPage(
              barrierColor:
                  Theme.of(context).colorScheme.background.computeLuminance() <
                          0.5
                      ? Colors.black.withOpacity(0.5)
                      : Colors.white.withOpacity(0.5),
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 500),
              child: const SignupLegalEase(),
              transitionsBuilder: (context, anim1, anim2, child) {
                return FadeTransition(opacity: anim1, child: child);
              },
              maintainState: true,
            ),
          ),
        ],
        builder: (context, state, child) => BaseEntrace(bodyWidget: child),
      ),

      // ShellRoute for the app AFTER the user has logged in
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) => Base(bodyWidget: child),
        branches: [
          // StatefulShellBranch for the HOME tab ----------------------------------------------
          StatefulShellBranch(
            navigatorKey: _homeNavKey,
            routes: [
              GoRoute(
                name: 'home',
                path: '/home',
                pageBuilder: (context, state) =>
                    const MaterialPage(child: HomePage()),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _homeNavKey,
                    path: 'test1',
                    builder: (context, state) => const TestPage1(),
                  ),
                ],
              ),
            ],
          ),

          // StatefulShellBranch for the CHAT tab ----------------------------------------------
          StatefulShellBranch(
            navigatorKey: _chatNavKey,
            routes: [
              GoRoute(
                name: "chat",
                path: '/chat',
                pageBuilder: (context, state) =>
                    const MaterialPage(child: ChatPage(), maintainState: true),
                routes: const [],
                onExit: (context) {
                  // final stateProvider =
                  //     Provider.of<ToastieStateProvider>(context, listen: false);
                  
                  // stateProvider.updateCurrentChatID();

                  // stateProvider.updateCurrentChatInFirebaseStorageTEMP();
                  
                  return true;
                },
              ),
            ],
          ),

          // StatefulShellBranch for the SAVED tab ---------------------------------------------
          StatefulShellBranch(
            navigatorKey: _savedNavKey,
            routes: [
              GoRoute(
                name: "saved",
                path: '/saved',
                pageBuilder: (context, state) =>
                    MaterialPage(child: SavedPage()),
                routes: const [],
              ),
            ],
          ),

          // StatefulShellBranch for the PROFILE tab -------------------------------------------
          StatefulShellBranch(
            navigatorKey: _profileNavKey,
            routes: [
              GoRoute(
                name: "profile",
                path: '/profile',
                pageBuilder: (context, state) => MaterialPage(
                  child: ProfilePage(),
                ),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _profileNavKey,
                    path: 'test2',
                    builder: (context, state) => const TestPage2(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        name: "settings",
        path: '/settings',
        pageBuilder: (context, state) =>
            const MaterialPage(child: SettingsPage(), maintainState: true),
      ),
    ],
  );
}

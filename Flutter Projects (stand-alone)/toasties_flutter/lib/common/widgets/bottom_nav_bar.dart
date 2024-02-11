import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ToastiesBottomNavBar extends StatefulWidget {
  const ToastiesBottomNavBar({
    super.key,
    this.index,
    required this.navShell,
  });

  final int? index;
  final StatefulNavigationShell navShell;

  @override
  State<ToastiesBottomNavBar> createState() => _ToastiesBottomNavBarState();
}

class _ToastiesBottomNavBarState extends State<ToastiesBottomNavBar> {
  late int selectedIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   selectedIndex = widget.index ?? 0;
  // }

  // void _onTapped(int index) {
  //   if (selectedIndex == index) return;

  //   setState(() => selectedIndex = index);

  //   switch (index) {
  //     case 0:
  //       GoRouter.of(context).push(
  //         '/home',
  //         extra: {'bottomNavbarIndex': 0},
  //       );
  //       break;
  //     case 1:
  //       GoRouter.of(context).push(
  //         '/chat',
  //         extra: {'bottomNavbarIndex': 1},
  //       );
  //       break;
  //     case 2:
  //       GoRouter.of(context).push(
  //         '/saved',
  //         extra: {'bottomNavbarIndex': 2},
  //       );
  //       break;
  //     case 3:
  //       GoRouter.of(context).push(
  //         '/profile',
  //         extra: {'bottomNavbarIndex': 3},
  //       );
  //       break;
  //   }
  // }

  void _onTappedNew(BuildContext context, int index) {
    widget.navShell.goBranch(
      index,
      initialLocation: index == widget.navShell.currentIndex,
    );
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 1,
      currentIndex: selectedIndex,
      // currentIndex: (GoRouterState.of(context).extra as Map<String, dynamic>?)?['bottomNavbarIndex'] ?? 0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_sharp),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_outlined),
          activeIcon: Icon(Icons.chat_rounded),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border_rounded),
          activeIcon: Icon(Icons.bookmark_rounded),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          activeIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
      
      // onTap: _onTapped,
      
      onTap: (index) => _onTappedNew(context, index),

    );
  }
}

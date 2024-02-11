import 'package:flutter/material.dart';

class SpotifyBottomNavBar extends StatelessWidget {
  const SpotifyBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(166, 27, 26, 28),
      unselectedItemColor: Colors.white,
      selectedLabelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: "Avenir Next",
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: "Avenir Next",
        fontWeight: FontWeight.w400,
      ),
      onTap: (value) {
        print(
            "------------------------------- touched bottom navbar item no. $value");

        if (value == 0) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (value == 1) {
          Navigator.of(context).pushNamed("/search_screen");
        } else if (value == 2) {
          Navigator.of(context).pushNamed("/your_library_screen");
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Image.asset("assets/images/icons/home.png", scale: 2.0),
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Image.asset("assets/images/icons/search.png", scale: 2.0),
          ),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child:
                Image.asset("assets/images/icons/your_library.png", scale: 2.0),
          ),
          label: "Your Library",
        ),
      ],
    );
  }
}

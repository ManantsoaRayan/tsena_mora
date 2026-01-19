import 'package:flutter/material.dart';
import 'package:tsena_mora/utils/navigation_helper.dart';

mixin NavigationMixin<T extends StatefulWidget> on State<T> {
  int currentNavIndex = 0;

  void initNavigation(String? currentRoute) {
    currentNavIndex = NavigationHelper.getNavIndexForRoute(currentRoute);
  }

  void handleNavigation(int index) {
    NavigationHelper.handleBottomNavigation(
      context,
      index,
      currentNavIndex,
      (newIndex) {
        setState(() {
          currentNavIndex = newIndex;
        });
      },
    );
  }

  AppBar buildAppBar({
    required String title,
    required String subtitle,
    required double expandedHeight,
  }) {
    return AppBar(
      title: Text(title),
      // : Text(subtitle),
      // expandedHeight: expandedHeight,
    );
  }

  BottomNavigationBar buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: currentNavIndex,
      onTap: handleNavigation,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: 'Recherche',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_rounded),
          label: 'Favoris',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Profil',
        ),
      ],
    );
  }
}

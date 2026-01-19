import 'package:flutter/material.dart';

class NavigationHelper {
  static void handleBottomNavigation(
    BuildContext context,
    int index,
    int currentIndex,
    Function(int) onIndexChanged,
  ) {
    // Only navigate if selecting a different tab
    if (index == currentIndex) {
      return;
    }

    onIndexChanged(index);

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        // Search/Explore page
        Navigator.pushReplacementNamed(context, '/search');
        break;
      case 2:
        // Favorites page
        Navigator.pushReplacementNamed(context, '/favorites');
        break;
      case 3:
        // Profile page
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  static int getNavIndexForRoute(String? routeName) {
    switch (routeName) {
      case '/home':
        return 0;
      case '/search':
        return 1;
      case '/favorites':
        return 2;
      case '/profile':
        return 3;
      default:
        return 0;
    }
  }
}

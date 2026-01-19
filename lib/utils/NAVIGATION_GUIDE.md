# Navigation Guide

## Overview
This document explains how navigation is handled across the application using the `NavigationHelper` utility.

## File Structure

### Core Navigation Files
- `lib/utils/navigation_helper.dart` - Centralized navigation logic
- `lib/utils/navigation_mixin.dart` - Reusable mixin for views (optional, for future use)
- `lib/main.dart` - App routing configuration

## Navigation Routes

The app currently supports the following routes:

| Route | Index | View | Description |
|-------|-------|------|-------------|
| `/home` | 0 | HomeView | Main product listing page |
| `/search` | 1 | SearchView | Search and explore products |
| `/favorites` | 2 | FavoritesView | Favorite products page |
| `/profile` | 3 | ProfileView | User profile page |
| `/welcome` | - | WelcomeView | Initial welcome screen |
| `/login` | - | LoginView | User login |
| `/register` | - | RegisterView | User registration |

## NavigationHelper Class

### Purpose
Provides centralized, reusable navigation logic to ensure consistent behavior across all views.

### Key Methods

#### `handleBottomNavigation()`
Handles bottom navigation bar taps with the following logic:
- Prevents navigation if the same tab is already selected
- Updates the current index
- Navigates to the appropriate route using `pushReplacementNamed()`

```dart
NavigationHelper.handleBottomNavigation(
  context,
  index,           // Selected tab index
  currentIndex,    // Current tab index
  onIndexChanged,  // Callback to update local state
);
```

#### `getNavIndexForRoute()`
Returns the bottom nav bar index for a given route name.
Useful for setting the correct active tab when deep linking or returning from other screens.

```dart
int index = NavigationHelper.getNavIndexForRoute('/favorites'); // Returns 2
```

## Implementation Pattern

### In Views with Bottom Navigation

1. **Add import:**
```dart
import 'package:tsena_mora/utils/navigation_helper.dart';
```

2. **Set current index in initState:**
```dart
@override
void initState() {
  super.initState();
  _currentNavIndex = 0; // For HomeView
}
```

3. **Handle navigation with helper:**
```dart
void _handleNavigation(int index) {
  NavigationHelper.handleBottomNavigation(
    context,
    index,
    _currentNavIndex,
    (newIndex) {
      setState(() {
        _currentNavIndex = newIndex;
      });
    },
  );
}
```

4. **Use AppBottomNavBar in scaffold:**
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    bottomNavigationBar: AppBottomNavBar(
      currentIndex: _currentNavIndex,
      onTap: _handleNavigation,
    ),
    // ... rest of scaffold
  );
}
```

## Current Implementation Status

### ✅ Completed Views
- **HomeView** - Uses NavigationHelper
- **FavoritesView** - Uses NavigationHelper

### ⏳ Views Needing Update (when created)
- SearchView - Should use NavigationHelper
- ProfileView - Should use NavigationHelper

### ⚠️ Views without Navigation Bar
- WelcomeView - Authentication screen
- LoginView - Authentication screen
- RegisterView - Authentication screen

## Best Practices

### Do ✅
- Use `NavigationHelper.handleBottomNavigation()` for all bottom nav taps
- Always update `_currentNavIndex` in the callback
- Use `pushReplacementNamed()` to prevent back stack issues
- Check the current index to prevent unnecessary navigation

### Don't ❌
- Manually handle each navigation case in every view
- Use `push()` instead of `pushReplacementNamed()` for bottom nav
- Create duplicate navigation logic across views
- Allow navigation to the same page multiple times

## Deep Linking Consideration

When implementing deep linking in the future, use `getNavIndexForRoute()` to set the correct active tab:

```dart
int targetIndex = NavigationHelper.getNavIndexForRoute(deepLinkRoute);
// Set the active tab accordingly
```

## Future Enhancements

1. **NavigationMixin** - A reusable mixin has been created but not yet integrated. It can reduce boilerplate in views.

2. **Route Transitions** - Custom transitions can be added to `NavigationHelper` for animations.

3. **Navigation History** - Track navigation history for analytics or debugging.

4. **Dynamic Route Generation** - Use the router package for more complex navigation patterns.

## Troubleshooting

### Issue: Duplicate pushes to the same route
**Solution:** Ensure you're using `pushReplacementNamed()` not `push()` in the helper.

### Issue: Bottom nav index not updating
**Solution:** Make sure the callback `onIndexChanged` is being called and `setState()` is invoked.

### Issue: Wrong tab highlighted after navigation
**Solution:** Verify `_currentNavIndex` is being set correctly in `initState()` for each view.

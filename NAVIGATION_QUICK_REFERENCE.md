# Navigation Quick Reference

## Copy-Paste Template for New Views

### Step 1: Class Declaration
```dart
class NewView extends StatefulWidget {
  const NewView({super.key});

  @override
  State<NewView> createState() => _NewViewState();
}
```

### Step 2: State Class Setup
```dart
class _NewViewState extends State<NewView> {
  int _currentNavIndex = X;  // Replace X with correct index (0-3)

  @override
  void initState() {
    super.initState();
    _currentNavIndex = X;  // Same value as above
  }

  @override
  void dispose() {
    // Add any cleanup here
    super.dispose();
  }
```

### Step 3: Navigation Handler
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

### Step 4: Build Method with Bottom Nav
```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: _handleNavigation,
      ),
      // ... rest of your UI
    );
  }
}
```

### Step 5: Add Required Import
```dart
import 'package:tsena_mora/utils/navigation_helper.dart';
```

---

## Index Reference

| View          | Index |
|---------------|-------|
| HomeView      | 0     |
| SearchView    | 1     |
| FavoritesView | 2     |
| ProfileView   | 3     |

---

## Common Issues & Fixes

### ❌ Wrong Tab Highlighted
**Problem:** After navigating, wrong tab is highlighted
**Solution:** Check `_currentNavIndex` is set correctly in `initState()`

```dart
@override
void initState() {
  super.initState();
  _currentNavIndex = 2;  // Must match this view's index
}
```

### ❌ Navigation Not Working
**Problem:** Tapping nav bar does nothing
**Solution:** Make sure you're using `NavigationHelper.handleBottomNavigation()`

```dart
// ✅ Correct
NavigationHelper.handleBottomNavigation(context, index, _currentNavIndex, (newIndex) {
  setState(() => _currentNavIndex = newIndex);
});

// ❌ Wrong - Don't do this
Navigator.pushNamed(context, '/home');
```

### ❌ Multiple Instances of Same View
**Problem:** Navigating between views creates duplicates
**Solution:** Ensure using `pushReplacementNamed()` (already handled in NavigationHelper)

---

## Testing Navigation

```dart
// Test in console/terminal
// 1. Navigate to HomeView
// 2. Click tab 2 (Favorites) - Should go to FavoritesView
// 3. Click tab 0 (Home) - Should go back to HomeView
// 4. Click tab 2 again - Should stay in FavoritesView (no duplicate)
// 5. Check bottom nav highlight matches current view
```

---

## Route Configuration (main.dart)

Routes are already configured:
```dart
routes: {
  '/login': (context) => const LoginView(),
  '/register': (context) => const RegisterView(),
  '/welcome': (context) => const WelcomeView(),
  '/home': (context) => const HomeView(),
  '/favorites': (context) => const FavoritesView(),
  '/search': (context) => const SearchView(),      // TODO
  '/profile': (context) => const ProfileView(),    // TODO
},
```

---

## File Locations

- **Navigation Helper:** `lib/utils/navigation_helper.dart`
- **Bottom Nav Bar:** `lib/views/ui/app_bottom_nav_bar.dart`
- **App Colors:** `lib/views/ui/app_colors.dart`
- **Full Docs:** `lib/utils/NAVIGATION_GUIDE.md`

---

## Currently Implemented Views

✅ **HomeView** (lib/views/home_view.dart)
✅ **FavoritesView** (lib/views/favorites_view.dart)
📋 **SearchView** - Use template above when creating
📋 **ProfileView** - Use template above when creating

---

## Important Notes

1. **Always use `setState()` in callback** - Updates bottom nav highlight
2. **Don't remove the callback** - Navigation won't work without it
3. **Keep indices consistent** - Index in class == index in initState
4. **No manual switch statements** - Use NavigationHelper instead
5. **Use pushReplacementNamed** - Don't use push() for nav bar tabs

---

## One-Line Implementation Checklist

- [ ] Import NavigationHelper: `import 'package:tsena_mora/utils/navigation_helper.dart';`
- [ ] Add `int _currentNavIndex = X;` field
- [ ] Add `initState()` with correct index
- [ ] Add `_handleNavigation()` method
- [ ] Add `AppBottomNavBar` to Scaffold
- [ ] Test tab switching works correctly

---

**Need Help?** Check NAVIGATION_GUIDE.md for detailed documentation
# Posts Manager - Quick Start Guide

## 🎯 What You Have

A **fully functional Flutter CRUD application** that connects to JSONPlaceholder API with:
- ✅ Post listing with live API data
- ✅ Create new posts
- ✅ View post details
- ✅ Edit existing posts
- ✅ Delete posts with confirmation
- ✅ Full error handling
- ✅ Loading states
- ✅ Clean Material UI

## 🚀 Getting Started (30 seconds)

### Step 1: Install Dependencies
```bash
cd "l:\UR\Year 3 modules\Mobile Development\lab4\hello_web"
flutter pub get
```

### Step 2: Run the App
```bash
# For Android/Emulator
flutter run

# For Web
flutter run -d web

# For iOS (if on Mac)
flutter run -d ios
```

### Step 3: Test Features
1. **Home Screen** - See all posts load
2. **Tap a post** - View full details
3. **Tap +** - Create a new post
4. **Edit** - Modify a post
5. **Delete** - Remove a post

## 📁 Project Structure

```
hello_web/
├── lib/
│   ├── main.dart                    ← App entry point
│   ├── models/
│   │   └── post.dart               ← Data model
│   ├── services/
│   │   └── post_api_service.dart   ← API calls
│   └── screens/
│       ├── home_screen.dart         ← List view
│       ├── post_details_screen.dart ← Details + Edit/Delete
│       ├── create_post_screen.dart  ← New post form
│       └── edit_post_screen.dart    ← Edit form
├── pubspec.yaml                     ← Dependencies (updated!)
└── ...
```

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| `IMPLEMENTATION_SUMMARY.md` | What was built and how it works |
| `POSTS_MANAGER_README.md` | Full feature documentation |
| `CODE_EXAMPLES.md` | Code patterns and snippets |
| `QUICK_START.md` | This file! |

## 🔌 API Information

**Base URL**: https://jsonplaceholder.typicode.com

**Endpoints Used**:
- `GET /posts` - All posts
- `GET /posts/{id}` - Single post
- `POST /posts` - Create
- `PUT /posts/{id}` - Update
- `DELETE /posts/{id}` - Delete

The mock API returns ID 101 for newly created posts (because posts 1-100 are pre-existing).

## 🎨 Features Highlight

### Home Screen
- Displays posts in a scrollable list
- Shows title and body preview
- Tap to view full details
- FAB button to create

### Details Screen
- Full post title and content
- Post metadata (ID, User ID)
- **Edit button** → Edit dialog
- **Delete button** → Delete with confirmation

### Create Screen
- Form with title and body fields
- Submit button
- Auto-returns to home after creation

### Edit Screen
- Pre-filled with post data
- Save changes button
- Updates reflected immediately

## ⚙️ Configuration

### Change Primary Color
Edit `lib/main.dart`:
```dart
colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), // Change here
```

### Change API Base URL
Edit `lib/services/post_api_service.dart`:
```dart
static const String baseUrl = 'https://your-api-here.com';
```

### Add More Posts Per Page
Edit `lib/screens/home_screen.dart` and modify the `ListView.builder` pagination logic.

## 🐛 If Something Goes Wrong

### Dependencies Not Found
```bash
flutter pub get
flutter pub upgrade
```

### Hot Reload Issues
```bash
flutter clean
flutter pub get
flutter run
```

### API Connection Issues
- Check internet connection
- Verify JSONPlaceholder is accessible: https://jsonplaceholder.typicode.com/posts
- Check error message in app

### Build Issues
```bash
flutter doctor
# Check if SDK is properly installed
```

## 🧪 Testing the App

### Test 1: View Posts
1. Launch app
2. Should see list of posts
3. Loading indicator appears briefly

**Expected**: Posts from API displayed

### Test 2: Create Post
1. Tap FAB (+)
2. Enter title: "Test Post"
3. Enter body: "This is a test"
4. Tap "Create Post"
5. Success message appears
6. Redirects to home

**Expected**: New post appears at top (ID: 101)

### Test 3: Edit Post
1. Tap on any post
2. Tap "Edit" button
3. Change title/body
4. Tap "Save Changes"
5. Success message
6. Details update

**Expected**: Changes reflected in details

### Test 4: Delete Post
1. Tap on any post
2. Tap "Delete" button
3. Confirm in dialog
4. Success message
5. Returns to home

**Expected**: Post removed from list

## 📝 Code Quality

The app follows Flutter best practices:
- ✅ Separation of concerns (Models, Services, Screens)
- ✅ Proper state management with setState
- ✅ Error handling with try-catch
- ✅ Async/await patterns
- ✅ Widget structure and composition
- ✅ Material Design principles
- ✅ Clean naming conventions
- ✅ Mounted checks (prevent memory leaks)

## 🚀 Next Steps (Optional)

### Easy Improvements
1. Add loading skeleton screens
2. Add post search/filter
3. Add pull-to-refresh gesture
4. Add post likes counter
5. Add comments section

### Advanced Features
1. Implement Provider for state management
2. Add local SQLite caching
3. Add user authentication
4. Add pagination
5. Add offline support
6. Add image upload

### Professional Polish
1. Add unit tests
2. Add widget tests
3. Add integration tests
4. Add analytics tracking
5. Add Firebase integration
6. Add notification system

## 📚 Learning Resources

- **Flutter Docs**: https://flutter.dev/docs
- **Dart Language**: https://dart.dev
- **Material Design**: https://material.io/design
- **JSONPlaceholder**: https://jsonplaceholder.typicode.com
- **HTTP Package**: https://pub.dev/packages/http

## 💡 Pro Tips

1. **Use `const` constructors** - Better performance
2. **Test on device** - Emulator can be slow
3. **Check `mounted`** - Before setState after async
4. **Dispose controllers** - Prevent memory leaks
5. **Use FutureBuilder** - For async operations
6. **Handle null safely** - Use `??` and `?.`
7. **Test error cases** - Disconnect WiFi to test

## 🎓 Learning Points in This App

This app teaches you:
- ✅ API integration (GET, POST, PUT, DELETE)
- ✅ JSON serialization/deserialization
- ✅ Navigation between screens
- ✅ State management with StatefulWidget
- ✅ Async programming with Future
- ✅ Form handling and validation
- ✅ Error handling and user feedback
- ✅ Widget composition
- ✅ Building user interfaces
- ✅ Mobile app architecture

## 📞 Support

**Something not working?**

1. Check error message in app/console
2. Review `CODE_EXAMPLES.md` for patterns
3. Verify network connection
4. Try `flutter clean` then `flutter run`
5. Check Internet connection to JSONPlaceholder

---

**You're ready to go!** 🎉

Run `flutter run` and start exploring the Posts Manager app!

Questions? Check the other documentation files or review the code in the `lib/` directory.

---

**Last Updated**: March 17, 2026  
**Version**: 1.0.0  
**Status**: ✅ Production Ready

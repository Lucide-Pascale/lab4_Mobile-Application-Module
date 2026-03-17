# Posts Manager - Flutter App

A complete Flutter mobile application that demonstrates CRUD operations (Create, Read, Update, Delete) with the JSONPlaceholder API.

## Features

### 1. Home Screen / Post List
- Display all posts from the JSONPlaceholder API
- Each post shows title and a preview of the body text
- Tap on any post to view full details
- Floating action button to create new posts
- Pull-to-refresh by navigating back from other screens

### 2. Post Details Screen
- View the complete post title and body
- Display post metadata (ID and User ID)
- **Edit Button**: Navigate to the edit screen
- **Delete Button**: Opens a confirmation dialog before deleting
- Smooth navigation back to home screen

### 3. Create Post Screen
- Input fields for post title and body
- Form validation (ensures fields are not empty)
- Submit button to create post via POST request
- Success notification on completion
- Automatic navigation back to home screen with new post

### 4. Edit Post Screen
- Pre-populated fields with existing post data
- Modify title and body
- Save changes via PUT request
- Success notification on completion
- Updated data reflected on details screen

### 5. Delete Post
- Confirmation dialog prevents accidental deletions
- DELETE request to API
- Automatic removal from post list
- Success notification

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── post.dart            # Post data model
├── services/
│   └── post_api_service.dart # API integration service
└── screens/
    ├── home_screen.dart           # Home/List screen
    ├── post_details_screen.dart   # Details screen
    ├── create_post_screen.dart    # Create screen
    └── edit_post_screen.dart      # Edit screen
```

## API Integration

Uses the **JSONPlaceholder API** (https://jsonplaceholder.typicode.com/posts) for all operations:

- **GET /posts** - Fetch all posts
- **GET /posts/{id}** - Fetch single post
- **POST /posts** - Create new post
- **PUT /posts/{id}** - Update existing post
- **DELETE /posts/{id}** - Delete post

Error handling includes:
- Try-catch blocks for all API calls
- User-friendly error messages via SnackBar
- Retry functionality on home screen
- Loading indicators during API requests

## State Management

The app uses **StatefulWidget** with `setState` for simplicity. This approach is sufficient for the app's complexity and provides:
- Reactive UI updates
- Local state management for posts list
- Proper lifecycle management

## UI/UX Features

- **Material Design**: Uses Flutter Material components and design principles
- **Color Scheme**: Deep purple theme for professional appearance
- **Loading Indicators**: CircularProgressIndicator during data fetching
- **Confirmation Dialogs**: AlertDialog for delete confirmations
- **Error Handling**: Error screens with retry buttons
- **Snack Notifications**: Toast-like messages for user feedback
- **Responsive Layout**: Single child scroll view for various screen sizes

## Navigation

- **Navigator.push()**: Navigate to details, create, and edit screens
- **Navigator.pop()**: Return to previous screen with optional data
- Maintains navigation stack properly

## Getting Started

### Prerequisites
- Flutter SDK installed
- Android emulator or physical device connected

### Installation

1. Navigate to the project directory:
```bash
cd hello_web
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

For web:
```bash
flutter run -d web
```

## Testing the App

1. **View Posts**: App opens to home screen with all posts from API
2. **View Details**: Tap any post to see full content
3. **Create Post**: Tap FAB, fill in title and body, submit
4. **Edit Post**: On details screen, tap Edit, modify fields, save
5. **Delete Post**: On details screen, tap Delete, confirm
6. **Navigation**: Use back button to return to previous screens

## Dependencies

- **http: ^1.1.0** - For HTTP requests (GET, POST, PUT, DELETE)
- **flutter**: - Core Flutter framework

## Error Handling

The app handles various error scenarios:
- Network failures
- Invalid API responses
- Empty form submission
- HTTP status code errors

All errors are caught and displayed to the user with appropriate messages and actionable options (like Retry button).

## Future Enhancements

Potential improvements:
- State management library (Provider, Riverpod, GetX)
- Local caching with SQLite
- Search and filter functionality
- Pagination for large lists
- Offline support
- User authentication
- Advanced error analytics

## API Response Notes

JSONPlaceholder returns:
- `id`: Post identifier (auto-incremented)
- `userId`: Associated user ID
- `title`: Post title
- `body`: Post content

New posts created via this API will return an ID of 101 (since the API is a mock).

---

**Author**: Flutter Development Team  
**Version**: 1.0.0  
**Last Updated**: 2026

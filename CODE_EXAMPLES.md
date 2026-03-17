# Posts Manager - Code Examples & Quick Reference

## Quick Start

### 1. Running the App

```bash
cd "l:\UR\Year 3 modules\Mobile Development\lab4\hello_web"
flutter pub get
flutter run
```

## Key Code Patterns

### 1. API Service - Making Requests

#### Fetch All Posts
```dart
Future<List<Post>> fetchPosts() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Post.fromJson(json)).toList();
    }
  } catch (e) {
    throw Exception('Error fetching posts: $e');
  }
}
```

#### Create Post (POST Request)
```dart
Future<Post> createPost({
  required String title,
  required String body,
}) async {
  final response = await http.post(
    Uri.parse('$baseUrl/posts'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'title': title, 'body': body, 'userId': 1}),
  );
  if (response.statusCode == 201) {
    return Post.fromJson(jsonDecode(response.body));
  }
}
```

#### Update Post (PUT Request)
```dart
Future<Post> updatePost({
  required int id,
  required String title,
  required String body,
}) async {
  final response = await http.put(
    Uri.parse('$baseUrl/posts/$id'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'id': id, 'title': title, 'body': body, 'userId': 1}),
  );
  if (response.statusCode == 200) {
    return Post.fromJson(jsonDecode(response.body));
  }
}
```

#### Delete Post (DELETE Request)
```dart
Future<void> deletePost(int id) async {
  final response = await http.delete(Uri.parse('$baseUrl/posts/$id'));
  if (response.statusCode != 200) {
    throw Exception('Failed to delete post');
  }
}
```

### 2. Screen Navigation with Data Passing

#### Navigate to Details Screen
```dart
void _navigateToDetails(Post post) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PostDetailsScreen(post: post),
    ),
  ).then((_) {
    // Refresh when returning
    _loadPosts();
  });
}
```

#### Navigate and Return Data
```dart
void _navigateToEdit() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditPostScreen(post: _currentPost),
    ),
  ).then((updatedPost) {
    if (updatedPost != null && updatedPost is Post) {
      setState(() {
        _currentPost = updatedPost;
      });
    }
  });
}
```

### 3. Error Handling & User Feedback

#### Show Error SnackBar
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Error: $e'),
    backgroundColor: Colors.red,
  ),
);
```

#### Show Success Notification
```dart
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('Post created successfully'),
    backgroundColor: Colors.green,
  ),
);
```

#### Confirmation Dialog
```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Delete Post'),
    content: const Text('Are you sure you want to delete this post?'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          _performDelete();
        },
        child: const Text('Delete', style: TextStyle(color: Colors.red)),
      ),
    ],
  ),
);
```

### 4. FutureBuilder Pattern (Async UI)

```dart
FutureBuilder<List<Post>>(
  future: _postsFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (_posts.isEmpty) {
      return const Center(child: Text('No posts available'));
    }
    
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) => PostCard(post: _posts[index]),
    );
  },
)
```

### 5. Form Validation

```dart
void _submitPost() {
  final title = _titleController.text.trim();
  final body = _bodyController.text.trim();

  if (title.isEmpty || body.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please fill in all fields'),
        backgroundColor: Colors.orange,
      ),
    );
    return;
  }
  
  // Proceed with submission
  _performSubmit(title, body);
}
```

### 6. Post Model - JSON Conversion

```dart
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({required this.id, required this.userId, required this.title, required this.body});

  // From JSON
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  // Copy with modifications
  Post copyWith({String? title, String? body}) {
    return Post(
      id: id,
      userId: userId,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}
```

### 7. Material Theme Configuration

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posts Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```

### 8. Loading State in UI

```dart
Scaffold(
  body: _isLoading
    ? const Center(child: CircularProgressIndicator())
    : YourContentWidget(),
)
```

### 9. Async Operation with Loading

```dart
void _performDelete() async {
  setState(() { _isDeleting = true; });

  try {
    await PostApiService.deletePost(_currentPost.id);
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post deleted'), backgroundColor: Colors.green),
    );
    Navigator.pop(context, true);
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
    );
    setState(() { _isDeleting = false; });
  }
}
```

## Common Patterns Used

### Pattern 1: StatefulWidget with setState
```dart
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() {
    setState(() {
      _postsFuture = PostApiService.fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: _postsFuture,
      builder: (context, snapshot) { ... },
    );
  }
}
```

### Pattern 2: Text Field with Controller
```dart
late TextEditingController _titleController;

@override
void initState() {
  super.initState();
  _titleController = TextEditingController(text: initialValue);
}

@override
void dispose() {
  _titleController.dispose();
  super.dispose();
}

@override
Widget build(BuildContext context) {
  return TextField(
    controller: _titleController,
    decoration: InputDecoration(
      hintText: 'Enter title',
      border: OutlineInputBorder(),
    ),
  );
}
```

### Pattern 3: Mounted Check (Prevent Memory Leaks)
```dart
void _asyncOperation() async {
  try {
    final result = await someAsyncCall();
    
    // Check if widget is still mounted before calling setState
    if (!mounted) return;
    
    setState(() { /* update UI */ });
  } catch (e) {
    if (!mounted) return;
    // Show error
  }
}
```

## Troubleshooting

### "The property X is not defined"
- Check imports at top of file
- Ensure all classes are imported correctly

### "Future builder showing error"
- Check API endpoint is correct
- Verify network connection
- Check JSON response format

### "Navigation not working"
- Ensure MaterialApp is at root
- Use proper Navigator.push/pop
- Pass correct screen widgets

### "TextField not updating"
- Check TextEditingController is disposed properly
- Use `controller` property on TextField
- Call `setState()` after updates

## Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widgets/home_screen_test.dart

# Run with coverage
flutter test --coverage
```

## Building for Release

```bash
# Android
flutter build apk

# iOS
flutter build ios

# Web
flutter build web
```

## Performance Tips

1. Use `const` constructors for widgets
2. Avoid rebuilds with proper widget splitting
3. Use `ListView.builder` for long lists (not `ListView`)
4. Cache API responses locally
5. Lazy load images and data

---

**Need Help?** Check [flutter.dev](https://flutter.dev) or [jsonplaceholder.typicode.com](https://jsonplaceholder.typicode.com) docs.

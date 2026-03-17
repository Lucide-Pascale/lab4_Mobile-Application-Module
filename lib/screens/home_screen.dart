import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_api_service.dart';
import 'post_details_screen.dart';
import 'create_post_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Post>> _postsFuture;
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() {
    setState(() {
      _postsFuture = PostApiService.fetchPosts();
    });
    _postsFuture.then((posts) {
      setState(() {
        _posts = posts;
      });
    });
  }

  void _navigateToDetails(Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetailsScreen(post: post),
      ),
    ).then((_) {
      // Refresh the list when returning from details screen
      _loadPosts();
    });
  }

  void _navigateToCreate() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreatePostScreen(),
      ),
    ).then((_) {
      // Refresh the list when returning from create screen
      _loadPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Manager'),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 50, color: Colors.red),
                  const SizedBox(height: 20),
                  Text(
                    'Error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _loadPosts,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (_posts.isEmpty) {
            return const Center(
              child: Text('No posts available'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _posts.length,
            itemBuilder: (context, index) {
              final post = _posts[index];
              final preview = post.body.length > 100
                  ? '${post.body.substring(0, 100)}...'
                  : post.body;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                elevation: 2,
                child: ListTile(
                  title: Text(
                    post.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    preview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => _navigateToDetails(post),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreate,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }
}

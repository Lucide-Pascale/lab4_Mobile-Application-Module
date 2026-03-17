import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_api_service.dart';
import '../theme/app_colors.dart';
import 'edit_post_screen.dart';

class PostDetailsScreen extends StatefulWidget {
  final Post post;

  const PostDetailsScreen({super.key, required this.post});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  late Post _currentPost;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _currentPost = widget.post;
  }

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

  void _deletePost() {
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
            onPressed: () async {
              Navigator.pop(context);
              _performDelete();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.primaryRed),
            ),
          ),
        ],
      ),
    );
  }

  void _performDelete() async {
    setState(() {
      _isDeleting = true;
    });

    try {
      await PostApiService.deletePost(_currentPost.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post deleted successfully'),
          backgroundColor: AppColors.primaryRed,
        ),
      );
      Navigator.pop(context, true); // Return true to indicate deletion
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: AppColors.primaryRed,
        ),
      );
      setState(() {
        _isDeleting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: _isDeleting
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    _currentPost.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Post ID and User ID
                  Row(
                    children: [
                      Chip(
                        label: Text('ID: ${_currentPost.id}'),
                        backgroundColor: AppColors.surfaceBg,
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text('User: ${_currentPost.userId}'),
                        backgroundColor: AppColors.surfaceBg,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const Divider(color: AppColors.divider),
                  const SizedBox(height: 16),

                  // Body
                  const Text(
                    'Content',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _currentPost.body,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _navigateToEdit,
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _deletePost,
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

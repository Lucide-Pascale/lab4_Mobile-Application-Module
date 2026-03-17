import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post.dart';

class PostApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Fetch all posts
  static Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }

  // Fetch a single post by ID
  static Future<Post> fetchPostById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts/$id'));

      if (response.statusCode == 200) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load post. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching post: $e');
    }
  }

  // Create a new post
  static Future<Post> createPost({
    required String title,
    required String body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title,
          'body': body,
          'userId': 1, // Default user ID
        }),
      );

      if (response.statusCode == 201) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create post. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating post: $e');
    }
  }

  // Update an existing post
  static Future<Post> updatePost({
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/posts/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': id,
          'title': title,
          'body': body,
          'userId': 1,
        }),
      );

      if (response.statusCode == 200) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update post. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating post: $e');
    }
  }

  // Delete a post
  static Future<void> deletePost(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/posts/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete post. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting post: $e');
    }
  }
}

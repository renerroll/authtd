import 'dart:convert';
import 'package:http/http.dart';

class NetworkService {

  final baseUrl = "https://blog-api-t6u0.onrender.com";

  Future<List<dynamic>> fetchPosts() async {
    try {
      final response = await get(Uri.parse("$baseUrl/posts"));
      return jsonDecode(response.body) as List; 
    } catch (e) {
      return [];
    }
  }

  Future<bool> patchPost(Map<String, String> patchObj, int id) async {
    try {

      await patch(Uri.parse("$baseUrl/posts/1"), body: patchObj);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map?> addPost(Map<String, String> postObj) async {
    try {
      final response = await post(Uri.parse("$baseUrl/posts"), body: postObj);
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

  Future<bool> deletePost(int id) async {
    try {
      await delete(Uri.parse("$baseUrl/posts/1"));
      return true;
    } catch (er) {
      return false;
    }
  }
  
    Future<List<dynamic>> fetchComments() async {
    try {
      final response = await get(Uri.parse("$baseUrl/comments"));
      return jsonDecode(response.body) as List; 
    } catch (e) {
      return [];
    }
  }

  Future<Map?> addComment(Map<String, dynamic> commentObj, int id) async {
    try {
      final response = await post(Uri.parse("$baseUrl/comments"), body: commentObj);
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

}
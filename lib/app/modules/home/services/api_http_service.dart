import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHttpService {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<Map<String, dynamic>> fetchPosts() async {
    final stopwatch = Stopwatch()..start();
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts/1'));

      stopwatch.stop();
      print("[HTTP] Response time: ${stopwatch.elapsedMilliseconds} ms");

      if (response.statusCode == 200) {
        return {
          "data": jsonDecode(response.body),
          "time": stopwatch.elapsedMilliseconds,
        };
      } else {
        throw Exception('Failed to load data (status: ${response.statusCode})');
      }
    } catch (e) {
      stopwatch.stop();
      print("[HTTP] Error: $e");
      rethrow;
    }
  }
}

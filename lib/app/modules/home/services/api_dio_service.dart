import 'package:dio/dio.dart';

class ApiDioService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  ApiDioService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('[DIO] Request → ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('[DIO] Response ← ${response.statusCode}');
          return handler.next(response);
        },
        onError: (e, handler) {
          print('[DIO] Error ✖ ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchPosts() async {
    final stopwatch = Stopwatch()..start();
    try {
      final response = await dio.get('/posts/1');
      stopwatch.stop();
      print("[DIO] Response time: ${stopwatch.elapsedMilliseconds} ms");

      return {"data": response.data, "time": stopwatch.elapsedMilliseconds};
    } catch (e) {
      stopwatch.stop();
      print("[DIO] Error: $e");
      rethrow;
    }
  }
}

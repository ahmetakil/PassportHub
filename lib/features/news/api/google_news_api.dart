import 'package:dio/dio.dart';
import 'package:passport_hub/features/news/api/news_api.dart';

class GoogleNewsApi implements NewsApi {
  final Dio _dio = Dio();

  @override
  Future<String?> fetchNewsForKeyword(String keyword) async {
    try {
      final Response<String> response =
          await _dio.get("https://news.google.com/rss/search?q=$keyword");

      if (response.statusCode == 200) {
        final String? responseData = response.data;

        return responseData;
      } else {
        throw Exception(
          'Failed to fetch news for keyword: $keyword. Server responded with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception("Could not fetch news for keyword $keyword: $e");
    }
  }
}

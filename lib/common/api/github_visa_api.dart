import 'package:dio/dio.dart';
import 'package:passport_hub/common/api/visa_api.dart';
import 'package:passport_hub/common/const.dart';

class GithubVisaApi implements VisaApi {
  final Dio _dio = Dio();

  @override
  Future<List<List<String>>?> fetchVisaMatrix() async {
    try {
      final Response<String> response = await _dio.get(passportUrlWithIsoCodes);

      if (response.statusCode == 200) {
        final List<String>? rows = response.data?.split("\n");

        return rows?.map((row) => row.split(',')).toList();
      } else {
        throw Exception(
          'Failed to load visa matrix. Server responded with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception("Could not fetch the visa matrix: $e");
    }
  }
}

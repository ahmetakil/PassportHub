import 'package:passport_hub/common/api/visa_api.dart';

class MockVisaApi implements VisaApi {
  final String mockResponseData;

  MockVisaApi({required this.mockResponseData});

  @override
  Future<List<List<String>>?> fetchVisaMatrix() async {
    final List<String> rows = mockResponseData.split("\n");

    return rows.map((row) => row.split(',')).toList();
  }
}

import 'package:d20_state_management/data/models/province_response.dart';
import 'package:dio/dio.dart';

class ProvinceRepository {
  static const String _baseUrl = 'https://open-api.my.id/api/wilayah';
  final Dio _dio;

  ProvinceRepository({Dio? dio})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

  Future<List<ProvinceResponse>> getProvinces() async {
    try {
      final response = await _dio.get('/provinces');
      if (response.statusCode == 200 && response.data is List) {
        final dataList = response.data.map((item) {
          if (item is Map<String, dynamic>) {
            return ProvinceResponse.fromJson(item);
          }
          return null;
        }).toList();

        final provinceList = dataList.whereType<ProvinceResponse>().toList();

        if (provinceList.isEmpty) {
          throw Exception("Provinces is empty");
        }

        return provinceList;
      }
      throw Exception('Failed to load provinces');
    } catch (e) {
      throw Exception('Error fetching provinces: $e');
    }
  }
}

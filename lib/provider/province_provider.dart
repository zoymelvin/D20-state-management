import 'package:flutter/foundation.dart';
import 'package:d20_state_management/data/models/province_response.dart';
import 'package:d20_state_management/data/repositories/province_repository.dart';

class ProvinceProvider extends ChangeNotifier {
  List<ProvinceResponse> _provinceList = [];
  bool _isLoading = false;

  List<ProvinceResponse> get provinceList => _provinceList;
  bool get isLoading => _isLoading;

  Future<void> getProvinces() async {
    _isLoading = true;
    notifyListeners();

    try {
      final repository = ProvinceRepository();
      _provinceList = await repository.getProvinces();
    } catch (e) {
      _provinceList = [];
      if (kDebugMode) {
        print('Error getting provinces: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

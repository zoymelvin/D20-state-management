import 'package:d20_state_management/data/models/province_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProvinceInheritedWidget extends InheritedWidget {
  final List<ProvinceResponse> provinceList;
  final bool isLoading;

  const ProvinceInheritedWidget({
    super.key,
    required super.child,
    required this.provinceList,
    required this.isLoading,
  });

  static ProvinceInheritedWidget of(BuildContext context) {
    final ProvinceInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<ProvinceInheritedWidget>();
    assert(result != null, 'No ProvinceInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ProvinceInheritedWidget oldWidget) {
    return isLoading != oldWidget.isLoading ||
        !listEquals(provinceList, oldWidget.provinceList);
  }
}

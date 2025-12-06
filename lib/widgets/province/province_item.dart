import 'package:d20_state_management/data/models/province_response.dart';
import 'package:flutter/material.dart';

class ProvinceItem extends StatelessWidget {
  final ProvinceResponse province;
  const ProvinceItem({super.key, required this.province});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(province.name),
      subtitle: Text(province.id),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
        side: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }
}

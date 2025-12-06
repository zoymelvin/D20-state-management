import 'package:d20_state_management/data/models/province_response.dart';
import 'package:flutter/material.dart';
import 'package:d20_state_management/data/repositories/province_repository.dart';

class ProvincePage extends StatefulWidget {
  const ProvincePage({super.key});

  @override
  State<ProvincePage> createState() => _ProvincePageState();
}

class _ProvincePageState extends State<ProvincePage> {
  bool _isLoading = false;
  List<ProvinceResponse> provinceList = [];

  Future<void> _getProvinces() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final repository = ProvinceRepository();
      final data = await repository.getProvinces();

      if (data.isNotEmpty) {
        provinceList
          ..clear()
          ..addAll(data);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load provinces: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Indonesia's Provinces")),
      body: _isLoading
          ? Column(mainAxisAlignment: MainAxisAlignment.center)
          : Placeholder(),
    );
  }
}

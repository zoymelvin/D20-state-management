import 'package:d20_state_management/data/models/province_response.dart';
import 'package:d20_state_management/widgets/province/province_item.dart';
import 'package:d20_state_management/widgets/province/province_loader.dart';
import 'package:flutter/material.dart';
import 'package:d20_state_management/data/repositories/province_repository.dart';

class ProvincePage extends StatefulWidget {
  const ProvincePage({super.key});

  @override
  State<ProvincePage> createState() => _ProvincePageState();
}

class _ProvincePageState extends State<ProvincePage> {
  bool _isLoading = false;
  final List<ProvinceResponse> _provinceList = [];

  Future<void> _getProvinces() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final repository = ProvinceRepository();
      final data = await repository.getProvinces();

      if (data.isNotEmpty) {
        _provinceList
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
  void initState() {
    super.initState();
    _getProvinces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Indonesia's Provinces")),
      body: Center(
        child: _isLoading
            ? ProvinceLoader()
            : _provinceList.isEmpty
            ? Center(child: Text("No provinces found"))
            : ListView.builder(
                itemCount: _provinceList.length,
                itemBuilder: (context, index) =>
                    ProvinceItem(province: _provinceList[index]),
              ),
      ),
    );
  }
}

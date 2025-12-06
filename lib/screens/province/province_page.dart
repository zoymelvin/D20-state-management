import 'package:d20_state_management/data/models/province_response.dart';
import 'package:d20_state_management/widgets/inherited/province_inherited_widget.dart';
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
    return ProvinceInheritedWidget(
      provinceList: List<ProvinceResponse>.unmodifiable(_provinceList),
      isLoading: _isLoading,
      child: const ProvinceView(),
    );
  }
}

class ProvinceView extends StatelessWidget {
  const ProvinceView({super.key});

  @override
  Widget build(BuildContext context) {
    final provinceInheritedWidget = ProvinceInheritedWidget.of(context);
    final isLoading = provinceInheritedWidget.isLoading;
    final provinces = provinceInheritedWidget.provinceList;

    return Scaffold(
      appBar: AppBar(title: Text("Indonesia's Provinces")),
      body: Center(
        child: isLoading
            ? ProvinceLoader()
            : provinces.isEmpty
            ? Center(child: Text("No provinces found"))
            : ListView.builder(
                itemCount: provinces.length,
                itemBuilder: (context, index) =>
                    ProvinceItem(province: provinces[index]),
              ),
      ),
    );
  }
}

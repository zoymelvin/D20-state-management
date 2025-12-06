import 'package:d20_state_management/provider/province_provider.dart';
import 'package:d20_state_management/widgets/province/province_item.dart';
import 'package:d20_state_management/widgets/province/province_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProvincePage extends StatefulWidget {
  const ProvincePage({super.key});

  @override
  State<ProvincePage> createState() => _ProvincePageState();
}

class _ProvincePageState extends State<ProvincePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProvinceProvider>().getProvinces();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Indonesia's Provinces")),
      body: Consumer<ProvinceProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return ProvinceLoader();
          }

          if (provider.provinceList.isEmpty) {
            return Center(child: Text("No provinces found"));
          }

          return ListView.builder(
            itemCount: provider.provinceList.length,
            itemBuilder: (context, index) =>
                ProvinceItem(province: provider.provinceList[index]),
          );
        },
      ),
    );
  }
}

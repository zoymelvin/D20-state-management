import 'package:flutter/material.dart';

class ProvinceLoader extends StatelessWidget {
  const ProvinceLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        const CircularProgressIndicator(),
        Text(
          'Loading Provinces...',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

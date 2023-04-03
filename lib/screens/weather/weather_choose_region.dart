import 'package:flutter/material.dart';

import '../../models/region.dart';

class WeatherChooseRegion extends StatelessWidget {
  const WeatherChooseRegion({
    super.key,
    required this.regions,
    this.selectedRegion,
  });

  final List<RegionFromBMKG> regions;
  final RegionFromBMKG? selectedRegion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pilih Daerah",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        surfaceTintColor: Colors.blue.shade600,
        backgroundColor: Colors.blue.shade600,
      ),
      body: ListView.separated(
        itemCount: regions.length,
        shrinkWrap: true,
        itemBuilder: (_, i) {
          RegionFromBMKG item = regions[i];

          return GestureDetector(
            key: ValueKey(item.id),
            onTap: () => Navigator.pop(context, item),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              color: selectedRegion == item
                  ? Colors.blue.shade200
                  : Colors.blue.withOpacity(0.09),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Provinsi ${item.propinsi}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: selectedRegion != item
                              ? Colors.black
                              : Colors.white,
                          fontSize: 24.0,
                        ),
                  ),
                  Flexible(
                    child: selectedRegion == item
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, index) => Divider(
          height: 0,
          color: Colors.blue.shade900,
        ),
      ),
    );
  }
}

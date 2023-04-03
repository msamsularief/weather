import 'package:flutter/material.dart';

import '../../models/regency.dart';

class WeatherChooseRegency extends StatefulWidget {
  const WeatherChooseRegency({
    super.key,
    required this.regencies,
    this.selectedRegency,
  });

  final List<Regency> regencies;
  final Regency? selectedRegency;

  @override
  State<WeatherChooseRegency> createState() => _WeatherChooseRegencyState();
}

class _WeatherChooseRegencyState extends State<WeatherChooseRegency> {
  late List<Regency> regencies;
  List<Regency> newRegencies = [];
  Regency? selectedRegency;

  String? selectedStr;
  List<String> regencynames = [];

  bool isVisible = false;
  List<bool> isVisibles = [];

  String lastStr = "";

  @override
  void initState() {
    super.initState();

    regencies = widget.regencies;
    selectedRegency = widget.selectedRegency;

    regencynames = Set.of(regencies.map((e) => e.name).toList()).toList();
    isVisibles = regencynames.map((e) => false).toList();
  }

  void itemOnTap(int index, String str) {
    setState(() {
      isVisibles = isVisibles.map((e) => false).toList();

      if (newRegencies.isNotEmpty && lastStr != str) {
        newRegencies.clear();
        lastStr = str;
        newRegencies = regencies
            .where(
              (regency) => regency.name == str,
            )
            .toList();
        isVisibles[index] = true;
      } else if (newRegencies.isNotEmpty && lastStr == str) {
        newRegencies.clear();
        isVisibles[index] = false;
      } else if (newRegencies.isEmpty) {
        lastStr = str;
        newRegencies = regencies
            .where(
              (regency) => regency.name == str,
            )
            .toList();
        isVisibles[index] = true;
      }
    });
  }

  void itemOnSelected(Regency regency) => setState(() {
        selectedRegency = regency;
        Navigator.pop(context, selectedRegency);
      });

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
        itemCount: regencynames.length,
        shrinkWrap: true,
        itemBuilder: (_, i) {
          String item = regencynames[i];

          return Column(
            key: ValueKey("___key_${item}___"),
            children: [
              GestureDetector(
                onTap: () => itemOnTap(i, item),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  color: selectedRegency?.name == item
                      ? Colors.blue.shade200
                      : Colors.blue.withOpacity(0.09),
                  width: AppBar().preferredSize.width,
                  height: AppBar().preferredSize.height,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: selectedRegency?.name != item
                              ? Colors.black
                              : Colors.white,
                          fontSize: 24.0,
                        ),
                  ),
                ),
              ),
              Visibility(
                key: ValueKey("___key_visible_${item}___"),
                visible: isVisibles[i],
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                    right: 24.0,
                    top: 10.0,
                    bottom: 16.0,
                  ),
                  color: selectedRegency?.name == item
                      ? Colors.blue.shade300
                      : Colors.blue.withOpacity(0.09),
                  child: ListView.separated(
                    itemCount: newRegencies.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    addAutomaticKeepAlives: false,
                    itemBuilder: (_, index) {
                      Regency regency = newRegencies[index];

                      return GestureDetector(
                        onTap: () => itemOnSelected(regency),
                        child: Container(
                          width: AppBar().preferredSize.width,
                          height: AppBar().preferredSize.height * .7,
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "- ${regency.kecamatan}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: selectedRegency?.kecamatan !=
                                              regency.kecamatan
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 24.0,
                                    ),
                              ),
                              Flexible(
                                child: selectedRegency?.kecamatan ==
                                        regency.kecamatan
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
                ),
              ),
            ],
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

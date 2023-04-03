import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/weather/weather_choose_region.dart';
import '../../widgets/shimmer_weather_view.dart';
import '../../blocs/weather/weather.dart';
import '../../models/regency.dart';
import '../../models/region.dart';
import 'weather_choose_regency.dart';

class WeatherChooseItemPage extends StatefulWidget {
  const WeatherChooseItemPage({
    super.key,
    required this.regions,
    this.selectedRegion,
    this.regencies,
    this.selectedRegency,
  });

  final List<RegionFromBMKG> regions;
  final RegionFromBMKG? selectedRegion;
  final List<Regency>? regencies;
  final Regency? selectedRegency;

  @override
  State<WeatherChooseItemPage> createState() => _WeatherChooseItemPageState();
}

class _WeatherChooseItemPageState extends State<WeatherChooseItemPage> {
  late WeatherBloc _weatherBloc;

  late List<RegionFromBMKG> regions;
  RegionFromBMKG? selectedRegion;
  List<Regency>? regencies;
  Regency? selectedRegency;
  List<Regency>? subDistricts;
  Regency? selectedSubdistrict;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _weatherBloc = context.read<WeatherBloc>();

    regions = widget.regions;
    selectedRegion = widget.selectedRegion;
    regencies = widget.regencies;
    selectedRegency = widget.selectedRegency;
  }

  void listener(WeatherState state) {
    if (state is BMKGRegencyLoaded) {
      setState(() {
        isLoading = false;
        regencies = state.regencies;
        selectedRegency = regencies?.first;
        subDistricts = regencies;
        selectedSubdistrict = subDistricts?.first;
      });
    } else if (state is BMKGTemperatureLoaded) {
      setState(() => isLoading = false);
    } else {
      setState(() => isLoading = true);
    }
  }

  void selectRegion() async {
    RegionFromBMKG? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WeatherChooseRegion(
          regions: regions,
          selectedRegion: selectedRegion,
        ),
      ),
    );

    if (result != null && result != selectedRegion) {
      setState(() {
        selectedRegion = result;
        _weatherBloc.add(GetRegencyFromBMKG(selectedRegion!.code));
      });
    } else {
      return;
    }
  }

  void selectRegency() async {
    Regency? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WeatherChooseRegency(
          regencies: regencies ?? [],
          selectedRegency: selectedRegency,
        ),
      ),
    );

    if (result != null && result != selectedRegency) {
      setState(() => selectedRegency = result);
    } else {
      return;
    }
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0).copyWith(top: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Provinsi'),
            GestureDetector(
              onTap: selectRegion,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ).copyWith(top: .0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.blue.shade600,
                    width: 2.0,
                  ),
                ),
                child: Text(
                  "Provinsi ${selectedRegion?.propinsi}",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const Text('Kota/Kabupaten'),
            BlocListener<WeatherBloc, WeatherState>(
              bloc: _weatherBloc,
              listener: (_, state) => listener(state),
              child: ShimmerWeatherView(
                isLoading: isLoading,
                childWhenLoading: _loadingWidget(context),
                child: GestureDetector(
                  onTap: selectRegency,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ).copyWith(top: .0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.blue.shade600,
                        width: 2.0,
                      ),
                    ),
                    child: Text(
                      "${selectedRegency?.name}",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            SizedBox.fromSize(
              size: AppBar().preferredSize * .8,
              child: TextButton(
                onPressed: () => Navigator.pop<List?>(
                  context,
                  [selectedRegion, selectedRegency],
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.blue.shade600),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                  ),
                ),
                child: Text(
                  'Konfirmasi',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _loadingWidget(
  BuildContext context, {
  double marginBottom = 0,
  double marginTop = 0,
}) =>
    Container(
      height: AppBar().preferredSize.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white12,
      ),
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
    );

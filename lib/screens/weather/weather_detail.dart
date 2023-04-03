import 'package:weather/models/regency.dart';
import 'package:weather/models/temperature.dart';

import '../../utils/app_images.dart';

import '../../utils/extensions.dart';

import '../../commons/weather_common.dart';
import '../../widgets/shimmer_weather_view.dart';
import '../../blocs/weather/weather.dart';
import '../../models/region.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'weather_choose_item_page.dart';

class WeatherDetail extends StatefulWidget {
  const WeatherDetail({super.key, this.lastChoosenRegion, this.regions});

  final List<RegionFromBMKG>? regions;
  final RegionFromBMKG? lastChoosenRegion;

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  late WeatherBloc _weatherBloc;

  List<RegionFromBMKG>? items;
  RegionFromBMKG? _selectedItem;

  List<Regency>? regencies;
  Regency? _selectedRegency;

  List<Temperature>? weathers;
  Temperature? _selectedWeather;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.lastChoosenRegion;
    items = widget.regions;

    _weatherBloc = context.read<WeatherBloc>();
  }

  void _onItemTapped() async {
    if (items == null) {
      return;
    }

    final data = await Navigator.of(context).push<List?>(
      MaterialPageRoute(
        builder: (_) => WeatherChooseItemPage(
          regions: items ?? [],
          selectedRegion: _selectedItem,
          regencies: regencies ?? [],
          selectedRegency: _selectedRegency,
        ),
      ),
    );

    if (data != null) {
      setState(() {
        _selectedItem = data.first as RegionFromBMKG?;
        _selectedRegency = data.last as Regency?;
        _weatherBloc.add(
          GetTemperatureFromBMKG(_selectedRegency!, _selectedRegency!.id),
        );
      });
    } else {
      return;
    }
  }

  void onListener(WeatherState state) {
    if (state is BMKGRegionLoaded) {
      setState(() {
        items = state.regions;
        _selectedItem = _selectedItem ?? items?.first;
        _weatherBloc.add(GetRegencyFromBMKG(_selectedItem!.code));
      });
    } else if (state is BMKGRegencyLoaded) {
      setState(() {
        regencies = state.regencies;
        _selectedRegency = _selectedRegency ?? regencies?.first;
        _weatherBloc.add(
            GetTemperatureFromBMKG(_selectedRegency!, _selectedRegency!.id));
      });
    } else if (state is BMKGTemperatureLoaded) {
      setState(() {
        weathers = state.temperatures;
        _selectedWeather = WeatherCommon.selectWeather(weathers!);
      });
    } else if (state is RegionInfoFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          duration: const Duration(
            milliseconds: 2600,
          ),
          showCloseIcon: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    _weatherBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now(); // Tanggal dan waktu saat ini

    return BlocConsumer<WeatherBloc, WeatherState>(
      bloc: _weatherBloc,
      listener: (context, state) => onListener(state),
      builder: (_, state) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ShimmerWeatherView(
              isLoading: state is RegionInfoLoading,
              childWhenLoading: Container(
                height: AppBar().preferredSize.height * .8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white12,
                ),
                margin: const EdgeInsets.only(bottom: 8.0),
              ),
              child: GestureDetector(
                onTap: _onItemTapped,
                child: Container(
                  height: AppBar().preferredSize.height * 0.8,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.white12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 4,
                        child: Text(
                          _selectedItem != null
                              ? "${_selectedItem?.propinsi} "
                              : "",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: _selectedItem != null
                            ? const Icon(
                                Icons.location_on,
                                color: Colors.white,
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ShimmerWeatherView(
              isLoading: state is! BMKGTemperatureLoaded,
              childWhenLoading: _textWidget(context, marginBottom: 16.0),
              child: Text(
                _selectedRegency != null ? '${_selectedRegency?.name}' : "",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                textScaleFactor: 0.8,
              ),
            ),
            ShimmerWeatherView(
              isLoading: state is! BMKGTemperatureLoaded,
              childWhenLoading: _textWidget(
                context,
                height: 80,
                marginTop: state is RegionInfoLoading ? 0.0 : 16.0,
                marginBottom: 16.0,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                      16.0,
                    ).copyWith(top: 0.0, bottom: 0.0),
                    child: Text(
                      "${_selectedWeather?.celcius}",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 56.0,
                          ),
                      textScaleFactor: 1.8,
                    ),
                  ),
                  Positioned(
                    top: 4.0,
                    right: -2.0,
                    child: Text(
                      '°',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 40.0,
                          ),
                      textScaleFactor: 1.8,
                    ),
                  ),
                ],
              ),
            ),
            ShimmerWeatherView(
              isLoading: state is! BMKGTemperatureLoaded,
              childWhenLoading: _textWidget(context, marginBottom: 16.0),
              child: Text(
                now.millisecondsSinceEpoch.toString().toDDMMMyyyy(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                textScaleFactor: 0.8,
              ),
            ),
            ShimmerWeatherView(
              isLoading: state is! BMKGTemperatureLoaded,
              childWhenLoading: _textWidget(context, marginBottom: 8.0),
              child: Text(
                'Cerah Berawan',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                textScaleFactor: 0.8,
              ),
            ),
            ShimmerWeatherView(
              isLoading: state is! BMKGTemperatureLoaded,
              childWhenLoading: _textWidget(
                context,
                height: 116.0,
                width: 116.0,
              ),
              child: _selectedWeather != null
                  ? SizedBox.square(
                      dimension: 116.0,
                      child: Image.asset(
                        AppImages.getByID(
                          _selectedWeather!.code,
                        ),
                        fit: BoxFit.scaleDown,
                      ),
                    )
                  : SizedBox.square(
                      dimension: 116.0,
                      child: Image.asset(
                        AppImages.defaultImg,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _textWidget(
  BuildContext context, {
  double? height,
  double? width,
  double marginBottom = 0,
  double marginTop = 0,
}) =>
    Container(
      height: height ?? AppBar().preferredSize.height * .3,
      width: width ?? MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white12,
      ),
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
    );

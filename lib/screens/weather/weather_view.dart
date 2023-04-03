import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/utils/app_images.dart';
import 'package:weather/utils/extensions.dart';
import 'package:weather/widgets/shimmer_weather_view.dart';

import '../../blocs/weather/weather.dart';
import '../../commons/weather_common.dart';
import '../../models/temperature.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView>
    with SingleTickerProviderStateMixin {
  List<Temperature>? weathers;
  List<Temperature>? weathersNow;
  List<Temperature>? weathersNextDay;
  Temperature? _selectedWeather;

  bool isLoading = true;

  DateTime now = DateTime.now();

  final List<Tab> tabs = [
    const Tab(
      text: 'Hari ini',
    ),
    const Tab(
      text: 'Besok',
    ),
  ];

  late WeatherBloc _weatherBloc;
  late TabController controller;

  @override
  void initState() {
    super.initState();
    _weatherBloc = context.read<WeatherBloc>();

    controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    _weatherBloc.close();
    super.dispose();
  }

  void onListener(WeatherState state) {
    if (state is BMKGTemperatureLoaded) {
      setState(() {
        weathers = state.temperatures;

        weathersNow = weathers!
            .where(
              (item) => item.dateTime.day == now.day,
            )
            .toList();

        weathersNextDay = weathers!
            .where(
              (item) => item.dateTime.day == (now.day + 1),
            )
            .toList();

        _selectedWeather = WeatherCommon.selectWeather(
          weathers!,
          DateTime.now().add(
            const Duration(days: 1),
          ),
        );

        isLoading = false;
      });
    } else {
      isLoading = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: Container(
              color: Colors.white,
              child: TabBar(
                controller: controller,
                tabs: tabs,
              ),
            ),
          ),
          body: BlocConsumer<WeatherBloc, WeatherState>(
            bloc: _weatherBloc,
            listener: (context, state) => onListener(state),
            builder: (_, state) => TabBarView(
              controller: controller,
              children: [
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 9 / 15,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10.0),
                  itemCount: 4,
                  itemBuilder: (_, i) => ShimmerWeatherView(
                    isLoading: isLoading,
                    childWhenLoading: _gridItemShimmer(context),
                    child: Container(
                      padding: const EdgeInsets.all(2.0).copyWith(top: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: weathersNow?[i].dateTime.hour ==
                                _selectedWeather?.dateTime.hour
                            ? Colors.blue.shade100
                            : Colors.blue.withOpacity(0.08),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${weathersNow?[i].dateTime.millisecondsSinceEpoch.toString().toHM()}",
                          ),
                          SizedBox.square(
                            dimension: 60.0,
                            child: Image.asset(
                              weathersNow?[i] != null
                                  ? AppImages.getByID(weathersNow![i].code)
                                  : AppImages.defaultImg,
                              fit: BoxFit.scaleDown,
                              scale: 2.4,
                            ),
                          ),
                          SizedBox.square(
                            dimension: 40.0,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(
                                    2.0,
                                  ).copyWith(top: 0.0, bottom: 0.0),
                                  child: Text(
                                    "${weathersNow?[i].celcius}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          // color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                    textScaleFactor: 1.8,
                                  ),
                                ),
                                Positioned(
                                  top: 3.0,
                                  right: 2.0,
                                  child: Text(
                                    '°',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          // color: Colors.white,
                                          fontSize: 10.0,
                                        ),
                                    textScaleFactor: 1.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 9 / 15,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10.0),
                  itemCount: 4,
                  itemBuilder: (_, i) => ShimmerWeatherView(
                    isLoading: isLoading,
                    childWhenLoading: _gridItemShimmer(context),
                    child: Container(
                      padding: const EdgeInsets.all(2.0).copyWith(top: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.blue.withOpacity(0.08),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${weathersNextDay?[i].dateTime.millisecondsSinceEpoch.toString().toHM()}",
                          ),
                          SizedBox.square(
                            dimension: 60.0,
                            child: Image.asset(
                              weathersNextDay?[i] != null
                                  ? AppImages.getByID(weathersNextDay![i].code)
                                  : AppImages.defaultImg,
                              fit: BoxFit.scaleDown,
                              scale: 2.4,
                            ),
                          ),
                          SizedBox.square(
                            dimension: 40.0,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(
                                    2.0,
                                  ).copyWith(top: 0.0, bottom: 0.0),
                                  child: Text(
                                    "${weathersNextDay?[i].celcius}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          // color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                    textScaleFactor: 1.8,
                                  ),
                                ),
                                Positioned(
                                  top: 3.0,
                                  right: 2.0,
                                  child: Text(
                                    '°',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          // color: Colors.white,
                                          fontSize: 10.0,
                                        ),
                                    textScaleFactor: 1.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _gridItemShimmer(
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

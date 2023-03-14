import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/blocs/weather/weather.dart';
import 'package:weather/widgets/shimmer_weather_view.dart';

import '../../models/data.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    Data? data;
    return Scaffold(
      appBar: AppBar(
        title: const Text('GET BMGK data Test'),
      ),
      body: StatefulBuilder(
        builder: (context, sT) {
          return BlocConsumer<WeatherBloc, WeatherState>(
            listener: (_, state) {
              if (state is BMKGFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    duration: const Duration(milliseconds: 3600),
                  ),
                );
              } else if (state is BMKGLoaded) {
                debugPrint("${state.item}");
                sT(() => data = state.item);
              }
            },
            builder: (_, state) => ShimmerWeatherView(
              isLoading: state is! BMKGLoaded,
              childWhenLoading: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.grey,
              ),
              child: SingleChildScrollView(
                child: Text("${data?.forecast}"),
              ),
            ),
          );
        },
      ),
    );
  }
}

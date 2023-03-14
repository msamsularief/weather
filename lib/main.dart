import 'package:intl/date_symbol_data_local.dart';
import 'package:weather/blocs/weather/weather.dart';
import 'package:weather/screens/weather/weather_page.dart';

// import '../screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './blocs/bloc_observer.dart';
import 'utils/app_getter_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await initializeDateFormatting("id_ID");

  Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
      color: Colors.white,
    );

    return MaterialApp(
      title: 'Weather',
      theme: ThemeData.localize(
        ThemeData.light(
          useMaterial3: true,
        ).copyWith(
            tabBarTheme: TabBarTheme(
          indicatorColor: Colors.blue,
          labelStyle: style.copyWith(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.blue.shade300,
          overlayColor: const MaterialStatePropertyAll<Color>(Colors.white),
        )),
        TextTheme(
          bodySmall: style,
          bodyMedium: style,
          bodyLarge: style,
        ),
      ),
      home: BlocProvider<WeatherBloc>(
        create: (context) => WeatherBloc()
          ..add(
            GetRegionFromBMKG(
              AppGetterName.region,
            ),
          ),
        child: const WeatherPage(),
      ),
    );
  }
}

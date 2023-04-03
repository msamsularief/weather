import 'package:intl/date_symbol_data_local.dart';

import 'blocs/app/app_event.dart';
import 'blocs/app/app_state.dart';
import 'blocs/weather/weather.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'blocs/bloc_observer.dart';
import 'blocs/app/app_bloc.dart';
import 'screens/home.dart';
import 'screens/loading/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await initializeDateFormatting("id_ID");

  Bloc.observer = SimpleBlocObserver();

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => AppBloc()..add(StartUpEvent()),
      ),
      BlocProvider(
        create: (context) => WeatherBloc(),
      ),
    ], child: const MyApp()),
  );
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
          colorScheme: ColorScheme.light(background: Colors.blue.shade50),
          tabBarTheme: TabBarTheme(
            indicatorColor: Colors.blue,
            labelStyle: style.copyWith(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.blue.shade300,
            overlayColor: const MaterialStatePropertyAll<Color>(Colors.white),
          ),
        ),
        TextTheme(
          bodySmall: style,
          bodyMedium: style,
          bodyLarge: style,
        ),
      ),
      home: BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            if (state is StartUpSuccess) {
              context.read<WeatherBloc>().add(
                    GetRegencyFromBMKG(state.choosenRegion.code),
                  );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(
                    lastChoosenRegion: state.choosenRegion,
                    regions: state.regions,
                  ),
                ),
              );
            } else if (state is StartUpFailure) {
              context.read<WeatherBloc>().add(GetRegionFromBMKG());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            }
          },
          child: const LoadingScreen()),
    );
  }
}

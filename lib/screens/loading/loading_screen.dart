import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

import 'loading_detail.dart';
import 'loading_view.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.blue.shade900,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            child: WaveWidget(
              config: CustomConfig(
                colors: [Colors.white24],
                durations: [24000],
                heightPercentages: [0.49],
              ),
              size: size,
              backgroundColor: Colors.blue.shade900,
              waveAmplitude: 40,
              isLoop: true,
              waveFrequency: 2.4,
            ),
          ),
          SizedBox(
            child: WaveWidget(
              config: CustomConfig(
                colors: [Colors.white54],
                durations: [16000],
                heightPercentages: [0.52],
              ),
              size: size,
              backgroundColor: Colors.transparent,
              waveAmplitude: 30,
              isLoop: true,
              waveFrequency: 1.8,
            ),
          ),
          SizedBox(
            child: WaveWidget(
              config: CustomConfig(
                colors: [Colors.white],
                durations: [32000],
                heightPercentages: [0.52],
              ),
              size: size,
              backgroundColor: Colors.transparent,
              waveAmplitude: 20,
              isLoop: true,
              waveFrequency: 1.0,
            ),
          ),
          SafeArea(
            child: Column(
              children: const [
                Flexible(
                  flex: 8,
                  child: LoadingDetail(),
                ),
                Flexible(
                  flex: 4,
                  child: LoadingView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

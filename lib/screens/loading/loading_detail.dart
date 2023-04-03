import '../../utils/app_images.dart';

import '../../widgets/shimmer_weather_view.dart';
import 'package:flutter/material.dart';

class LoadingDetail extends StatelessWidget {
  const LoadingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ShimmerWeatherView(
            isLoading: true,
            childWhenLoading: Container(
              height: AppBar().preferredSize.height * .8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white12,
              ),
              margin: const EdgeInsets.only(bottom: 8.0),
            ),
            child: GestureDetector(
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
                        "",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    const Flexible(
                      flex: 1,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ShimmerWeatherView(
            isLoading: true,
            childWhenLoading: _textWidget(context, marginBottom: 16.0),
            child: Text(
              '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
              textScaleFactor: .8,
            ),
          ),
          ShimmerWeatherView(
            isLoading: true,
            childWhenLoading: _textWidget(
              context,
              height: 80,
              marginTop: .0,
              marginBottom: 16.0,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    16.0,
                  ).copyWith(top: 0.0, bottom: 0.0),
                  child: Text(
                    "",
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
                    '',
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
            isLoading: true,
            childWhenLoading: _textWidget(context, marginBottom: 16.0),
            child: Text('',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
              textScaleFactor: 0.8,
            ),
          ),
          ShimmerWeatherView(
            isLoading: true,
            childWhenLoading: _textWidget(context, marginBottom: 8.0),
            child: Text(
              '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
              textScaleFactor: 0.8,
            ),
          ),
          ShimmerWeatherView(
            isLoading: true,
            childWhenLoading: _textWidget(
              context,
              height: 116.0,
              width: 116.0,
            ),
            child: SizedBox.square(
              dimension: 116.0,
              child: Image.asset(
                AppImages.defaultImg,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ],
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

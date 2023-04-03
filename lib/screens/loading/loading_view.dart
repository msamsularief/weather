import 'package:flutter/material.dart';
import 'package:weather/widgets/shimmer_weather_view.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;

  final List<Tab> tabs = [
    const Tab(
      text: 'Hari ini',
    ),
    const Tab(
      text: 'Besok',
    ),
  ];

  late TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                onTap: (_) {},
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
          ),
          body: TabBarView(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
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
                  child: const SizedBox(),
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
                  child: const SizedBox(),
                ),
              ),
            ],
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

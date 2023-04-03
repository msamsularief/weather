import 'package:equatable/equatable.dart';
import 'package:weather/models/region.dart';

class AppState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitApp extends AppState {
  @override
  String toString() => "InitApp";
}

class StartUpLoading extends AppState {
  @override
  String toString() => "StartUpLoading";
}

class StartUpSuccess extends AppState {
  final RegionFromBMKG choosenRegion;
  final List<RegionFromBMKG> regions;

  StartUpSuccess({
    required this.choosenRegion,
    required this.regions,
  });

  @override
  String toString() => "StartUpSuccess";
}

class StartUpFailure extends AppState {
  final String message;

  StartUpFailure(this.message);
  @override
  String toString() => "StartUpFailure : $message";
}

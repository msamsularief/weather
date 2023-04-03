import 'package:equatable/equatable.dart';

class AppEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartUpEvent extends AppEvent {
  StartUpEvent();
  @override
  String toString() => "StartUpEvent";
}

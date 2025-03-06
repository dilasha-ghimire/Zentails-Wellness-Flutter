part of 'sensor_bloc.dart';

sealed class SensorEvent extends Equatable {
  const SensorEvent();

  @override
  List<Object> get props => [];
}

/// Event to start the accelerometer stream
class StartAccelerometerStream extends SensorEvent {}

/// Event to stop the accelerometer stream
class StopAccelerometerStream extends SensorEvent {}

/// Event to update the scroll position when the accelerometer tilt is detected
class UpdateScrollPosition extends SensorEvent {
  final AccelerometerEvent accelerometerEvent;

  const UpdateScrollPosition(this.accelerometerEvent);

  @override
  List<Object> get props => [accelerometerEvent];
}

class SetTiltThreshold extends SensorEvent {
  final double threshold;

  const SetTiltThreshold(this.threshold);

  @override
  List<Object> get props => [threshold];
}

class StartProximityStream extends SensorEvent {}

class StopProximityStream extends SensorEvent {}

class ProximityChanged extends SensorEvent {
  final int value; // Change to int (from ProximityEvent)
  const ProximityChanged(this.value);
  @override
  List<Object> get props => [value];
}

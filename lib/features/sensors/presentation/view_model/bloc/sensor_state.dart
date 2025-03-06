part of 'sensor_bloc.dart';

/// Base class for all states related to the Sensor
sealed class SensorState extends Equatable {
  const SensorState();

  @override
  List<Object> get props => [];
}

/// Initial state when no accelerometer data is being processed
final class SensorInitial extends SensorState {}

/// Loading state while accelerometer data is being fetched
final class SensorLoading extends SensorState {}

/// State when the scroll position is updated based on the accelerometer data
final class ScrollPositionUpdated extends SensorState {
  final AccelerometerEvent accelerometerEvent;

  const ScrollPositionUpdated(this.accelerometerEvent);

  @override
  List<Object> get props => [accelerometerEvent];
}

final class ProximityStateChanged extends SensorState {
  final bool proximityDetected; // Proximity detection state
  const ProximityStateChanged({required this.proximityDetected});
  @override
  List<Object> get props => [proximityDetected];
}

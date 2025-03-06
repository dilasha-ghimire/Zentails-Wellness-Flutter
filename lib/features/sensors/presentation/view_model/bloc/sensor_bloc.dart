import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:zentails_wellness/features/sensors/domain/usecases/get_proximity_data_usecase.dart';
import './../../../domain/usecases/get_accelerometer_data_usecase.dart';

part 'sensor_event.dart';
part 'sensor_state.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  final GetAccelerometerDataUseCase getAccelerometerDataUseCase;
  final GetProximityDataUseCase getProximityDataUseCase;
  StreamSubscription<AccelerometerEvent>? _accelerometerStreamSubscription;
  StreamSubscription<int>? _proximityStreamSubscription;
  double _tiltThreshold = 1.53;
  bool _proximityDetected = false;

  SensorBloc(this.getAccelerometerDataUseCase, this.getProximityDataUseCase)
      : super(SensorInitial()) {
    on<StartAccelerometerStream>(_onStartAccelerometerStream);
    on<StopAccelerometerStream>(_onStopAccelerometerStream);
    on<UpdateScrollPosition>(_onUpdateScrollPosition);
    on<SetTiltThreshold>(_onSetTiltThreshold);
    on<StartProximityStream>(_onStartProximityStream);
    on<StopProximityStream>(_onStopProximityStream);
    on<ProximityChanged>(_onProximityChanged);
  }

  void _onStartAccelerometerStream(
      StartAccelerometerStream event, Emitter<SensorState> emit) {
    emit(SensorLoading());

    _accelerometerStreamSubscription = getAccelerometerDataUseCase().listen(
      (AccelerometerEvent accelerometerEvent) {
        if (accelerometerEvent.y < _tiltThreshold) {
          add(UpdateScrollPosition(accelerometerEvent));
        }
      },
    );
  }

  void _onStopAccelerometerStream(
      StopAccelerometerStream event, Emitter<SensorState> emit) async {
    await _accelerometerStreamSubscription?.cancel();
    _accelerometerStreamSubscription = null;
    emit(SensorInitial());
  }

  void _onUpdateScrollPosition(
      UpdateScrollPosition event, Emitter<SensorState> emit) {
    emit(ScrollPositionUpdated(event.accelerometerEvent));
  }

  void _onSetTiltThreshold(SetTiltThreshold event, Emitter<SensorState> emit) {
    _tiltThreshold = event.threshold;
  }

  void _onStartProximityStream(
      StartProximityStream event, Emitter<SensorState> emit) {
    _proximityStreamSubscription = getProximityDataUseCase().listen(
      (int proximityValue) {
        add(ProximityChanged(proximityValue)); // Passing the int value
      },
    );
  }

  void _onStopProximityStream(
      StopProximityStream event, Emitter<SensorState> emit) async {
    await _proximityStreamSubscription?.cancel();
    _proximityStreamSubscription = null;
  }

  void _onProximityChanged(ProximityChanged event, Emitter<SensorState> emit) {
    _proximityDetected =
        event.value > 0; // If value is greater than 0, proximity is detected
    emit(ProximityStateChanged(proximityDetected: _proximityDetected));
  }

  @override
  Future<void> close() {
    _accelerometerStreamSubscription?.cancel();
    _proximityStreamSubscription?.cancel();
    return super.close();
  }
}

import 'package:sensors_plus/sensors_plus.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

abstract class SensorRepository {
  Stream<AccelerometerEvent> getAccelerometerStream();
  Stream<int> getProximityStream();
}

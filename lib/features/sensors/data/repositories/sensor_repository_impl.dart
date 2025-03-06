import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'sensor_repository.dart';

class SensorRepositoryImpl implements SensorRepository {
  @override
  Stream<AccelerometerEvent> getAccelerometerStream() {
    return SensorsPlatform.instance.accelerometerEventStream();
  }

  @override
  Stream<int> getProximityStream() {
    return ProximitySensor.events;
  }
}

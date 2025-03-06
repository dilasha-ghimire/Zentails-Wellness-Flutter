import 'package:sensors_plus/sensors_plus.dart';
import '../../data/repositories/sensor_repository.dart';

class GetAccelerometerDataUseCase {
  final SensorRepository sensorRepository;

  GetAccelerometerDataUseCase(this.sensorRepository);

  Stream<AccelerometerEvent> call() {
    return sensorRepository.getAccelerometerStream();
  }
}

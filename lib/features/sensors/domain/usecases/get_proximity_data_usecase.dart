import 'package:proximity_sensor/proximity_sensor.dart';
import '../../data/repositories/sensor_repository.dart';

class GetProximityDataUseCase {
  final SensorRepository sensorRepository;

  GetProximityDataUseCase(this.sensorRepository);

  Stream<int> call() {
    return sensorRepository.getProximityStream();
  }
}

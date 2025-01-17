import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zentails_wellness/app/constants/hive_table_constant.dart';
import 'package:zentails_wellness/features/auth/data/model/auth_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}zentails_wellness.db';

    Hive.init(path);

    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.authId, auth);
  }

  Future<AuthHiveModel?> login(String identifier, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere((element) =>
        (element.email == identifier || element.contactNumber == identifier) &&
        element.password == password);
    box.close();
    return user;
  }

  Future<void> close() async {
    await Hive.close();
  }
}

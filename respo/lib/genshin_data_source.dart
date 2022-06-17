import 'package:respo/base_network.dart';

class GenshinDataSource {
  static GenshinDataSource instance = GenshinDataSource();

  Future<List<dynamic>> loadCharacterList() {
    return BaseNetwork.getList("characters");
  }
  Future<List<dynamic>> loadWeaponList() {
    return BaseNetwork.getList("weapons");
  }

  Future<Map<String, dynamic>> loadDetailCharacter(String name) {
    return BaseNetwork.getDetail("characters/${name}");
  }
  Future<Map<String, dynamic>> loadDetailWeapon(String name) {
    return BaseNetwork.getDetail("characters/${name}");
  }
}

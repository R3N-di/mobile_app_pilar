import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mobile_app_pilar/models/mainhole.model.dart';

class MainholeService {
  static const String _baseUrl = 'https://app.pilarsolusi.co.id/administrasi/api/dataMainhole.php?';

  Future<List<MainholeModel>> getMainhole() async {
    Uri urlApi = Uri.parse(_baseUrl);

    final res = await http.get(urlApi);

    if (res.statusCode == 200){
      return mainholeModelFromJson(res.body.toString());
    } else {
      print('Failed to load Data!');
      throw Exception("Failed to load Data!");
    }
  }
}
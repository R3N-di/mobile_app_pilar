import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mobile_app_pilar/models/spesifikasi_vms_model.dart';

class VmsService {
  static const String _baseUrl =
      'https://app.pilarsolusi.co.id/administrasi/api/dataVMS.php?';

  Future<List<VmsModel>> getVms() async {
    Uri urlApi = Uri.parse(_baseUrl);

    final res = await http.get(urlApi);

    if (res.statusCode == 200) {
      return vmsModelFromJson(res.body.toString());
    } else {
      print('Failed to load Data!');
      throw Exception("Failed to load Data!");
    }
  }
}

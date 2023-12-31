import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mobile_app_pilar/models/lokasi_vms_model.dart';

class LokasiVmsService {
  static const String _baseUrl =
      'https://app.pilarsolusi.co.id/administrasi/api/dataLokasiVMS.php?';

  Future<List<LokasiVmsModel>> getLokasiVms() async {
    Uri urlApi = Uri.parse(_baseUrl);

    final res = await http.get(urlApi);

    if (res.statusCode == 200) {
      return lokasiVmsModelFromJson(res.body.toString());
    } else {
      print('Failed to load Data!');
      throw Exception("Failed to load Data!");
    }
  }
}

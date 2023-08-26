import 'package:http/http.dart' as http;
import 'package:mobile_app_pilar/models/jadwal_model.dart';

class JadwalService {
  static const String _baseUrl = 'https://app.pilarsolusi.co.id/administrasi/api/dataJadwal.php';

  Future<List<JadwalModel>> getData() async {
    Uri urlApi = Uri.parse(_baseUrl);

    final res = await http.get(urlApi);

    if (res.statusCode == 200){
      return jadwalModelFromJson(res.body.toString());
    } else {
      print('Failed to load Data!');
      throw Exception("Failed to load Data!");
    }
  }
}
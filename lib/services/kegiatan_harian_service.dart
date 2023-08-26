import 'package:http/http.dart' as http;
import 'package:mobile_app_pilar/models/kegiatan_harian_model.dart';

class KegiatanHarianService {
  static const String _baseUrl = 'https://app.pilarsolusi.co.id/administrasi/api/dataMainhole.php';

  Future<List<KegiatanHarianModel>> getData() async {
    Uri urlApi = Uri.parse(_baseUrl);

    final res = await http.get(urlApi);

    if (res.statusCode == 200){
      return kegiatanHarianModelFromJson(res.body.toString());
    } else {
      print('Failed to load Data!');
      throw Exception("Failed to load Data!");
    }
  }
}
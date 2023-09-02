import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_app_pilar/models/perangkat_customer_id_keluar_model.dart';

class PerangkatCustomerIdKeluarService {
  static const String _baseUrl =
      'https://app.pilarsolusi.co.id/administrasi/api/dataPerangkatCustomerIdKeluar.php';

  Future<List<PerangkatCustomerIdKeluarModel>> getData() async {
    Uri urlApi = Uri.parse(_baseUrl);

    final res = await http.get(urlApi);

    if (res.statusCode == 200) {
      return perangkatCustomerIdKeluarModelFromJson(res.body.toString());
    } else {
      print('Failed to load Data!');
      throw Exception("Failed to load Data!");
    }
  }
}

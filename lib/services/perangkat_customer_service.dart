// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_app_pilar/models/perangkat_customer_model.dart';

class PerangkatCustomerService {
  static const String _baseUrl =
      'https://app.pilarsolusi.co.id/administrasi/api/dataPerangkatCustomer.php';
  Uri urlApi = Uri.parse(_baseUrl);

  Future<List<PerangkatCustomerModel>> getData() async {
    final res = await http.get(urlApi);

    if (res.statusCode == 200) {
      return perangkatCustomerModelFromJson(res.body.toString());
    } else {
      print('Failed to load Data!');
      throw Exception("Failed to load Data!");
    }
  }

  Future<List<String>> postData(
      String idKeluar,
      String lokasiSerialNumber,
      String koordinatSerialNumber,
      String usernameSerialNumber,
      String passwordSerialNumber) async {

    final res = await http.post(urlApi, body: {
      'addData' : '',
      'id_keluar' : idKeluar,
      'nama_lokasi' : lokasiSerialNumber,
      'koordinat_lokasi' : koordinatSerialNumber,
      'username_serial_number' : usernameSerialNumber,
      'password_serial_number' : passwordSerialNumber,
    });

    if (res.statusCode == 200) {
      var data  = json.decode(res.body);
      print(data);
      return [data];
      // return perangkatCustomerModelFromJson(res.body.toString());
    } else {
      print('Failed to post Data!');
      throw Exception("Failed to post Data!");
    }
  }

  Future<List<String>> deleteData(String idSerialNumber) async {
    final res = await http.post(urlApi, body: {
      'delData' : '',
      'id_serial_number' : idSerialNumber,
    });

    if (res.statusCode == 200) {
      var data  = json.decode(res.body);
      print(data);
      return [data];
      // return perangkatCustomerModelFromJson(res.body.toString());
    } else {
      print('Failed to load Data!');
      throw Exception("Failed to load Data!");
    }
  }
}

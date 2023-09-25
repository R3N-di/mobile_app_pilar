// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_app_pilar/models/perangkat_customer_model.dart';

class PerangkatCustomerService {
  static const String _baseUrl =
      'https://app.pilarsolusi.co.id/management/administrasi/api/dataPerangkatCustomer.php';
  Uri urlApi = Uri.parse(_baseUrl);

  Future<List<PerangkatCustomerModel>> getOneData(int id) async {
    String _baseUrl =
        'https://app.pilarsolusi.co.id/management/administrasi/api/dataPerangkatCustomer.php?id=$id';
    Uri urlApi = Uri.parse(_baseUrl);
    final res = await http.get(urlApi);

    if (res.statusCode == 200) {
      return perangkatCustomerModelFromJson(res.body.toString());
    } else {
      print('Failed to load Data!');
      throw Exception("Failed to load Data!");
    }
  }

  Future<List<PerangkatCustomerModel>> getData(int hal, int limit) async {
    String _baseUrl =
        'https://app.pilarsolusi.co.id/management/administrasi/api/dataPerangkatCustomer.php?limit=$limit&hal=$hal';
    Uri urlApi = Uri.parse(_baseUrl);
    final res = await http.get(urlApi);

    if (res.statusCode == 200) {
      return perangkatCustomerModelFromJson(res.body.toString());
    } else {
      print('Failed to load Data!');
      throw Exception("Failed to load Data!");
    }
  }
  
  Future<Map<String,dynamic>> postData(
      String idKeluar,
      String lokasiSerialNumber,
      String koordinatSerialNumber,
      String usernameSerialNumber,
      String passwordSerialNumber) async {
    final res = await http.post(urlApi, body: {
      'addData': '',
      'id_keluar': idKeluar,
      'nama_lokasi': lokasiSerialNumber,
      'koordinat_lokasi': koordinatSerialNumber,
      'username_serial_number': usernameSerialNumber,
      'password_serial_number': passwordSerialNumber,
    });

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      return data;
      // return perangkatCustomerModelFromJson(res.body.toString());
    } else {
      print('Failed to post Data!');
      throw Exception("Failed to post Data!");
    }
  }

  Future<Map<String,dynamic>> updateData(
      String lokasiSerialNumber,
      String koordinatSerialNumber,
      String usernameSerialNumber,
      String passwordSerialNumber,
      String idSerialNumber,
      ) async {
    final res = await http.post(urlApi, body: {
      'updateData': '',
      'id_serial_number': idSerialNumber,
      'nama_lokasi': lokasiSerialNumber,
      'koordinat_lokasi': koordinatSerialNumber,
      'username_serial_number': usernameSerialNumber,
      'password_serial_number': passwordSerialNumber,
    });

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      return data;
      // return perangkatCustomerModelFromJson(res.body.toString());
    } else {
      print('Failed to post Data!');
      throw Exception("Failed to post Data!");
    }
  }

  Future<Map<String,dynamic>> deleteData(String idSerialNumber) async {
    final res = await http.post(urlApi, body: {
      'delData': '',
      'id_serial_number': idSerialNumber,
    });

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      return data;
      // return perangkatCustomerModelFromJson(res.body.toString());
    } else {
      print('Failed to load Data!');
      throw Exception("Failed to load Data!");
    }
  }
}

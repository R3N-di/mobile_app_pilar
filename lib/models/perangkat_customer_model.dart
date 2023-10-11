// To parse this JSON data, do
//
//     final perangkatCustomerModel = perangkatCustomerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<PerangkatCustomerModel> perangkatCustomerModelFromJson(String str) => List<PerangkatCustomerModel>.from(json.decode(str).map((x) => PerangkatCustomerModel.fromJson(x)));

String perangkatCustomerModelToJson(List<PerangkatCustomerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PerangkatCustomerModel {
  final String? idKeluar;
  final String? idbarang;
  final String? penerima;
  final String? tanggalKeluar;
  final String? idPelanggan;
  final String? namaPelanggan;
  final String? namaItem;
  final String? deletedAt;
  String? namaLokasi;
  String? lokasiSerialNumber;
  final String? idSerialNumber;
  final String? gambarSerialNumber;
  String? usernameSerialNumber;
  String? passwordSerialNumber;

  PerangkatCustomerModel({
    required this.idKeluar,
    required this.idbarang,
    required this.penerima,
    required this.tanggalKeluar,
    required this.idPelanggan,
    required this.namaPelanggan,
    required this.namaItem,
    required this.deletedAt,
    required this.namaLokasi,
    required this.lokasiSerialNumber,
    required this.idSerialNumber,
    required this.gambarSerialNumber,
    required this.usernameSerialNumber,
    required this.passwordSerialNumber,
  });

  factory PerangkatCustomerModel.fromJson(Map<String, dynamic> json) => PerangkatCustomerModel(
        idKeluar: json["id_keluar"],
        idbarang: json["idbarang"],
        penerima: json["penerima"],
        tanggalKeluar: json["tanggal_keluar"],
        idPelanggan: json["id_pelanggan"],
        namaPelanggan: json["nama_pelanggan"],
        namaItem: json["nama_item"],
        deletedAt: json["deleted_at"],
        namaLokasi: json["nama_lokasi"],
        lokasiSerialNumber: json["lokasi_serial_number"],
        idSerialNumber: json["id_serial_number"],
        gambarSerialNumber: json["gambar_serial_number"],
        usernameSerialNumber: json["username_serial_number"],
        passwordSerialNumber: json["password_serial_number"],
      );

  Map<String, dynamic> toJson() => {
        "id_keluar": idKeluar,
        "idbarang": idbarang,
        "penerima": penerima,
        "tanggal_keluar": tanggalKeluar,
        "id_pelanggan": idPelanggan,
        "nama_pelanggan": namaPelanggan,
        "nama_item": namaItem,
        "deleted_at": deletedAt,
        "nama_lokasi": namaLokasi,
        "lokasi_serial_number": lokasiSerialNumber,
        "id_serial_number": idSerialNumber,
        "gambar_serial_number": gambarSerialNumber,
        "username_serial_number": usernameSerialNumber,
        "password_serial_number": passwordSerialNumber,
      };

// void updatenamaLokasi(String newName) {
//   namaLokasi = newName;
// }
}

// To parse this JSON data, do
//
//     final perangkatCustomerIdKeluarModel = perangkatCustomerIdKeluarModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<PerangkatCustomerIdKeluarModel> perangkatCustomerIdKeluarModelFromJson(String str) => List<PerangkatCustomerIdKeluarModel>.from(json.decode(str).map((x) => PerangkatCustomerIdKeluarModel.fromJson(x)));

String perangkatCustomerIdKeluarModelToJson(List<PerangkatCustomerIdKeluarModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PerangkatCustomerIdKeluarModel {
    final String idKeluar;
    final String namaPelanggan;
    final String namaItem;
    final String qty;

    PerangkatCustomerIdKeluarModel({
        required this.idKeluar,
        required this.namaPelanggan,
        required this.namaItem,
        required this.qty,
    });

    factory PerangkatCustomerIdKeluarModel.fromJson(Map<String, dynamic> json) => PerangkatCustomerIdKeluarModel(
        idKeluar: json["id_keluar"],
        namaPelanggan: json["nama_pelanggan"],
        namaItem: json["nama_item"],
        qty: json["qty"],
    );

    Map<String, dynamic> toJson() => {
        "id_keluar": idKeluar,
        "nama_pelanggan": namaPelanggan,
        "nama_item": namaItem,
        "qty": qty,
    };
}

// To parse this JSON data, do
//
//     final jadwalModel = jadwalModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<JadwalModel> jadwalModelFromJson(String str) => List<JadwalModel>.from(json.decode(str).map((x) => JadwalModel.fromJson(x)));

String jadwalModelToJson(List<JadwalModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JadwalModel {
    final String? statusJadwal;
    final String? namaJadwal;
    final String? namaPelanggan;
    final String? tglMulai;
    final String? tglSelesai;
    final String? idJadwal;
    final String? idPelanggan;
    final String? lokasiJadwal;
    final String? deletedAt;
    final String? deletedBy;

    JadwalModel({
        required this.statusJadwal,
        required this.namaJadwal,
        required this.namaPelanggan,
        required this.tglMulai,
        required this.tglSelesai,
        required this.idJadwal,
        required this.idPelanggan,
        required this.lokasiJadwal,
        required this.deletedAt,
        required this.deletedBy,
    });

    JadwalModel copyWith({
        String? statusJadwal,
        String? namaJadwal,
        String? namaPelanggan,
        String? tglMulai,
        String? tglSelesai,
        String? idJadwal,
        String? idPelanggan,
        String? lokasiJadwal,
        String? deletedAt,
        String? deletedBy,
    }) => 
        JadwalModel(
            statusJadwal: statusJadwal ?? this.statusJadwal,
            namaJadwal: namaJadwal ?? this.namaJadwal,
            namaPelanggan: namaPelanggan ?? this.namaPelanggan,
            tglMulai: tglMulai ?? this.tglMulai,
            tglSelesai: tglSelesai ?? this.tglSelesai,
            idJadwal: idJadwal ?? this.idJadwal,
            idPelanggan: idPelanggan ?? this.idPelanggan,
            lokasiJadwal: lokasiJadwal ?? this.lokasiJadwal,
            deletedAt: deletedAt ?? this.deletedAt,
            deletedBy: deletedBy ?? this.deletedBy,
        );

    factory JadwalModel.fromJson(Map<String, dynamic> json) => JadwalModel(
        statusJadwal: json["status_jadwal"],
        namaJadwal: json["nama_jadwal"],
        namaPelanggan: json["nama_pelanggan"],
        tglMulai: json["tgl_mulai"],
        tglSelesai: json["tgl_selesai"],
        idJadwal: json["id_jadwal"],
        idPelanggan: json["id_pelanggan"],
        lokasiJadwal: json["lokasi_jadwal"],
        deletedAt: json["deleted_at"],
        deletedBy: json["deleted_by"],
    );

    Map<String, dynamic> toJson() => {
        "status_jadwal": statusJadwal,
        "nama_jadwal": namaJadwal,
        "nama_pelanggan": namaPelanggan,
        "tgl_mulai": tglMulai,
        "tgl_selesai": tglSelesai,
        "id_jadwal": idJadwal,
        "id_pelanggan": idPelanggan,
        "lokasi_jadwal": lokasiJadwal,
        "deleted_at": deletedAt,
        "deleted_by": deletedBy,
    };
}

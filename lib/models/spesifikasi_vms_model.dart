// To parse this JSON data, do
//
//     final vmsModel = vmsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<VmsModel> vmsModelFromJson(String str) => List<VmsModel>.from(json.decode(str).map((x) => VmsModel.fromJson(x)));

String vmsModelToJson(List<VmsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VmsModel {
    final String idVms;
    final String idLokasiVms;
    final String panelVms;
    final String ukuranVms;
    final String pixelVms;
    final String psuVms;
    final String receiver;
    final String sender;
    final String pcServer;
    final String tahunPembuatanVms;
    final DateTime createdAt;
    final dynamic? updatedAt;
    final dynamic? deletedAt;
    final String createdBy;
    final String? updatedBy;
    final String? deletedBy;

    VmsModel({
        required this.idVms,
        required this.idLokasiVms,
        required this.panelVms,
        required this.ukuranVms,
        required this.pixelVms,
        required this.psuVms,
        required this.receiver,
        required this.sender,
        required this.pcServer,
        required this.tahunPembuatanVms,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.createdBy,
        required this.updatedBy,
        required this.deletedBy,
    });

    VmsModel copyWith({
        String? idVms,
        String? idLokasiVms,
        String? panelVms,
        String? ukuranVms,
        String? pixelVms,
        String? psuVms,
        String? receiver,
        String? sender,
        String? pcServer,
        String? tahunPembuatanVms,
        DateTime? createdAt,
        dynamic updatedAt,
        dynamic deletedAt,
        String? createdBy,
        String? updatedBy,
        String? deletedBy,
    }) => 
        VmsModel(
            idVms: idVms ?? this.idVms,
            idLokasiVms: idLokasiVms ?? this.idLokasiVms,
            panelVms: panelVms ?? this.panelVms,
            ukuranVms: ukuranVms ?? this.ukuranVms,
            pixelVms: pixelVms ?? this.pixelVms,
            psuVms: psuVms ?? this.psuVms,
            receiver: receiver ?? this.receiver,
            sender: sender ?? this.sender,
            pcServer: pcServer ?? this.pcServer,
            tahunPembuatanVms: tahunPembuatanVms ?? this.tahunPembuatanVms,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            deletedAt: deletedAt ?? this.deletedAt,
            createdBy: createdBy ?? this.createdBy,
            updatedBy: updatedBy ?? this.updatedBy,
            deletedBy: deletedBy ?? this.deletedBy,
        );

    factory VmsModel.fromJson(Map<String, dynamic> json) => VmsModel(
        idVms: json["id_vms"],
        idLokasiVms: json["id_lokasi_vms"],
        panelVms: json["panel_vms"],
        ukuranVms: json["ukuran_vms"],
        pixelVms: json["pixel_vms"],
        psuVms: json["psu_vms"],
        receiver: json["receiver"],
        sender: json["sender"],
        pcServer: json["pc_server"],
        tahunPembuatanVms: json["tahun_pembuatan_vms"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
    );

    Map<String, dynamic> toJson() => {
        "id_vms": idVms,
        "id_lokasi_vms": idLokasiVms,
        "panel_vms": panelVms,
        "ukuran_vms": ukuranVms,
        "pixel_vms": pixelVms,
        "psu_vms": psuVms,
        "receiver": receiver,
        "sender": sender,
        "pc_server": pcServer,
        "tahun_pembuatan_vms": tahunPembuatanVms,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
    };
}

enum DeletedAtEnum {
    NULL
}

final deletedAtEnumValues = EnumValues({
    "null": DeletedAtEnum.NULL
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

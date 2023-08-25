// To parse this JSON data, do
//
//     final lokasiVmsModel = lokasiVmsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<LokasiVmsModel> lokasiVmsModelFromJson(String str) => List<LokasiVmsModel>.from(json.decode(str).map((x) => LokasiVmsModel.fromJson(x)));

String lokasiVmsModelToJson(List<LokasiVmsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LokasiVmsModel {
    final String idLokasiVms;
    final String namaLokasiVms;
    final LajurLokasiVms? lajurLokasiVms;
    final String koordinatLokasiVms;
    final DateTime createdAt;
    final dynamic updatedAt;
    final dynamic deletedAt;
    final String createdBy;
    final String? updatedBy;
    final String? deletedBy;

    LokasiVmsModel({
        required this.idLokasiVms,
        required this.namaLokasiVms,
        required this.lajurLokasiVms,
        required this.koordinatLokasiVms,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.createdBy,
        required this.updatedBy,
        required this.deletedBy,
    });

    LokasiVmsModel copyWith({
        String? idLokasiVms,
        String? namaLokasiVms,
        LajurLokasiVms? lajurLokasiVms,
        String? koordinatLokasiVms,
        DateTime? createdAt,
        dynamic updatedAt,
        dynamic deletedAt,
        String? createdBy,
        String? updatedBy,
        String? deletedBy,
    }) => 
        LokasiVmsModel(
            idLokasiVms: idLokasiVms ?? this.idLokasiVms,
            namaLokasiVms: namaLokasiVms ?? this.namaLokasiVms,
            lajurLokasiVms: lajurLokasiVms ?? this.lajurLokasiVms,
            koordinatLokasiVms: koordinatLokasiVms ?? this.koordinatLokasiVms,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            deletedAt: deletedAt ?? this.deletedAt,
            createdBy: createdBy ?? this.createdBy,
            updatedBy: updatedBy ?? this.updatedBy,
            deletedBy: deletedBy ?? this.deletedBy,
        );

    factory LokasiVmsModel.fromJson(Map<String, dynamic> json) => LokasiVmsModel(
        idLokasiVms: json["id_lokasi_vms"],
        namaLokasiVms: json["nama_lokasi_vms"],
        lajurLokasiVms: lajurLokasiVmsValues.map[json["lajur_lokasi_vms"]]!,
        koordinatLokasiVms: json["koordinat_lokasi_vms"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
    );

    Map<String, dynamic> toJson() => {
        "id_lokasi_vms": idLokasiVms,
        "nama_lokasi_vms": namaLokasiVms,
        "lajur_lokasi_vms": lajurLokasiVmsValues.reverse[lajurLokasiVms],
        "koordinat_lokasi_vms": koordinatLokasiVms,
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

enum LajurLokasiVms {
    LAJUR_A,
    LAJUR_B
}

final lajurLokasiVmsValues = EnumValues({
    "LAJUR A": LajurLokasiVms.LAJUR_A,
    "LAJUR B": LajurLokasiVms.LAJUR_B
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

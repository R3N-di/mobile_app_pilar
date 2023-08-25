// To parse this JSON data, do
//
//     final mainholeModel = mainholeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<MainholeModel> mainholeModelFromJson(String str) => List<MainholeModel>.from(json.decode(str).map((x) => MainholeModel.fromJson(x)));

String mainholeModelToJson(List<MainholeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MainholeModel {
    final String idMainhole;
    final String lokasi;
    final Posisi? posisi;
    final String map;
    final String bulan;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime deletedAt;
    final String createdBy;
    final String? updatedBy;
    final String? deletedBy;

    MainholeModel({
        required this.idMainhole,
        required this.lokasi,
        required this.posisi,
        required this.map,
        required this.bulan,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.createdBy,
        required this.updatedBy,
        required this.deletedBy,
    });

    MainholeModel copyWith({
        String? idMainhole,
        String? lokasi,
        Posisi? posisi,
        String? map,
        String? bulan,
        DateTime? createdAt,
        DateTime? updatedAt,
        DateTime? deletedAt,
        String? createdBy,
        String? updatedBy,
        String? deletedBy,
    }) => 
        MainholeModel(
            idMainhole: idMainhole ?? this.idMainhole,
            lokasi: lokasi ?? this.lokasi,
            posisi: posisi ?? this.posisi,
            map: map ?? this.map,
            bulan: bulan ?? this.bulan,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            deletedAt: deletedAt ?? this.deletedAt,
            createdBy: createdBy ?? this.createdBy,
            updatedBy: updatedBy ?? this.updatedBy,
            deletedBy: deletedBy ?? this.deletedBy,
        );

    factory MainholeModel.fromJson(Map<String, dynamic> json) => MainholeModel(
        idMainhole: json["id_mainhole"],
        lokasi: json["lokasi"],
        posisi: posisiValues.map[json["posisi"]],
        map: json["map"],
        bulan: json["bulan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: DateTime.parse(json["deleted_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
    );

    Map<String, dynamic> toJson() => {
        "id_mainhole": idMainhole,
        "lokasi": lokasi,
        "posisi": posisiValues.reverse[posisi],
        "map": map,
        "bulan": bulan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
    };
}

enum Posisi {
    LAJUR_A,
    LAJUR_B
}

final posisiValues = EnumValues({
    "Lajur A": Posisi.LAJUR_A,
    "Lajur B": Posisi.LAJUR_B
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

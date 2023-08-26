// To parse this JSON data, do
//
//     final kegiatanHarianModel = kegiatanHarianModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<KegiatanHarianModel> kegiatanHarianModelFromJson(String str) => List<KegiatanHarianModel>.from(json.decode(str).map((x) => KegiatanHarianModel.fromJson(x)));

String kegiatanHarianModelToJson(List<KegiatanHarianModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KegiatanHarianModel {
    final String idKegiatan;
    final String idJadwal;
    final DateTime tanggal;
    final Kegiatan kegiatan;
    final String personil;
    final DateTime createdAt;
    final dynamic updatedAt;
    final dynamic deletedAt;
    final String createdBy;
    final String updatedBy;
    final String deletedBy;

    KegiatanHarianModel({
        required this.idKegiatan,
        required this.idJadwal,
        required this.tanggal,
        required this.kegiatan,
        required this.personil,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.createdBy,
        required this.updatedBy,
        required this.deletedBy,
    });

  // String get lokasi => null;

    KegiatanHarianModel copyWith({
        String? idKegiatan,
        String? idJadwal,
        DateTime? tanggal,
        Kegiatan? kegiatan,
        String? personil,
        DateTime? createdAt,
        dynamic updatedAt,
        dynamic deletedAt,
        String? createdBy,
        String? updatedBy,
        String? deletedBy,
    }) => 
        KegiatanHarianModel(
            idKegiatan: idKegiatan ?? this.idKegiatan,
            idJadwal: idJadwal ?? this.idJadwal,
            tanggal: tanggal ?? this.tanggal,
            kegiatan: kegiatan ?? this.kegiatan,
            personil: personil ?? this.personil,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            deletedAt: deletedAt ?? this.deletedAt,
            createdBy: createdBy ?? this.createdBy,
            updatedBy: updatedBy ?? this.updatedBy,
            deletedBy: deletedBy ?? this.deletedBy,
        );

    factory KegiatanHarianModel.fromJson(Map<String, dynamic> json) => KegiatanHarianModel(
        idKegiatan: json["id_kegiatan"],
        idJadwal: json["id_jadwal"],
        tanggal: DateTime.parse(json["tanggal"]),
        kegiatan: kegiatanValues.map[json["kegiatan"]]!,
        personil: json["personil"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
    );

    Map<String, dynamic> toJson() => {
        "id_kegiatan": idKegiatan,
        "id_jadwal": idJadwal,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "kegiatan": kegiatanValues.reverse[kegiatan],
        "personil": personil,
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

enum Kegiatan {
    INSTALASI,
    MAINTENANCE,
    SURVEY
}

final kegiatanValues = EnumValues({
    "Instalasi": Kegiatan.INSTALASI,
    "Maintenance": Kegiatan.MAINTENANCE,
    "Survey": Kegiatan.SURVEY
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

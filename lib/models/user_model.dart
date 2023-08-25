// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
    String userId;
    String userNama;
    String userUsername;
    String userPassword;
    String userFoto;
    UserLevel userLevel;

    UserModel({
        required this.userId,
        required this.userNama,
        required this.userUsername,
        required this.userPassword,
        required this.userFoto,
        required this.userLevel,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"],
        userNama: json["user_nama"],
        userUsername: json["user_username"],
        userPassword: json["user_password"],
        userFoto: json["user_foto"],
        userLevel: userLevelValues.map[json["user_level"]]!,
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_nama": userNama,
        "user_username": userUsername,
        "user_password": userPassword,
        "user_foto": userFoto,
        "user_level": userLevelValues.reverse[userLevel],
    };
}

enum UserLevel {
    ADMINISTRATOR,
    TEKNISI
}

final userLevelValues = EnumValues({
    "administrator": UserLevel.ADMINISTRATOR,
    "teknisi": UserLevel.TEKNISI
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

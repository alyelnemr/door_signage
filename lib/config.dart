// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Config configFromJson(String str) => Config.fromJson(json.decode(str));

String configToJson(Config data) => json.encode(data.toJson());

class Config {
  Config({
    required this.duration,
    required this.doctorNameENTop,
    required this.doctorNameENFontSize,
    required this.doctorNameARTop,
    required this.doctorNameARFontSize,
    required this.specialtyENTop,
    required this.specialtyENFontSize,
    required this.specialtyARTop,
    required this.specialtyARFontSize,
    required this.clinicDateTop,
    required this.clinicDateFontSize,
  });

  String duration;
  String doctorNameENTop;
  String doctorNameENFontSize;
  String doctorNameARTop;
  String doctorNameARFontSize;
  String specialtyENTop;
  String specialtyENFontSize;
  String specialtyARTop;
  String specialtyARFontSize;
  String clinicDateTop;
  String clinicDateFontSize;

  static Config fromJson(json) => Config(
    duration: json["duration"],
    doctorNameENTop: json["doctorNameENTop"],
    doctorNameENFontSize: json["doctorNameENFontSize"],
    doctorNameARTop: json["doctorNameARTop"],
    doctorNameARFontSize: json["doctorNameARFontSize"],
    specialtyENTop: json["specialtyENTop"],
    specialtyENFontSize: json["specialtyENFontSize"],
    specialtyARTop: json["specialtyARTop"],
    specialtyARFontSize: json["specialtyARFontSize"],
    clinicDateTop: json["clinicDateTop"],
    clinicDateFontSize: json["clinicDateFontSize"],
  );

  Map<String, dynamic> toJson() => {
    "duration": duration,
    "doctorNameENTop": doctorNameENTop,
    "doctorNameENFontSize": doctorNameENFontSize,
    "doctorNameARTop": doctorNameARTop,
    "doctorNameARFontSize": doctorNameARFontSize,
    "specialtyENTop": specialtyENTop,
    "specialtyENFontSize": specialtyENFontSize,
    "specialtyARTop": specialtyARTop,
    "specialtyARFontSize": specialtyARFontSize,
    "clinicDateTop": clinicDateTop,
    "clinicDateFontSize": clinicDateFontSize,
  };
}

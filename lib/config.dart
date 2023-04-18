// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Config configFromJson(String str) => Config.fromJson(json.decode(str));

String configToJson(Config data) => json.encode(data.toJson());

class Config {
  Config({
    required this.duration,
    required this.durationIPD,
    required this.appPassword,
    required this.doctorNameENTop,
    required this.doctorNameENTopIPD,
    required this.doctorNameENFontSize,
    required this.doctorNameARTop,
    required this.doctorNameARFontSize,
    required this.specialtyENTop,
    required this.specialtyENFontSize,
    required this.specialtyENFontColorRed,
    required this.specialtyENFontColorGreen,
    required this.specialtyENFontColorBlue,
    required this.specialtyARTop,
    required this.specialtyARTopIPD,
    required this.specialtyARFontSize,
    required this.clinicDateTop,
    required this.clinicDateFontSize,
  });

  String duration;
  String durationIPD;
  String appPassword;
  String doctorNameENTop;
  String doctorNameENTopIPD;
  String doctorNameENFontSize;
  String doctorNameARTop;
  String doctorNameARFontSize;
  String specialtyENTop;
  String specialtyENFontSize;
  String specialtyENFontColorRed;
  String specialtyENFontColorGreen;
  String specialtyENFontColorBlue;
  String specialtyARTop;
  String specialtyARTopIPD;
  String specialtyARFontSize;
  String clinicDateTop;
  String clinicDateFontSize;

  static Config fromJson(json) => Config(
    duration: json["duration"],
    durationIPD: json["duration_ipd"],
    appPassword: json["app_password"],
    doctorNameENTop: json["doctorNameENTop"],
    doctorNameENTopIPD: json["doctorNameENTop_ipd"],
    doctorNameENFontSize: json["doctorNameENFontSize"],
    doctorNameARTop: json["doctorNameARTop"],
    doctorNameARFontSize: json["doctorNameARFontSize"],
    specialtyENTop: json["specialtyENTop"],
    specialtyENFontSize: json["specialtyENFontSize"],
    specialtyENFontColorRed: json["specialtyENFontColorRed"],
    specialtyENFontColorGreen: json["specialtyENFontColorGreen"],
    specialtyENFontColorBlue: json["specialtyENFontColorBlue"],
    specialtyARTop: json["specialtyARTop"],
    specialtyARTopIPD: json["specialtyARTop_ipd"],
    specialtyARFontSize: json["specialtyARFontSize"],
    clinicDateTop: json["clinicDateTop"],
    clinicDateFontSize: json["clinicDateFontSize"],
  );

  Map<String, dynamic> toJson() => {
    "duration": duration,
    "duration_ipd": durationIPD,
    "app_password": appPassword,
    "doctorNameENTop": doctorNameENTop,
    "doctorNameENTop_ipd": doctorNameENTopIPD,
    "doctorNameENFontSize": doctorNameENFontSize,
    "doctorNameARTop": doctorNameARTop,
    "doctorNameARFontSize": doctorNameARFontSize,
    "specialtyENTop": specialtyENTop,
    "specialtyENFontSize": specialtyENFontSize,
    "specialtyENFontColorRed": specialtyENFontColorRed,
    "specialtyENFontColorGreen": specialtyENFontColorGreen,
    "specialtyENFontColorBlue": specialtyENFontColorBlue,
    "specialtyARTop": specialtyARTop,
    "specialtyARTop_ipd": specialtyARTopIPD,
    "specialtyARFontSize": specialtyARFontSize,
    "clinicDateTop": clinicDateTop,
    "clinicDateFontSize": clinicDateFontSize,
  };
}

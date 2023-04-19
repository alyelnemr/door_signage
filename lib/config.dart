// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Config configFromJson(String str) => Config.fromJson(json.decode(str));

String configToJson(Config data) => json.encode(data.toJson());

class Config {
  Config({
    this.duration= "10",
    this.durationIPD= "3600",
    this.appPassword= "1234",
    this.doctorNameENTop= "170",
    this.doctorNameENTopIPD= "70",
    this.doctorNameENFontSize= "70",
    this.doctorNameARTop= "10",
    this.doctorNameARFontSize= "70",
    this.specialtyENTop= "50",
    this.specialtyENFontSize= "70",
    this.specialtyENFontColorRed= "255",
    this.specialtyENFontColorGreen= "153",
    this.specialtyENFontColorBlue= "0",
    this.specialtyARTop= "10",
    this.specialtyARTopIPD= "50",
    this.specialtyARFontSize= "70",
    this.clinicDateTop= "60",
    this.clinicDateFontSize= "70",
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

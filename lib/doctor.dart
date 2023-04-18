// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Doctor doctorFromJson(String str) => Doctor.fromJson(json.decode(str));

String doctorToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
  Doctor({
    required this.id,
    required this.doctorNameAR,
    required this.doctorNameEN,
    required this.roomID,
    required this.clinicNameAR,
    required this.clinicNameEN,
    required this.specialtyAR,
    required this.specialtyEN,
    required this.clinicStartDate,
    required this.clinicEndDate,
    required this.imagePath,
    required this.refreshImage,
    required this.displayTime,
    required this.isActive,
    required this.isIPD,
  });

  String id;
  String doctorNameAR;
  String doctorNameEN;
  int roomID;
  String clinicNameAR;
  String clinicNameEN;
  String specialtyAR;
  String specialtyEN;
  String clinicStartDate;
  String clinicEndDate;
  String imagePath;
  bool refreshImage;
  bool displayTime;
  bool isActive;
  bool isIPD;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json["ID"] ?? "",
    doctorNameAR: json["DoctorNameAR"] ?? "",
    doctorNameEN: json["DoctorNameEN"] ?? "",
    roomID: json["RoomID"],
    clinicNameAR: json["ClinicNameAR"] ?? "",
    clinicNameEN: json["ClinicNameEN"] ?? "",
    specialtyAR: json["SpecialtyAR"] ?? "",
    specialtyEN: json["SpecialtyEN"] ?? "",
    clinicStartDate: json["ClinicStartDate"] ?? "",
    clinicEndDate: json["ClinicEndDate"] ?? "",
    imagePath: json["ImagePath"] ?? "",
    refreshImage: json["RefreshImage"] == null ? false : json["RefreshImage"] == "0" ? false : json["RefreshImage"] == 0 ? false : true ,
    displayTime: json["DisplayTime"] == null ? false : json["DisplayTime"] == "0" ? false : json["DisplayTime"] == 0 ? false : true ,
    isActive: json["IsActive"] == null ? false : json["IsActive"] == "0" ? false : json["IsActive"] == 0 ? false : true ,
    isIPD: json["isIPD"] == null ? false : json["isIPD"] == "0" ? false : json["isIPD"] == 0 ? false : true ,
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "DoctorNameAR": doctorNameAR,
    "DoctorNameEN": doctorNameEN,
    "RoomID": roomID,
    "ClinicNameAR": clinicNameAR,
    "ClinicNameEN": clinicNameEN,
    "SpecialtyAR": specialtyAR,
    "SpecialtyEN": specialtyEN,
    "ClinicStartDate": clinicStartDate,
    "ClinicEndDate": clinicEndDate,
    "ImagePath": imagePath,
    "RefreshImage": refreshImage,
    "DisplayTime": displayTime,
    "IsActive": isActive,
    "isIPD": isIPD,
  };
}

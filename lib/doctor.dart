// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

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
  });

  String id;
  final String doctorNameAR;
  final String doctorNameEN;
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

  static Doctor fromJson(json) => Doctor(
    id: json["ID"],
    doctorNameAR: json["DoctorNameAR"],
    doctorNameEN: json["DoctorNameEN"],
    roomID: json["RoomID"],
    clinicNameAR: json["ClinicNameAR"],
    clinicNameEN: json["ClinicNameEN"],
    specialtyAR: json["SpecialtyAR"],
    specialtyEN: json["SpecialtyEN"],
    clinicStartDate: json["ClinicStartDate"],
    clinicEndDate: json["ClinicEndDate"],
    imagePath: json["ImagePath"],
    refreshImage: json["RefreshImage"],
    displayTime: json["DisplayTime"],
  );

  factory Doctor.fromJson_(Map<String, dynamic> json) => Doctor(
    id: json["ID"],
    doctorNameAR: json["DoctorNameAR"],
    doctorNameEN: json["DoctorNameEN"],
    roomID: json["RoomID"],
    clinicNameAR: json["ClinicNameAR"],
    clinicNameEN: json["ClinicNameEN"],
    specialtyAR: json["SpecialtyAR"],
    specialtyEN: json["SpecialtyEN"],
    clinicStartDate: json["ClinicStartDate"],
    clinicEndDate: json["ClinicEndDate"],
    imagePath: json["ImagePath"],
    refreshImage: json["RefreshImage"],
    displayTime: json["DisplayTime"],
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
  };
}

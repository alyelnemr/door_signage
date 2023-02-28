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
    required this.clinicId,
    required this.clinicNameAR,
    required this.clinicNameEN,
    required this.specialtyAR,
    required this.specialtyEN,
    required this.clinicStartDate,
    required this.clinicEndDate,
    required this.imagePath,
  });

  int id;
  final String doctorNameAR;
  final String doctorNameEN;
  int clinicId;
  String clinicNameAR;
  String clinicNameEN;
  String specialtyAR;
  String specialtyEN;
  String clinicStartDate;
  String clinicEndDate;
  String imagePath;

  static Doctor fromJson(json) => Doctor(
    id: json["ID"],
    doctorNameAR: json["DoctorNameAR"],
    doctorNameEN: json["DoctorNameEN"],
    clinicId: json["ClinicID"],
    clinicNameAR: json["ClinicNameAR"],
    clinicNameEN: json["ClinicNameEN"],
    specialtyAR: json["SpecialtyAR"],
    specialtyEN: json["SpecialtyEN"],
    clinicStartDate: json["ClinicStartDate"],
    clinicEndDate: json["ClinicEndDate"],
    imagePath: json["ImagePath"],
  );

  factory Doctor.fromJson_(Map<String, dynamic> json) => Doctor(
    id: json["ID"],
    doctorNameAR: json["DoctorNameAR"],
    doctorNameEN: json["DoctorNameEN"],
    clinicId: json["ClinicID"],
    clinicNameAR: json["ClinicNameAR"],
    clinicNameEN: json["ClinicNameEN"],
    specialtyAR: json["SpecialtyAR"],
    specialtyEN: json["SpecialtyEN"],
    clinicStartDate: json["ClinicStartDate"],
    clinicEndDate: json["ClinicEndDate"],
    imagePath: json["ImagePath"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "DoctorNameAR": doctorNameAR,
    "DoctorNameEN": doctorNameEN,
    "ClinicID": clinicId,
    "ClinicNameAR": clinicNameAR,
    "ClinicNameEN": clinicNameEN,
    "SpecialtyAR": specialtyAR,
    "SpecialtyEN": specialtyEN,
    "ClinicStartDate": clinicStartDate,
    "ClinicEndDate": clinicEndDate,
    "ImagePath": imagePath,
  };
}

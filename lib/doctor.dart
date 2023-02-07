// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Doctor doctorFromJson(String str) => Doctor.fromJson(json.decode(str));

String doctorToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
  Doctor({
    required this.id,
    required this.doctorName,
    required this.clinicId,
    required this.clinicStartDate,
    required this.clinicEndDate,
    required this.imagePath,
    this.imageBinary,
  });

  int id;
  final String doctorName;
  int clinicId;
  String clinicStartDate;
  String clinicEndDate;
  String imagePath;
  dynamic imageBinary;

  static Doctor fromJson(json) => Doctor(
    id: json["ID"],
    doctorName: json["DoctorName"],
    clinicId: json["ClinicID"],
    clinicStartDate: json["ClinicStartDate"],
    clinicEndDate: json["ClinicEndDate"],
    imagePath: json["ImagePath"],
    imageBinary: json["ImageBinary"],
  );

  factory Doctor.fromJson_(Map<String, dynamic> json) => Doctor(
    id: json["ID"],
    doctorName: json["DoctorName"],
    clinicId: json["ClinicID"],
    clinicStartDate: json["ClinicStartDate"],
    clinicEndDate: json["ClinicEndDate"],
    imagePath: json["ImagePath"],
    imageBinary: json["ImageBinary"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "DoctorName": doctorName,
    "ClinicID": clinicId,
    "ClinicStartDate": clinicStartDate,
    "ClinicEndDate": clinicEndDate,
    "ImagePath": imagePath,
    "ImageBinary": imageBinary,
  };
}

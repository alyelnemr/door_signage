// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Doctor doctorFromJson(String str) => Doctor.fromJson(json.decode(str));

String doctorToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
  Doctor({
    this.id="0",
    this.doctorNameAR = "",
    this.doctorNameEN = "",
    this.roomID = 0,
    this.patientID = "",
    this.clinicNameAR = "",
    this.clinicNameEN = "",
    this.specialtyAR = "",
    this.specialtyEN = "",
    this.clinicStartDate = "2023-01-01 00:00:00",
    this.clinicEndDate = "2023-01-01 00:00:00",
    this.imagePath = "http://ahj-queue.andalusiagroup.net:1020/api/getEmptyImage",
    this.refreshImage = false,
    this.displayTime = false,
    this.isActive = false,
    this.isIPD = false,
    this.isIPDImage1=false,
    this.isIPDImage2=false,
    this.isIPDImage3=false,
    this.isIPDImage4=false,
    this.isIPDImage5=false,
    this.isIPDImage6=false,
    this.isIPDImage7=false,
    this.isIPDImage8=false,
  });

  // , room.isIPDImage1, room.isIPDImage2, room.isIPDImage3, room.isIPDImage4, room.isIPDImage5, room.isIPDImage6, room.isIPDImage7, room.isIPDImage8,
  String id;
  String doctorNameAR;
  String doctorNameEN;
  int roomID;
  String patientID;
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
  bool isIPDImage1;
  bool isIPDImage2;
  bool isIPDImage3;
  bool isIPDImage4;
  bool isIPDImage5;
  bool isIPDImage6;
  bool isIPDImage7;
  bool isIPDImage8;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json["ID"] ?? "",
    doctorNameAR: json["DoctorNameAR"] ?? "",
    doctorNameEN: json["DoctorNameEN"] ?? "",
    roomID: json["RoomID"],
    patientID: json["PatientID"] ?? "",
    clinicNameAR: json["ClinicNameAR"] ?? "",
    clinicNameEN: json["ClinicNameEN"] ?? "",
    specialtyAR: json["SpecialtyAR"] ?? "",
    specialtyEN: json["SpecialtyEN"] ?? "",
    clinicStartDate: json["ClinicStartDate"] ?? "",
    clinicEndDate: json["ClinicEndDate"] ?? "",
    imagePath: json["ImagePath"] ?? "",
    refreshImage: json["RefreshImage"] == false ? false : json["RefreshImage"] == null ? false : json["RefreshImage"] == "" ? false : json["RefreshImage"] == "false" ? false : json["RefreshImage"] == "False" ? false : json["RefreshImage"] == "0" ? false : json["RefreshImage"] == 0 ? false : true ,
    displayTime: json["DisplayTime"] == false ?  false : json["DisplayTime"] == null ?  false : json["DisplayTime"] == "" ?  false : json["DisplayTime"] == "false" ?  false : json["DisplayTime"] == "False" ? false : json["DisplayTime"] == "0" ? false : json["DisplayTime"] == 0 ? false : true ,
    isActive: json["IsActive"] == false ? false : json["IsActive"] == null ? false : json["IsActive"] == "" ? false : json["IsActive"] == "false" ? false : json["IsActive"] == "False" ? false : json["IsActive"] == "0" ? false : json["IsActive"] == 0 ? false : true ,
    isIPD: json["isIPD"] == false ?  false : json["isIPD"] == null ?  false : json["isIPD"] == "false" ? false : json["isIPD"] == "False" ? false : json["isIPD"] == "0" ? false : json["isIPD"] == 0 ? false : true ,
    isIPDImage1: json["isIPDImage1"] == false ? false : json["isIPDImage1"] == null ? false : json["isIPDImage1"] == "false" ? false : json["isIPDImage1"] == "False" ? false : json["isIPDImage1"] == "0" ? false : json["isIPDImage1"] == 0 ? false : true ,
    isIPDImage2: json["isIPDImage2"] == false ? false : json["isIPDImage2"] == null ? false : json["isIPDImage2"] == "false" ? false : json["isIPDImage2"] == "False" ? false : json["isIPDImage2"] == "0" ? false : json["isIPDImage2"] == 0 ? false : true ,
    isIPDImage3: json["isIPDImage3"] == false ? false : json["isIPDImage3"] == null ? false : json["isIPDImage3"] == "false" ? false : json["isIPDImage3"] == "False" ? false : json["isIPDImage3"] == "0" ? false : json["isIPDImage3"] == 0 ? false : true ,
    isIPDImage4: json["isIPDImage4"] == false ? false : json["isIPDImage4"] == null ? false : json["isIPDImage4"] == "false" ? false : json["isIPDImage4"] == "False" ? false : json["isIPDImage4"] == "0" ? false : json["isIPDImage4"] == 0 ? false : true ,
    isIPDImage5: json["isIPDImage5"] == false ? false : json["isIPDImage5"] == null ? false : json["isIPDImage5"] == "false" ? false : json["isIPDImage5"] == "False" ? false : json["isIPDImage5"] == "0" ? false : json["isIPDImage5"] == 0 ? false : true ,
    isIPDImage6: json["isIPDImage6"] == false ? false : json["isIPDImage6"] == null ? false : json["isIPDImage6"] == "false" ? false : json["isIPDImage6"] == "False" ? false : json["isIPDImage6"] == "0" ? false : json["isIPDImage6"] == 0 ? false : true ,
    isIPDImage7: json["isIPDImage7"] == false ? false : json["isIPDImage7"] == null ? false : json["isIPDImage7"] == "false" ? false : json["isIPDImage7"] == "False" ? false : json["isIPDImage7"] == "0" ? false : json["isIPDImage7"] == 0 ? false : true ,
    isIPDImage8: json["isIPDImage8"] == false ? false : json["isIPDImage8"] == null ? false : json["isIPDImage8"] == "false" ? false : json["isIPDImage8"] == "False" ? false : json["isIPDImage8"] == "0" ? false : json["isIPDImage8"] == 0 ? false : true ,
  );

  bool isEqual(Doctor doctor){
    if(doctorNameAR != doctor.doctorNameAR) {
      return false;
    }
    if(doctorNameEN != doctor.doctorNameEN) {
      return false;
    }
    if(patientID != doctor.patientID) {
      return false;
    }
    if(isIPD != doctor.isIPD) {
      return false;
    }
    if(isIPDImage1 != doctor.isIPDImage1) {
      return false;
    }
    if(isIPDImage2 != doctor.isIPDImage2) {
      return false;
    }
    if(isIPDImage3 != doctor.isIPDImage3) {
      return false;
    }
    if(isIPDImage4 != doctor.isIPDImage4) {
      return false;
    }
    if(isIPDImage5 != doctor.isIPDImage5) {
      return false;
    }
    if(isIPDImage6 != doctor.isIPDImage6) {
      return false;
    }
    if(isIPDImage7 != doctor.isIPDImage7) {
      return false;
    }
    if(isIPDImage8 != doctor.isIPDImage8) {
      return false;
    }
    return true;
  }

  Map<String, dynamic> toJson() => {
    "ID": id,
    "DoctorNameAR": doctorNameAR,
    "DoctorNameEN": doctorNameEN,
    "RoomID": roomID,
    "PatientID": patientID,
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
    "isIPDImage1": isIPDImage1,
    "isIPDImage2": isIPDImage2,
    "isIPDImage3": isIPDImage3,
    "isIPDImage4": isIPDImage4,
    "isIPDImage5": isIPDImage5,
    "isIPDImage6": isIPDImage6,
    "isIPDImage7": isIPDImage7,
    "isIPDImage8": isIPDImage8,
  };
}

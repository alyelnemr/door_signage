// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

QueueData queueFromJson(String str) => QueueData.fromJson(json.decode(str));

String queueToJson(QueueData data) => json.encode(data.toJson());

class QueueData {
  QueueData({
    required this.queueText,
  });

  String queueText;

  factory QueueData.fromJson(Map<String, dynamic> json) => QueueData(
    queueText: json["queueText"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "queueText": queueText,
  };
}

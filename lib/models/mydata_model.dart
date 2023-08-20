// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MyDataModel {
  final String title;
  final String detail;
  final Timestamp start;
  final Timestamp end;
  final Timestamp timestamp;
  MyDataModel({
    required this.title,
    required this.detail,
    required this.start,
    required this.end,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'detail': detail,
      'start': start,
      'end': end,
      'timestamp': timestamp,
    };
  }

  factory MyDataModel.fromMap(Map<String, dynamic> map) {
    return MyDataModel(
      title: (map['title'] ?? '') as String,
      detail: (map['detail'] ?? '') as String,
      start: (map['start'] ?? Timestamp(0, 0)),
      end: (map['end']?? Timestamp(0, 0)),
      timestamp: (map['timestamp'] ?? Timestamp(0, 0)),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyDataModel.fromJson(String source) => MyDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

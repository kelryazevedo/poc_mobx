import 'package:flutter/material.dart';

class CacheDTO {
  dynamic data;
  num expiresInMinutes = 60;
  String createTime = DateTime.now().toIso8601String();

  CacheDTO({@required this.data});

  CacheDTO.map(Map<String, dynamic> json) {
    this.data = json['data'];
    this.expiresInMinutes = json['expiresInMinutes'];
    this.createTime = json['createTime'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["data"] = data;
    map["expiresInMinutes"] = expiresInMinutes;
    map["createTime"] = createTime;
    return map;
  }

  bool get isCacheValid {
    var createTimeDate = DateTime.parse(this.createTime);
    var diff = DateTime.now().difference(createTimeDate).inMinutes;
    if (diff >= expiresInMinutes)
      return false;
    else
      return true;
  }
}

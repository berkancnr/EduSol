import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class RecycleBox {
  String boxId;
  double fulness;
  int city;
  int province;
  int street;
  int bagCount;
  int bottleCount;
  Timestamp lastCleanDate;
  Timestamp lastrefillDate;
  Timestamp dateOfStart;
  GeoPoint geoPoint;
  String geohash;
  RecycleBox({
    this.boxId,
    this.fulness,
    this.city,
    this.province,
    this.street,
    this.bagCount,
    this.bottleCount,
    this.lastCleanDate,
    this.lastrefillDate,
    this.dateOfStart,
    this.geoPoint,
    this.geohash,
  });

  RecycleBox copyWith({
    String boxId,
    double fulness,
    int city,
    int province,
    int street,
    int bagCount,
    int bottleCount,
    Timestamp lastCleanDate,
    Timestamp lastrefillDate,
    Timestamp dateOfStart,
    GeoPoint geoPoint,
    String geohash,
  }) {
    return RecycleBox(
      boxId: boxId ?? this.boxId,
      fulness: fulness ?? this.fulness,
      city: city ?? this.city,
      province: province ?? this.province,
      street: street ?? this.street,
      bagCount: bagCount ?? this.bagCount,
      bottleCount: bottleCount ?? this.bottleCount,
      lastCleanDate: lastCleanDate ?? this.lastCleanDate,
      lastrefillDate: lastrefillDate ?? this.lastrefillDate,
      dateOfStart: dateOfStart ?? this.dateOfStart,
      geoPoint: geoPoint ?? this.geoPoint,
      geohash: geohash ?? this.geohash,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'boxId': boxId,
      'fulness': fulness,
      'city': city,
      'province': province,
      'street': street,
      'bagCount': bagCount,
      'bottleCount': bottleCount,
      'lastCleanDate': lastCleanDate,
      'lastrefillDate': lastrefillDate,
      'dateOfStart': dateOfStart,
      'geoPoint': geoPoint,
      'geohash': geohash,
    };
  }

  factory RecycleBox.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RecycleBox(
      boxId: map['boxId'],
      fulness: map['fulness'],
      city: map['city'],
      province: map['province'],
      street: map['street'],
      bagCount: map['bagCount'],
      bottleCount: map['bottleCount'],
      lastCleanDate: map['lastCleanDate'],
      lastrefillDate: map['lastrefillDate'],
      dateOfStart: map['dateOfStart'],
      geoPoint: map['geoPoint'],
      geohash: map['geohash'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecycleBox.fromJson(String source) =>
      RecycleBox.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RecyclerBox(boxId: $boxId, fulness: $fulness, city: $city, province: $province, street: $street, bagCount: $bagCount, bottleCount: $bottleCount, lastCleanDate: $lastCleanDate, lastrefillDate: $lastrefillDate, dateOfStart: $dateOfStart, geoPoint: $geoPoint, geohash: $geohash)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecycleBox &&
        o.boxId == boxId &&
        o.fulness == fulness &&
        o.city == city &&
        o.province == province &&
        o.street == street &&
        o.bagCount == bagCount &&
        o.bottleCount == bottleCount &&
        o.lastCleanDate == lastCleanDate &&
        o.lastrefillDate == lastrefillDate &&
        o.dateOfStart == dateOfStart &&
        o.geoPoint == geoPoint &&
        o.geohash == geohash;
  }

  @override
  int get hashCode {
    return boxId.hashCode ^
        fulness.hashCode ^
        city.hashCode ^
        province.hashCode ^
        street.hashCode ^
        bagCount.hashCode ^
        bottleCount.hashCode ^
        lastCleanDate.hashCode ^
        lastrefillDate.hashCode ^
        dateOfStart.hashCode ^
        geoPoint.hashCode ^
        geohash.hashCode;
  }
}

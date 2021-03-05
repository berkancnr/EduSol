import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String userId;
  String emailAddress;
  String password;
  String nameAndSurname;
  String avatar;
  String geoHash;
  GeoPoint geoPoint;
  int totalUsedBag;
  int totalUsedBottom;
  int point;
  int totalDonate;
  bool isBanned;
  bool isDeleted;
  bool isFrozed;
  Timestamp creationDate;
  Timestamp deletionDate;
  Account({
    this.userId,
    this.emailAddress,
    this.password,
    this.nameAndSurname,
    this.avatar,
    this.geoHash,
    this.geoPoint,
    this.totalUsedBag,
    this.totalUsedBottom,
    this.point,
    this.totalDonate,
    this.isBanned,
    this.isDeleted,
    this.isFrozed,
    this.creationDate,
    this.deletionDate,
  });

  Account copyWith({
    String userId,
    String emailAddress,
    String password,
    String nameAndSurname,
    String avatar,
    String geoHash,
    GeoPoint geoPoint,
    int totalUsedBag,
    int totalUsedBottom,
    int point,
    int totalDonate,
    bool isBanned,
    bool isDeleted,
    bool isFrozed,
    Timestamp creationDate,
    Timestamp deletionDate,
  }) {
    return Account(
      userId: userId ?? this.userId,
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      nameAndSurname: nameAndSurname ?? this.nameAndSurname,
      avatar: avatar ?? this.avatar,
      geoHash: geoHash ?? this.geoHash,
      geoPoint: geoPoint ?? this.geoPoint,
      totalUsedBag: totalUsedBag ?? this.totalUsedBag,
      totalUsedBottom: totalUsedBottom ?? this.totalUsedBottom,
      point: point ?? this.point,
      totalDonate: totalDonate ?? this.totalDonate,
      isBanned: isBanned ?? this.isBanned,
      isDeleted: isDeleted ?? this.isDeleted,
      isFrozed: isFrozed ?? this.isFrozed,
      creationDate: creationDate ?? this.creationDate,
      deletionDate: deletionDate ?? this.deletionDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'emailAddress': emailAddress,
      'password': password,
      'nameAndSurname': nameAndSurname,
      'avatar': avatar,
      'geoHash': geoHash,
      'geoPoint': geoPoint,
      'totalUsedBag': totalUsedBag,
      'totalUsedBottom': totalUsedBottom,
      'point': point,
      'totalDonate': totalDonate,
      'isBanned': isBanned,
      'isDeleted': isDeleted,
      'isFrozed': isFrozed,
      'creationDate': creationDate,
      'deletionDate': deletionDate,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Account(
      userId: map['userId'],
      emailAddress: map['emailAddress'],
      password: map['password'],
      nameAndSurname: map['nameAndSurname'],
      avatar: map['avatar'],
      geoHash: map['geoHash'],
      geoPoint: map['geoPoint'],
      totalUsedBag: map['totalUsedBag'],
      totalUsedBottom: map['totalUsedBottom'],
      point: map['point'],
      totalDonate: map['totalDonate'],
      isBanned: map['isBanned'],
      isDeleted: map['isDeleted'],
      isFrozed: map['isFrozed'],
      creationDate: map['creationDate'],
      deletionDate: map['deletionDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Account(userId: $userId, emailAddress: $emailAddress, password: $password, nameAndSurname: $nameAndSurname, avatar: $avatar, geoHash: $geoHash, geoPoint: $geoPoint, totalUsedBag: $totalUsedBag, totalUsedBottom: $totalUsedBottom, point: $point, totalDonate: $totalDonate, isBanned: $isBanned, isDeleted: $isDeleted, isFrozed: $isFrozed, creationDate: $creationDate, deletionDate: $deletionDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Account &&
        o.userId == userId &&
        o.emailAddress == emailAddress &&
        o.password == password &&
        o.nameAndSurname == nameAndSurname &&
        o.avatar == avatar &&
        o.geoHash == geoHash &&
        o.geoPoint == geoPoint &&
        o.totalUsedBag == totalUsedBag &&
        o.totalUsedBottom == totalUsedBottom &&
        o.point == point &&
        o.totalDonate == totalDonate &&
        o.isBanned == isBanned &&
        o.isDeleted == isDeleted &&
        o.isFrozed == isFrozed &&
        o.creationDate == creationDate &&
        o.deletionDate == deletionDate;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        emailAddress.hashCode ^
        password.hashCode ^
        nameAndSurname.hashCode ^
        avatar.hashCode ^
        geoHash.hashCode ^
        geoPoint.hashCode ^
        totalUsedBag.hashCode ^
        totalUsedBottom.hashCode ^
        point.hashCode ^
        totalDonate.hashCode ^
        isBanned.hashCode ^
        isDeleted.hashCode ^
        isFrozed.hashCode ^
        creationDate.hashCode ^
        deletionDate.hashCode;
  }
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String userId;
  String emailAddress;
  String password;
  String nameAndSurname;
  String avatar;
  String field;
  int totalStudents;
  int likeCount;
  int commentCount;
  double point;
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
    this.field = 'Yazılım',
    this.totalStudents = 0,
    this.likeCount = 0,
    this.commentCount = 0,
    this.point = 0.0,
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
    String field,
    int totalStudents,
    int likeCount,
    int commentCount,
    double point,
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
      field: field ?? this.field,
      totalStudents: totalStudents ?? this.totalStudents,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      point: point ?? this.point,
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
      'field': field,
      'totalStudents': totalStudents,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'point': point,
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
      field: map['field'],
      totalStudents: map['totalStudents'],
      likeCount: map['likeCount'],
      commentCount: map['commentCount'],
      point: map['point'],
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
    return 'Account(userId: $userId, emailAddress: $emailAddress, password: $password, nameAndSurname: $nameAndSurname, avatar: $avatar, field: $field, totalStudents: $totalStudents, likeCount: $likeCount, commentCount: $commentCount, point: $point, isBanned: $isBanned, isDeleted: $isDeleted, isFrozed: $isFrozed, creationDate: $creationDate, deletionDate: $deletionDate)';
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
        o.field == field &&
        o.totalStudents == totalStudents &&
        o.likeCount == likeCount &&
        o.commentCount == commentCount &&
        o.point == point &&
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
        field.hashCode ^
        totalStudents.hashCode ^
        likeCount.hashCode ^
        commentCount.hashCode ^
        point.hashCode ^
        isBanned.hashCode ^
        isDeleted.hashCode ^
        isFrozed.hashCode ^
        creationDate.hashCode ^
        deletionDate.hashCode;
  }
}

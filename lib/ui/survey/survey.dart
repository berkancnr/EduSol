import 'package:edusol/models/account.dart';
import 'package:flutter/material.dart';
import 'package:edusol/core/constans/app/global_variables.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SurveyScreen extends StatefulWidget {
  SurveyScreen({Key key}) : super(key: key);

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

GlobalVariables _globalVariables = GlobalVariables();

class _SurveyScreenState extends State<SurveyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            itemCount: mentors.length,
            itemBuilder: (context, index) => mentorCard(mentors[index])),
      ),
    );
  }
}

String avatar(int index) {
  if (index % 2 == 0) {
    return _globalVariables.manAvatar;
  } else
    return _globalVariables.girlAvatar;
}

List<Account> mentors = [
  Account(
    nameAndSurname: 'Berkan Çınar',
    emailAddress: 'berkancinar@edusol.com',
    avatar:
        'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
    field: 'Sanatçı',
    point: 182,
    totalStudents: 8,
    commentCount: 3,
  ),
  Account(
    nameAndSurname: 'Beyza Karadeniz',
    emailAddress: 'beyzakaradeniz@edusol.com',
    avatar:
        'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
    field: 'Yazılımcı',
    point: 258,
    totalStudents: 15,
    commentCount: 8,
  ),
  Account(
    nameAndSurname: 'Sadık Şener',
    emailAddress: 'sadiksener@edusol.com',
    avatar:
        'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
    field: 'Matematik öğretmeni',
    point: 103,
    totalStudents: 23,
    commentCount: 18,
  ),
  Account(
    nameAndSurname: 'Emine Demircan',
    emailAddress: 'berkancinar@edusol.com',
    avatar:
        'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
    field: 'Oyuncu',
    point: 157,
    totalStudents: 5,
    commentCount: 2,
  ),
];

Column mentorCard(Account mentor) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
                direction: Axis.vertical,
                spacing: 2,
                runSpacing: 2,
                children: [
                  Text(
                    mentor.nameAndSurname,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    mentor.field,
                    style: TextStyle(fontSize: 12),
                  )
                ]),
            Icon(
              FontAwesomeIcons.chevronDown,
              size: 16,
            ),
          ],
        ),
      ),
      Card(
        margin: EdgeInsets.all(24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            mentor.avatar,
            height: 346,
            width: double.infinity,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            spacing: 2,
            runSpacing: 2,
            children: [
              Text(
                'Puan',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                mentor.point.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            spacing: 2,
            runSpacing: 2,
            children: [
              Text(
                'Toplam Öğrenci',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                mentor.totalStudents.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            spacing: 2,
            runSpacing: 2,
            children: [
              Text(
                'Yorum Sayısı',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                mentor.commentCount.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          )
        ],
      ),
      SizedBox(
        height: 20,
      )
    ],
  );
}

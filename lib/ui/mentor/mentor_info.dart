import 'package:flutter/material.dart';

Image _profilePhoto;
String _name;
List<String> _communications;

class MentorInfo extends StatefulWidget {
  MentorInfo(
      {Key key, Image profilePhoto, String name, List<String> communications})
      : super(key: key) {
    _profilePhoto = profilePhoto;
    _name = name;
    _communications = communications;
  }

  @override
  _MentorInfoState createState() => _MentorInfoState();
}

class _MentorInfoState extends State<MentorInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: AlertDialog(
      title: Column(
        children: [
          Text(_name),
          _profilePhoto,
        ],
      ),
    ));
  }
}

import 'package:edusol/ui/survey/survey.dart';
import 'package:flutter/material.dart';
import 'package:edusol/ui/mentor/mentor_screen.dart';
import 'package:edusol/ui/profile/profile_screen.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int defaultTabLength = 3;

  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: DefaultTabController(
          length: defaultTabLength,
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  children: [SurveyScreen(), MentorScreen(), ProfilScreen()],
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                ),
              ),
              _tabBarItems,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _tabBarItems => TabBar(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.purple, width: 4.0),
          insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
        ),
        tabs: <Widget>[
          Tab(icon: Icon(Icons.short_text)),
          Tab(icon: Icon(Icons.person)),
          Tab(icon: Icon(Icons.person_pin))
        ],
        onTap: _changePage,
      );

  void _changePage(int value) {
    print(value);
    _pageController.animateToPage(value,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }
}

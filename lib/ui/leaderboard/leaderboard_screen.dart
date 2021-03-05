import 'package:edusol/core/constans/app/global_variables.dart';
import 'package:edusol/core/constans/locator.dart';
import 'package:edusol/models/account.dart';
import 'package:edusol/viewmodels/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaderBoardScreen extends StatefulWidget {
  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  AccountProvider _accountProvider;

  @override
  Widget build(BuildContext context) {
    _accountProvider = Provider.of<AccountProvider>(context);
    var _globalVariables = locator.get<GlobalVariables>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _globalVariables.usersOfWeek,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _accountProvider.allUsers.length,
                itemBuilder: (context, index) =>
                    _singleCard(_accountProvider.allUsers[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _singleCard(Account cUser) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(cUser.avatar),
            ),
            title: Text(cUser.nameAndSurname),
            trailing: Text(cUser.point.toString()),
          ),
        ));
  }
}

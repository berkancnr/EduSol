import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:edusol/core/constans/app/global_variables.dart';
import 'package:edusol/core/constans/app/time_converter.dart';
import 'package:edusol/core/constans/locator.dart';
import 'package:edusol/ui/profile/donate_screen.dart';
import 'package:edusol/viewmodels/account_provider.dart';
import 'package:provider/provider.dart';

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  AccountProvider _accountProvider;
  final GlobalVariables _globalVariables = locator.get<GlobalVariables>();
  final TimeConverter _timeConverter = locator.get<TimeConverter>();

  @override
  Widget build(BuildContext context) {
    _accountProvider = Provider.of<AccountProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          SizedBox(
            height: 24,
          ),
          buildPersonAvatar(),
          Expanded(child: buildContainerPoint()),
          Expanded(flex: 5, child: buildAllMethod()),
          _donateButton
        ]),
      ),
    );
  }

  Widget buildPersonAvatar() {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(_globalVariables.girlAvatar),
                    minRadius: 60.0,
                  ),
                ]),
            SizedBox(
              height: 10,
            ),
            Text(_accountProvider.currentAccount.nameAndSurname,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ))
          ]),
    );
  }

  ListView buildAllMethod() {
    return ListView(
      children: <Widget>[builContainerInformation()],
    );
  }

  Container builContainerInformation() {
    return Container(
      child: buildColumn(),
    );
  }

  Column buildColumn() {
    return Column(
      children: <Widget>[
        ListTile(
            title: Text(_globalVariables.city,
                style: TextStyle(
                  color: Colors.green.shade300,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            subtitle:
                Text(_globalVariables.trabzon, style: TextStyle(fontSize: 18))),
        Divider(),
        ListTile(
            title: Text(_globalVariables.creationDate,
                style: TextStyle(
                  color: Colors.green.shade300,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            subtitle: Text(
                _timeConverter.getDateAndTime(
                    _accountProvider.currentAccount.creationDate.toDate()),
                style: TextStyle(fontSize: 18))),
        Divider(),
        ListTile(
            title: Text(_globalVariables.totalUsedBag,
                style: TextStyle(
                  color: Colors.green.shade300,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            subtitle: Text(
                _accountProvider.currentAccount.totalUsedBag.toString(),
                style: TextStyle(fontSize: 18))),
        Divider(),
        ListTile(
            title: Text(_globalVariables.totalUsedBottom,
                style: TextStyle(
                  color: Colors.green.shade300,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            subtitle: Text(
                _accountProvider.currentAccount.totalUsedBottom.toString(),
                style: TextStyle(fontSize: 18))),
      ],
    );
  }

  Container buildContainerPoint() {
    return Container(child: buildDifferentOption());
  }

  Widget buildDifferentOption() {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Row(children: <Widget>[
        Expanded(
          child: Center(
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(_accountProvider.currentAccount.point.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.green,
                    )),
                Text(
                  _globalVariables.point,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(_accountProvider.currentAccount.totalDonate.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.green,
                    )),
                Text(
                  _globalVariables.totalDonate,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget get _donateButton => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _execDonateScreen,
          child: Card(
            color: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4.0,
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _globalVariables.donate,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(FontAwesomeIcons.donate,
                      size: 50, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );

  void _execDonateScreen() {
    Navigator.of(context).push(platformPageRoute(
        context: context, builder: (context) => DonateScreen()));
  }
}

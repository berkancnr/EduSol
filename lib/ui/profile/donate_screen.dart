import 'package:flutter/material.dart';
import 'package:edusol/core/constans/app/global_variables.dart';
import 'package:edusol/core/constans/locator.dart';
import 'package:edusol/viewmodels/recyclebox_provider.dart';
import 'package:provider/provider.dart';

class DonateScreen extends StatefulWidget {
  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  RecycleBoxProvider _boxProvider;
  final GlobalVariables _globalVariables = locator.get<GlobalVariables>();
  var selectedIndex = 0;

  Widget get _appBar => AppBar(
        title: Text(_globalVariables.donate),
      );

  @override
  Widget build(BuildContext context) {
    _boxProvider = Provider.of(context);
    return Scaffold(
      appBar: _appBar,
      body: GridView(
        children: _generateItems,
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: 1),
        scrollDirection: Axis.vertical,
      ),
    );
  }

  List<Widget> get _generateItems {
    var currentList = <Widget>[];
    var index = -1;
    var dList = _boxProvider.donateList();

    for (var item in dList) {
      index++;

      currentList.add(_singleCard(item, index));
    }

    return currentList;
  }

  Widget _singleCard(String url, int index) {
    var cardIndex = index;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        selectCard(cardIndex);
      },
      child: Card(
        elevation: cardIndex == selectedIndex ? 8 : 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            cardIndex == selectedIndex
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.4),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void selectCard(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:edusol/core/constans/app/global_variables.dart';
import 'package:edusol/core/constans/locator.dart';
import 'package:edusol/models/recycler_box.dart';
import 'package:edusol/viewmodels/account_provider.dart';
import 'package:edusol/viewmodels/recyclebox_provider.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with AutomaticKeepAliveClientMixin {
  AccountProvider _accountProvider;
  RecycleBoxProvider _recycleBoxProvider;
  final GlobalVariables _globalVariables = locator.get<GlobalVariables>();
  String _mapStyle;
  GoogleMapController _mapController;
  List<Marker> markers = [];

  Widget get _customAppBar => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  FontAwesomeIcons.qrcode,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _globalVariables.mAppBarText,
                  textAlign: TextAlign.center,
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: _signOut,
                  child: Icon(
                    FontAwesomeIcons.signOutAlt,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _accountProvider = Provider.of<AccountProvider>(context);
    _recycleBoxProvider = Provider.of<RecycleBoxProvider>(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          _gMap,
          Padding(
            padding: const EdgeInsets.only(top: 64.0, left: 16.0, right: 16.0),
            child: _customAppBar,
          ),
        ],
      ),
    );
  }

  Widget get _gMap => GoogleMap(
        myLocationButtonEnabled: false,
        compassEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: _getCurrentCamera(),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
          controller.setMapStyle(_mapStyle);
          _createMarketImageFromAsset();
        },
        markers: _getCurrentMarker(),
      );

  BitmapDescriptor recycleIcon;

  Future<void> _createMarketImageFromAsset() async {
    if (recycleIcon == null) {
      final imageConfiguration = createLocalImageConfiguration(context);
      var bitmap = await BitmapDescriptor.fromAssetImage(
          imageConfiguration, _globalVariables.recBoxIconPath);
      setState(() {
        recycleIcon = bitmap;
      });
    }
  }

  static final CameraPosition _sauLocation = CameraPosition(
    tilt: 90,
    target: LatLng(40.742037, 30.3305423),
    zoom: 16,
  );

  Set<Marker> _getCurrentMarker() {
    for (var cBox in _recycleBoxProvider.allBox) {
      markers.add(
        Marker(
            markerId: MarkerId(cBox.boxId),
            icon: recycleIcon,
            position: LatLng(cBox.geoPoint.latitude, cBox.geoPoint.longitude),
            onTap: () {
              showBoxInfo(cBox);
            }),
      );
    }
    print(markers.toSet());
    return markers.toSet();
  }

  CameraPosition _getCurrentCamera() {
    if (_accountProvider.currentAccount.geoPoint != null) {
      return CameraPosition(
        tilt: 90,
        target: LatLng(_accountProvider.currentAccount.geoPoint.latitude,
            _accountProvider.currentAccount.geoPoint.longitude),
        zoom: 14.0,
      );
    } else {
      return _sauLocation;
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void showBoxInfo(RecycleBox cBox) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: context,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  FontAwesomeIcons.recycle,
                  color: Colors.green,
                  size: 36,
                ),
              ),
              Text(cBox.boxId),
              SizedBox(
                height: 16,
              ),
              Image.asset(
                _globalVariables.recBoxIconPath,
                height: 75,
                width: 75,
              ),
              Text(_globalVariables.fulness),
              Text('%${cBox.fulness}'),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(EvaIcons.shoppingBag),
                          ),
                          Text(_globalVariables.bagCount),
                          Text('${cBox.bagCount}'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(FontAwesomeIcons.prescriptionBottle),
                          ),
                          Text(_globalVariables.bottleCount),
                          Text('${cBox.bottleCount}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: _execQRScreen,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 4.0,
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_globalVariables.takeBagorBottle),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            FontAwesomeIcons.qrcode,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void _execQRScreen() {
    /*
      QR Code Process
    */
  }

  void _signOut() async {
    var result = await _accountProvider.signOut();

    if (result != null && result) {
      Phoenix.rebirth(context);
    }
  }
}

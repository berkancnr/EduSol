import 'package:flutter/material.dart';
import 'package:edusol/models/recycler_box.dart';
import 'package:edusol/services/firestore_db_service.dart';

enum RecycleBoxState {
  Idle,
  Fetching,
  Updating,
  Creating,
  Logining,
  Registering,
  Logouting
}

class RecycleBoxProvider extends ChangeNotifier {
  List<RecycleBox> allBox;
  final FirestoreDbService _databaseRepository = FirestoreDbService();

  RecycleBoxState _state = RecycleBoxState.Idle;

  RecycleBoxState get state => _state;

  set state(RecycleBoxState cState) {
    _state = cState;
    notifyListeners();
  }

  RecycleBoxProvider() {
    fetchRecycleBox();
  }

  void fetchRecycleBox() {
    state = RecycleBoxState.Fetching;
    allBox = _databaseRepository.fetchRecycleBox();
    state = RecycleBoxState.Idle;
  }

  List<String> donateList() {
    var dList = _databaseRepository.getDonateList();
    return dList;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:edusol/models/account.dart';
import 'package:edusol/models/account_query.dart';
import 'package:edusol/services/firebase_auth_service.dart';
import 'package:edusol/services/firestore_db_service.dart';

enum AccountState {
  Idle,
  Fetching,
  Updating,
  Creating,
  Logining,
  Registering,
  Logouting
}

class AccountProvider extends ChangeNotifier {
  String currentUserId;
  Account _currentAccount;
  List<Account> allUsers = [];
  bool isSetupped = false;
  final FirebaseAuthService _authRepository = FirebaseAuthService();
  final FirestoreDbService _databaseRepository = FirestoreDbService();

  AccountState _state = AccountState.Idle;

  AccountState get state => _state;

  set state(AccountState cState) {
    _state = cState;
    notifyListeners();
  }

  Account get currentAccount => _currentAccount;

  set currentAccount(Account cAccount) {
    _currentAccount = cAccount;
    notifyListeners();
  }

  AccountProvider() {
    getCurrentUserId();
    fetchUsers();
  }

  void getCurrentUserId() {
    final uid = _authRepository.getCurrentUserId();
    currentUserId = uid;
  }

  Future<AccountQuery> createAccount(
      {String emailAddress, String password}) async {
    state = AccountState.Creating;
    var aQuery = await _authRepository.createAccount(
        email: emailAddress, password: password);

    if (aQuery.isSuccess) {
      currentUserId = aQuery.account.userId;

      var dQuery = await _databaseRepository.createUser(
          userId: aQuery.account.userId,
          email: emailAddress,
          password: password);

      if (dQuery.isSuccess) {
        state = AccountState.Idle;
        listenCurrentUser();
        return dQuery;
      } else {
        await _authRepository.deleteAuth(
            email: emailAddress, password: password);
        state = AccountState.Idle;
        return AccountQuery.failed(cErrorType: 0);
      }
    }
    state = AccountState.Idle;
    return aQuery;
  }

  Future<AccountQuery> signInWithEmailAndPassword(
      {String email, String password}) async {
    state = AccountState.Logining;
    var aQuery = await _authRepository.signInWithEmailAndPassword(
        email: email, password: password);

    if (aQuery.isSuccess) {
      currentUserId = aQuery.account.userId;

      var dQuery = await _databaseRepository.signIntoDatabase(
          userId: aQuery.account.userId, password: password);

      if (dQuery.isSuccess) {
        state = AccountState.Idle;
        listenCurrentUser();
        return dQuery;
      } else {
        await signOut();
        state = AccountState.Idle;
        return AccountQuery.failed(cErrorType: 0);
      }
    }
    state = AccountState.Idle;
    return aQuery;
  }

  void listenCurrentUser({Function() onComplated}) {
    _databaseRepository.listenAccount(
      userId: currentUserId,
      onChanged: (account) {
        if (account != null) {
          currentAccount = account;
          if (!isSetupped) {
            onComplated();
            isSetupped = true;
          }
        }
      },
    );
  }

  Future<bool> signOut() async {
    state = AccountState.Logouting;
    await _databaseRepository.stopListener();
    var logoutResult = await _authRepository.signOut();
    currentAccount = null;
    currentUserId = null;
    state = AccountState.Idle;
    return logoutResult;
  }

  Future<bool> updateAccountInfo(
      {String userId, Map<String, dynamic> latestInfos}) async {
    state = AccountState.Updating;
    var result = await _databaseRepository.updateAccountInfo(
        userId: userId, latestInfos: latestInfos);
    state = AccountState.Idle;
    return result;
  }

  Future<bool> updateInformations(
      {String userId,
      String name,
      String age,
      String job,
      String instagram,
      String twitter,
      String linkedin}) async {
    state = AccountState.Updating;
    var result = await _databaseRepository.updateInformations(
        userId: userId,
        name: name,
        age: age,
        job: job,
        instagram: instagram,
        twitter: twitter,
        linkedin: linkedin);
    state = AccountState.Idle;
    return result;
  }

  Future<bool> writeLog({String accountId, String log}) async {
    state = AccountState.Fetching;
    var result =
        await _databaseRepository.writeLog(accountId: accountId, log: log);
    state = AccountState.Idle;
    return result;
  }

  Future<List<Account>> getNearbyUsers(
      {String userId, GeoPoint geoPoint, int limit = 10}) async {
    state = AccountState.Fetching;
    var aList = _databaseRepository.getNearbyUsers(
        userId: userId, geoPoint: geoPoint, qLimit: limit);
    state = AccountState.Idle;
    return aList;
  }

  void fetchUsers() {
    state = AccountState.Fetching;
    var cList = _databaseRepository.fetchUsers();
    cList.sort((a, b) => b.point.compareTo(a.point));
    allUsers = cList;
    state = AccountState.Idle;
  }
}

import 'package:flutter_financekit/flutter_financekit_types.dart';
import 'package:flutter_financekit/src/extensions.dart';
import 'package:flutter_financekit/src/messages.g.dart';
import 'package:uuid/uuid.dart';

import 'flutter_financekit_platform_interface.dart';

/// An implementation of [FlutterFinanceKitPlatform] that uses method channels.
class MethodChannelFlutterFinanceKit implements FlutterFinanceKitPlatform {
  /// The method channel used to interact with the native platform.
  static final FinanceKitApi _api = FinanceKitApi();

  @override
  Future<bool> isDataAvailable(DataType type) async {
    return _api.isDataAvailable(type);
  }

  @override
  Future<AuthorizationStatus> authorizationStatus() async {
    return _api.authorizationStatus();
  }

  @override
  Future<AuthorizationStatus> requestAuthorization() async {
    return _api.requestAuthorization();
  }

  @override
  Future<Stream<Changes<AccountBalance>>> accountBalanceHistory(Uuid accountID,
      {HistoryToken? since, bool isMonitoring = true}) async {
    // TODO: implement accountBalanceHistory
    throw UnimplementedError();
  }

  @override
  Future<List<AccountBalance>> accountBalances(
      QueryParams<AccountBalance> query) async {
    // todo params
    return _api.accountBalances(ApiQueryParams()).then((value) {
      value.removeWhere((element) => element == null);
      return value.map<AccountBalance>((e) => e!).toList();
    });
  }

  @override
  Future<Stream<Changes<Account>>> accountHistory(
      {HistoryToken? since, bool isMonitoring = true}) async {
    // TODO: implement accountHistory
    throw UnimplementedError();
  }

  @override
  Future<List<Account>> accounts(QueryParams<Account> query) async {
    // todo query
    return _api.accounts(ApiQueryParams()).then((value) {
      value.removeWhere((element) => element == null);
      return value.map<Account>((e) => e!).toList();
    });
  }

  @override
  Future<Stream<Changes<Transaction>>> transactionHistory(Uuid accountID,
      {HistoryToken? since, bool isMonitoring = true}) async {
    // TODO: implement transactionHistory
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> transactions(QueryParams<Transaction> query) async {
    // todo query
    return _api.transactions(ApiQueryParams()).then((value) {
      value.removeWhere((e) => e == null);
      return value.map<Transaction>((e) => e!.convert()).toList();
    });
  }
}

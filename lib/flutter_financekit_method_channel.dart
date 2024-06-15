import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_financekit/flutter_financekit_types.dart';
import 'package:flutter_financekit/pigeon.dart';
import 'package:uuid/uuid.dart';

import 'flutter_financekit_platform_interface.dart';

/// An implementation of [FlutterFinanceKitPlatform] that uses method channels.
class MethodChannelFlutterFinanceKit implements FlutterFinanceKitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.dasbudget/flutter_financekit');

  @override
  Future<bool> isDataAvailable(DataType type) async {
    // TODO: implement isDataAvailable
    throw UnimplementedError();
  }

  @override
  Future<AuthorizationStatus> authorizationStatus() async {
    final status =
        await methodChannel.invokeMethod<String>('authorizationStatus');
    return AuthorizationStatus.values.byName(status!);
  }

  @override
  Future<AuthorizationStatus> requestAuthorization() async {
    final status =
        await methodChannel.invokeMethod<String>('requestAuthorization');
    return AuthorizationStatus.values.byName(status!);
  }

  @override
  Future<History<AccountBalance>> accountBalanceHistory(Uuid accountID,
      {HistoryToken? since, bool isMonitoring = true}) async {
    // TODO: implement accountBalanceHistory
    throw UnimplementedError();
  }

  @override
  Future<List<AccountBalance>> accountBalances(
      QueryParams<AccountBalance> query) async {
    // TODO: implement accountBalances
    throw UnimplementedError();
  }

  @override
  Future<History<Account>> accountHistory(
      {HistoryToken? since, bool isMonitoring = true}) async {
    // TODO: implement accountHistory
    throw UnimplementedError();
  }

  @override
  Future<List<Account>> accounts(QueryParams<Account> query) async {
    // TODO: implement accounts
    throw UnimplementedError();
  }

  @override
  Future<History<Transaction>> transactionHistory(Uuid accountID,
      {HistoryToken? since, bool isMonitoring = true}) async {
    // TODO: implement transactionHistory
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> transactions(QueryParams<Transaction> query) async {
    // TODO: implement transactions
    throw UnimplementedError();
  }
}

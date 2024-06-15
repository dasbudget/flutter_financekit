import 'package:flutter_financekit/flutter_financekit_method_channel.dart';
import 'package:flutter_financekit/flutter_financekit_platform_interface.dart';
import 'package:flutter_financekit/flutter_financekit_types.dart';
import 'package:flutter_financekit/pigeon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:uuid/uuid.dart';

class MockFlutterFinanceKitPlatform
    with MockPlatformInterfaceMixin
    implements FlutterFinanceKitPlatform {
  @override
  Future<AuthorizationStatus> authorizationStatus() {
    throw UnimplementedError();
  }

  @override
  Future<History<AccountBalance>> accountBalanceHistory(Uuid accountID,
      {HistoryToken? since, bool isMonitoring = true}) {
    throw UnimplementedError();
  }

  @override
  Future<List<AccountBalance>> accountBalances(
      QueryParams<AccountBalance> query) {
    throw UnimplementedError();
  }

  @override
  Future<List<Account>> accounts(QueryParams<Account> query) {
    throw UnimplementedError();
  }

  @override
  Future<AuthorizationStatus> requestAuthorization() {
    throw UnimplementedError();
  }

  @override
  Future<History<Transaction>> transactionHistory(Uuid accountID,
      {HistoryToken? since, bool isMonitoring = true}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> transactions(QueryParams<Transaction> query) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isDataAvailable(DataType type) {
    throw UnimplementedError();
  }

  @override
  Future<History<Account>> accountHistory(
      {HistoryToken? since, bool isMonitoring = true}) {
    throw UnimplementedError();
  }
}

void main() {
  final FlutterFinanceKitPlatform initialPlatform =
      FlutterFinanceKitPlatform.instance;

  test('$MethodChannelFlutterFinanceKit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterFinanceKit>());
  });

  test('currency', () async {
    expect(NumberFormat().simpleCurrencySymbol("USD"), '\$');
  });

  test('getPlatformVersion', () async {
    MockFlutterFinanceKitPlatform fakePlatform =
        MockFlutterFinanceKitPlatform();
    FlutterFinanceKitPlatform.instance = fakePlatform;
  });
}

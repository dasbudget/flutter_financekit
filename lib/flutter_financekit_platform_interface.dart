import 'package:flutter_financekit/flutter_financekit_types.dart';
import 'package:flutter_financekit/src/messages.g.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:uuid/uuid.dart';

import 'flutter_financekit_method_channel.dart';

abstract class FlutterFinanceKitPlatform extends PlatformInterface {
  /// Constructs a FlutterFinanceKitPlatform.
  FlutterFinanceKitPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterFinanceKitPlatform _instance = MethodChannelFlutterFinanceKit();

  /// The default instance of [FlutterFinanceKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterFinanceKit].
  static FlutterFinanceKitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterFinanceKitPlatform] when
  /// they register themselves.
  static set instance(FlutterFinanceKitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }


  Future<bool> isDataAvailable(DataType type) {
    return _instance.isDataAvailable(type);
  }

  Future<AuthorizationStatus> authorizationStatus() {
    return _instance.authorizationStatus();
  }

  Future<AuthorizationStatus> requestAuthorization() {
    return _instance.requestAuthorization();
  }

  Future<List<Account>> accounts(QueryParams<Account> query) {
    return _instance.accounts(query);
  }

  Future<Stream<Changes<Account>>> accountHistory({
    HistoryToken? since,
    bool isMonitoring = true,
  }) {
    return _instance.accountHistory(
      isMonitoring: isMonitoring,
    );
  }

  Future<List<AccountBalance>> accountBalances(
      QueryParams<AccountBalance> query) {
    return _instance.accountBalances(query);
  }

  Future<Stream<Changes<AccountBalance>>> accountBalanceHistory(
    Uuid accountID, {
    HistoryToken? since,
    bool isMonitoring = true,
  }) {
    return _instance.accountBalanceHistory(
      accountID,
      since: since,
      isMonitoring: isMonitoring,
    );
  }

  Future<Stream<Changes<Transaction>>> transactionHistory(
    Uuid accountID, {
    HistoryToken? since,
    bool isMonitoring = true,
  }) {
    return _instance.transactionHistory(
      accountID,
      since: since,
      isMonitoring: isMonitoring,
    );
  }

  Future<List<Transaction>> transactions(QueryParams<Transaction> query) {
    return _instance.transactions(query);
  }
}

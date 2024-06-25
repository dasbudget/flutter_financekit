import 'package:flutter/services.dart';
import 'package:flutter_financekit/flutter_financekit_types.dart';
import 'package:flutter_financekit/src/extensions.dart';
import 'package:flutter_financekit/src/messages.g.dart';

import 'flutter_financekit_platform_interface.dart';

/// An implementation of [FlutterFinanceKitPlatform] that uses method channels.
class MethodChannelFlutterFinanceKit implements FlutterFinanceKitPlatform {
  MethodChannelFlutterFinanceKit({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;

  /// The method channel used to interact with the native platform.
  static final FinanceKitApi _api = FinanceKitApi();
  final BinaryMessenger? _binaryMessenger;
  static const MethodCodec _channelCodec =
      StandardMethodCodec(FinanceKitApiCodec());

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
  Future<Stream<Changes<AccountBalance>>> accountBalanceHistory(ID accountID,
      {HistoryToken? since, bool isMonitoring = true}) async {
    String channelName = _channelName("accountBalanceHistory");
    final EventChannel channel = EventChannel(
      channelName,
      _channelCodec,
      _binaryMessenger,
    );

    Stream stream = channel.receiveBroadcastStream();

    return stream.map((replyList) {
      List<Object?>? obj = replyList[0] as List<Object?>?;
      List<ApiChanges>? ch = obj?.cast<ApiChanges>();
      return "" as Changes<AccountBalance>; // todo
    });
  }

  @override
  Future<List<AccountBalance>> accountBalances(
      QueryParams<AccountBalance> query) async {
    // todo params
    return _api.accountBalances(ApiQueryParams()).then((value) {
      value = List.from(value);
      value.removeWhere((element) => element == null);
      return filter(value.map<AccountBalance>((e) => e!.convert()).toList(), query.predicate);
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
      value = List.from(value);
      value.removeWhere((element) => element == null);
      return filter(value.map<Account>((e) => e!.convert()).toList(), query.predicate);
    });
  }

  @override
  Future<Stream<Changes<Transaction>>> transactionHistory(ID accountID,
      {HistoryToken? since, bool isMonitoring = true}) async {
    // TODO: implement transactionHistory
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> transactions(QueryParams<Transaction> query) async {
    // todo query
    return _api.transactions(ApiQueryParams()).then((value) {
      value = List.from(value);
      value.removeWhere((e) => e == null);
      return filter(value.map<Transaction>((e) => e!.convert()).toList(), query.predicate);
    });
  }

  String _channelName(String method) {
    return 'dev.flutter.pigeon.flutter_financekit.$method';
  }

  PlatformException _createConnectionError(String channelName) {
    return PlatformException(
      code: 'channel-error',
      message: 'Unable to establish connection on channel: "$channelName".',
    );
  }

  void _checkError(List<Object?>? replyList, String channelName) {
    if (replyList == null) {
      throw _createConnectionError(channelName);
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    }
  }
}

List<T> filter<T>(List<T> list, Predicate<T>? predicate) {
  print("filter ${list} ${predicate}");
  if (predicate == null) return list;

  list = List.from(list);
  list.retainWhere(predicate);
  return list;
}
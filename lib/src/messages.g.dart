// Autogenerated from Pigeon (v14.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

PlatformException _createConnectionError(String channelName) {
  return PlatformException(
    code: 'channel-error',
    message: 'Unable to establish connection on channel: "$channelName".',
  );
}

/// Values that describe the kinds of data in the finance store.
enum ApiDataType {
  /// The value that describes financial data, such as account information.
  financialData,
  /// The value that describes orders records, such as purchases.
  orders,
}

enum ApiAuthorizationStatus {
  /// A person authorized the app to use FinanceKit services.
  authorized,
  /// A person denied the use of FinanceKit services for the app
  denied,
  /// A person has not chosen whether the app can use FinanceKit services.
  notDetermined,
}

/// Values that describe kinds of transactions.
enum ApiTransactionType {
  /// A credit or debit adjustment transaction.
  adjustment,
  /// An ATM transaction.
  atm,
  /// A bill payment, usually carried out through an eBill or eCheck system.
  billPayment,
  /// A check payment.
  check,
  /// A deposit of money by a payer into a payee’s bank account.
  deposit,
  /// A payment to a third party on agreed dates, typically in order to pay bills.
  directDebit,
  /// A deposit of money by a payer directly into a payee’s bank account.
  directDeposit,
  /// A distribution of a company’s earnings to its shareholders.
  dividend,
  /// A fee or charge levied by the account provider.
  fee,
  /// A credit or debit due to interest earned or incurred.
  interest,
  /// A loan drawdown or repayment.
  loan,
  /// A Point of Sales transaction.
  pointOfSale,
  /// A refund.
  refund,
  /// A regular payment of a fixed amount that’s paid on a specified date.
  standingOrder,
  /// A transfer between accounts.
  transfer,
  /// The transaction’s category doesn’t map to a known value.
  unknown,
  /// An automatic or recurring withdrawal of funds by another party.
  withdrawal,
}

/// Values that describe the status of a transaction.
enum ApiTransactionStatus {
  /// The transaction is in an authorized state.
  authorized,
  /// The transaction is in a booked state.
  booked,
  /// A memo that provides information about the transaction.
  memo,
  /// The transaction is in a pending state.
  pending,
  /// The transaction is in a rejected state.
  rejected,
}

/// Values that the framework uses to describe transactions as credits or debits.
enum ApiCreditDebitIndicator {
  /// A value that indicates an amount which increases an asset or decreases a liability.
  credit,
  /// A value that indicates an amount which increases a liability or decreases an asset.
  debit,
}

enum ApiAccountType {
  /// An asset account.
  asset,
  /// A liability account.
  liability,
}

/// Values that describe the state of an account’s credit balance.
///
/// It can contain an indication of funds immediately available to the customer,
/// fund with all booked transactions (this excludes pending transactions), or both.
enum ApiCurrentBalance {
  /// Only the available balance is present.
  available,
  /// Both available and booked balances are present.
  availableAndBooked,
  /// Only the booked balance is present.
  booked,
}

class ApiPredicate {
  ApiPredicate({
    this.ids,
    this.minAmount,
    this.maxAmount,
    this.minTime,
    this.maxTime,
  });

  String? ids;

  int? minAmount;

  int? maxAmount;

  int? minTime;

  int? maxTime;

  Object encode() {
    return <Object?>[
      ids,
      minAmount,
      maxAmount,
      minTime,
      maxTime,
    ];
  }

  static ApiPredicate decode(Object result) {
    result as List<Object?>;
    return ApiPredicate(
      ids: result[0] as String?,
      minAmount: result[1] as int?,
      maxAmount: result[2] as int?,
      minTime: result[3] as int?,
      maxTime: result[4] as int?,
    );
  }
}

class ApiSortDescriptor {
  ApiSortDescriptor({
    this.id,
    this.date,
  });

  bool? id;

  bool? date;

  Object encode() {
    return <Object?>[
      id,
      date,
    ];
  }

  static ApiSortDescriptor decode(Object result) {
    result as List<Object?>;
    return ApiSortDescriptor(
      id: result[0] as bool?,
      date: result[1] as bool?,
    );
  }
}

class ApiQueryParams {
  ApiQueryParams({
    this.sortDescriptors,
    this.predicate,
    this.limit,
    this.offset,
  });

  List<ApiSortDescriptor?>? sortDescriptors;

  ApiPredicate? predicate;

  int? limit;

  int? offset;

  Object encode() {
    return <Object?>[
      sortDescriptors,
      predicate?.encode(),
      limit,
      offset,
    ];
  }

  static ApiQueryParams decode(Object result) {
    result as List<Object?>;
    return ApiQueryParams(
      sortDescriptors: (result[0] as List<Object?>?)?.cast<ApiSortDescriptor?>(),
      predicate: result[1] != null
          ? ApiPredicate.decode(result[1]! as List<Object?>)
          : null,
      limit: result[2] as int?,
      offset: result[3] as int?,
    );
  }
}

/// A structure that describes a monetary amount and its currency.
class ApiCurrencyAmount {
  ApiCurrencyAmount({
    required this.amount,
    required this.currencyCode,
  });

  /// The numeric value of the amount.
  String amount;

  /// The currency of the amount.
  String currencyCode;

  Object encode() {
    return <Object?>[
      amount,
      currencyCode,
    ];
  }

  static ApiCurrencyAmount decode(Object result) {
    result as List<Object?>;
    return ApiCurrencyAmount(
      amount: result[0]! as String,
      currencyCode: result[1]! as String,
    );
  }
}

/// A structure that represents a transaction relating to a specific financial account.
/// This can include transactions such as a deposit to or a withdrawn from bank account, a credit card transaction.
class ApiTransaction {
  ApiTransaction({
    required this.id,
    required this.accountID,
    required this.creditDebitIndicator,
    this.foreignCurrencyAmount,
    this.foreignCurrencyExchangeRate,
    this.merchantCategoryCode,
    this.merchantName,
    required this.originalTransactionDescription,
    this.postedDate,
    required this.status,
    required this.transactionAmount,
    required this.transactionDate,
    required this.transactionDescription,
    required this.transactionType,
  });

  /// A unique internal ID.
  String id;

  /// The account ID the transaction belongs to.
  String accountID;

  /// An indicator that describes if the transaction is a credit or a debit.
  ApiCreditDebitIndicator creditDebitIndicator;

  /// The total amount of the transaction, if it was carried out in a foreign currency.
  ApiCurrencyAmount? foreignCurrencyAmount;

  /// The currency exchange rate, if the transaction was carried out in a foreign currency.
  String? foreignCurrencyExchangeRate;

  /// The ISO 18245 category code for the transaction.
  int? merchantCategoryCode;

  /// The name of the merchant, if present.
  String? merchantName;

  /// The unmodified description of the transaction.
  String originalTransactionDescription;

  /// The date and time that the transaction was posted to the account.
  int? postedDate;

  /// The status of the transaction, if available.
  ApiTransactionStatus status;

  /// The total amount of the transaction.
  ApiCurrencyAmount transactionAmount;

  /// The time the transaction took place, if available.
  int transactionDate;

  /// A description of the transaction.
  String transactionDescription;

  /// The type of the transaction.
  ApiTransactionType transactionType;

  Object encode() {
    return <Object?>[
      id,
      accountID,
      creditDebitIndicator.index,
      foreignCurrencyAmount?.encode(),
      foreignCurrencyExchangeRate,
      merchantCategoryCode,
      merchantName,
      originalTransactionDescription,
      postedDate,
      status.index,
      transactionAmount.encode(),
      transactionDate,
      transactionDescription,
      transactionType.index,
    ];
  }

  static ApiTransaction decode(Object result) {
    result as List<Object?>;
    return ApiTransaction(
      id: result[0]! as String,
      accountID: result[1]! as String,
      creditDebitIndicator: ApiCreditDebitIndicator.values[result[2]! as int],
      foreignCurrencyAmount: result[3] != null
          ? ApiCurrencyAmount.decode(result[3]! as List<Object?>)
          : null,
      foreignCurrencyExchangeRate: result[4] as String?,
      merchantCategoryCode: result[5] as int?,
      merchantName: result[6] as String?,
      originalTransactionDescription: result[7]! as String,
      postedDate: result[8] as int?,
      status: ApiTransactionStatus.values[result[9]! as int],
      transactionAmount: ApiCurrencyAmount.decode(result[10]! as List<Object?>),
      transactionDate: result[11]! as int,
      transactionDescription: result[12]! as String,
      transactionType: ApiTransactionType.values[result[13]! as int],
    );
  }
}

/// A structure that describes the credit information associated with an account.
/// Credit information includes credit limits, payment dates, and minimum payment dates and amounts for current and upcoming payments.
class ApiAccountCreditInformation {
  ApiAccountCreditInformation({
    this.creditLimit,
    this.minimumNextPaymentAmount,
    this.nextPaymentDueDate,
    this.overduePaymentAmount,
  });

  /// The credit limit of the account.
  ApiCurrencyAmount? creditLimit;

  /// Minimum amount of the next non-overdue payment.
  ApiCurrencyAmount? minimumNextPaymentAmount;

  /// Date of the next payment.
  int? nextPaymentDueDate;

  /// The amount by which the account is overdue for the current period.
  ApiCurrencyAmount? overduePaymentAmount;

  Object encode() {
    return <Object?>[
      creditLimit?.encode(),
      minimumNextPaymentAmount?.encode(),
      nextPaymentDueDate,
      overduePaymentAmount?.encode(),
    ];
  }

  static ApiAccountCreditInformation decode(Object result) {
    result as List<Object?>;
    return ApiAccountCreditInformation(
      creditLimit: result[0] != null
          ? ApiCurrencyAmount.decode(result[0]! as List<Object?>)
          : null,
      minimumNextPaymentAmount: result[1] != null
          ? ApiCurrencyAmount.decode(result[1]! as List<Object?>)
          : null,
      nextPaymentDueDate: result[2] as int?,
      overduePaymentAmount: result[3] != null
          ? ApiCurrencyAmount.decode(result[3]! as List<Object?>)
          : null,
    );
  }
}

/// A structure that describes an account balance.
class ApiBalance {
  ApiBalance({
    required this.amount,
    required this.asOfDate,
    required this.creditDebitIndicator,
  });

  /// The amount of the balance.
  ApiCurrencyAmount amount;

  /// The date and time the system calculated the balance.
  int asOfDate;

  /// A value that indicates whether the balance is a credit or a debit balance.
  ApiCreditDebitIndicator creditDebitIndicator;

  Object encode() {
    return <Object?>[
      amount.encode(),
      asOfDate,
      creditDebitIndicator.index,
    ];
  }

  static ApiBalance decode(Object result) {
    result as List<Object?>;
    return ApiBalance(
      amount: ApiCurrencyAmount.decode(result[0]! as List<Object?>),
      asOfDate: result[1]! as int,
      creditDebitIndicator: ApiCreditDebitIndicator.values[result[2]! as int],
    );
  }
}

/// A structure that describes the financial balance of an account at a specific point in time.
class ApiAccountBalance {
  ApiAccountBalance({
    required this.accountID,
    this.available,
    this.booked,
    required this.currencyCode,
    required this.currentBalance,
    required this.id,
  });

  /// The account ID the balance belongs to.
  String accountID;

  /// The available balance, if present.
  ApiBalance? available;

  /// The booked balance, if present.
  ApiBalance? booked;

  /// The balance currency.
  String currencyCode;

  /// The balance at a particular moment in time.
  ApiCurrentBalance currentBalance;

  /// A unique account balance ID.
  String id;

  Object encode() {
    return <Object?>[
      accountID,
      available?.encode(),
      booked?.encode(),
      currencyCode,
      currentBalance.index,
      id,
    ];
  }

  static ApiAccountBalance decode(Object result) {
    result as List<Object?>;
    return ApiAccountBalance(
      accountID: result[0]! as String,
      available: result[1] != null
          ? ApiBalance.decode(result[1]! as List<Object?>)
          : null,
      booked: result[2] != null
          ? ApiBalance.decode(result[2]! as List<Object?>)
          : null,
      currencyCode: result[3]! as String,
      currentBalance: ApiCurrentBalance.values[result[4]! as int],
      id: result[5]! as String,
    );
  }
}

/// A structure that describes the characteristics of a liability account.
/// A liability account includes accounts such as credit cards.
class ApiLiabilityAccount {
  ApiLiabilityAccount({
    this.accountDescription,
    required this.creditInformation,
    required this.currencyCode,
    required this.displayName,
    required this.id,
    required this.institutionName,
    this.openingDate,
  });

  /// A description of the account.
  String? accountDescription;

  /// Information regarding credits to the account.
  ApiAccountCreditInformation creditInformation;

  /// An ISO 4217 currency code that identifies the currency in which the account is held.
  String currencyCode;

  /// The name for the account given by an individual.
  String displayName;

  /// A unique account ID.
  String id;

  /// The name of the institution that holds the account.
  String institutionName;

  /// The date the account was opened, if known.
  int? openingDate;

  Object encode() {
    return <Object?>[
      accountDescription,
      creditInformation.encode(),
      currencyCode,
      displayName,
      id,
      institutionName,
      openingDate,
    ];
  }

  static ApiLiabilityAccount decode(Object result) {
    result as List<Object?>;
    return ApiLiabilityAccount(
      accountDescription: result[0] as String?,
      creditInformation: ApiAccountCreditInformation.decode(result[1]! as List<Object?>),
      currencyCode: result[2]! as String,
      displayName: result[3]! as String,
      id: result[4]! as String,
      institutionName: result[5]! as String,
      openingDate: result[6] as int?,
    );
  }
}

/// A structure that describes the characteristics of an asset account.
/// An asset account includes accounts such as a bank account or a savings account.
class ApiAssetAccount {
  ApiAssetAccount({
    this.accountDescription,
    required this.currencyCode,
    required this.displayName,
    required this.id,
    required this.institutionName,
    this.openingDate,
  });

  /// The description of the account.
  String? accountDescription;

  /// ISO 4217 currency code that identifies the currency in which the account is held.
  String currencyCode;

  /// The name for the account given by a person.
  String displayName;

  /// A unique account identifier.
  String id;

  /// The name of the institution that holds the account.
  String institutionName;

  /// The date the account was opened, if known.
  int? openingDate;

  Object encode() {
    return <Object?>[
      accountDescription,
      currencyCode,
      displayName,
      id,
      institutionName,
      openingDate,
    ];
  }

  static ApiAssetAccount decode(Object result) {
    result as List<Object?>;
    return ApiAssetAccount(
      accountDescription: result[0] as String?,
      currencyCode: result[1]! as String,
      displayName: result[2]! as String,
      id: result[3]! as String,
      institutionName: result[4]! as String,
      openingDate: result[5] as int?,
    );
  }
}

/// A structure that describes a financial account.
/// Accounts can include a variety of financial account types such as a bank account, a credit card, or a college fund.
class ApiAccount {
  ApiAccount({
    required this.type,
    this.accountDescription,
    required this.currencyCode,
    required this.displayName,
    required this.id,
    required this.institutionName,
    this.openingDate,
    this.liabilityAccount,
    this.assetAccount,
  });

  ApiAccountType type;

  /// A person’s description of this account.
  String? accountDescription;

  /// The ISO 4217 currency code that identifies the currency that denominates the account.
  String currencyCode;

  /// The name for this account that a person provided.
  String displayName;

  /// The unique account ID for this account.
  String id;

  /// The name of the institution that holds this account.
  String institutionName;

  /// The date the account was opened, if known.
  int? openingDate;

  /// A liability account.
  ApiLiabilityAccount? liabilityAccount;

  /// An asset account.
  ApiAssetAccount? assetAccount;

  Object encode() {
    return <Object?>[
      type.index,
      accountDescription,
      currencyCode,
      displayName,
      id,
      institutionName,
      openingDate,
      liabilityAccount?.encode(),
      assetAccount?.encode(),
    ];
  }

  static ApiAccount decode(Object result) {
    result as List<Object?>;
    return ApiAccount(
      type: ApiAccountType.values[result[0]! as int],
      accountDescription: result[1] as String?,
      currencyCode: result[2]! as String,
      displayName: result[3]! as String,
      id: result[4]! as String,
      institutionName: result[5]! as String,
      openingDate: result[6] as int?,
      liabilityAccount: result[7] != null
          ? ApiLiabilityAccount.decode(result[7]! as List<Object?>)
          : null,
      assetAccount: result[8] != null
          ? ApiAssetAccount.decode(result[8]! as List<Object?>)
          : null,
    );
  }
}

class ApiHistoryToken {
  ApiHistoryToken({
    required this.test,
  });

  String test;

  Object encode() {
    return <Object?>[
      test,
    ];
  }

  static ApiHistoryToken decode(Object result) {
    result as List<Object?>;
    return ApiHistoryToken(
      test: result[0]! as String,
    );
  }
}

/// A structure that records changes to the finance store.
class ApiChanges {
  ApiChanges({
    required this.deleted,
    required this.inserted,
    required this.newToken,
    required this.updated,
  });

  /// An array of model objects identifiers that the framework deleted from the finance store.
  List<String?> deleted;

  /// An array of model objects the framework inserted into the finance store.
  List<String?> inserted;

  /// An updated history token.
  ApiHistoryToken newToken;

  /// An array of model objects that the framework updated in the finance store.
  List<String?> updated;

  Object encode() {
    return <Object?>[
      deleted,
      inserted,
      newToken.encode(),
      updated,
    ];
  }

  static ApiChanges decode(Object result) {
    result as List<Object?>;
    return ApiChanges(
      deleted: (result[0] as List<Object?>?)!.cast<String?>(),
      inserted: (result[1] as List<Object?>?)!.cast<String?>(),
      newToken: ApiHistoryToken.decode(result[2]! as List<Object?>),
      updated: (result[3] as List<Object?>?)!.cast<String?>(),
    );
  }
}

class FinanceKitApiCodec extends StandardMessageCodec {
  const FinanceKitApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is ApiAccount) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is ApiAccountBalance) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is ApiAccountCreditInformation) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is ApiAssetAccount) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is ApiBalance) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is ApiChanges) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is ApiCurrencyAmount) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else if (value is ApiCurrencyAmount) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else if (value is ApiHistoryToken) {
      buffer.putUint8(136);
      writeValue(buffer, value.encode());
    } else if (value is ApiLiabilityAccount) {
      buffer.putUint8(137);
      writeValue(buffer, value.encode());
    } else if (value is ApiPredicate) {
      buffer.putUint8(138);
      writeValue(buffer, value.encode());
    } else if (value is ApiQueryParams) {
      buffer.putUint8(139);
      writeValue(buffer, value.encode());
    } else if (value is ApiSortDescriptor) {
      buffer.putUint8(140);
      writeValue(buffer, value.encode());
    } else if (value is ApiTransaction) {
      buffer.putUint8(141);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return ApiAccount.decode(readValue(buffer)!);
      case 129: 
        return ApiAccountBalance.decode(readValue(buffer)!);
      case 130: 
        return ApiAccountCreditInformation.decode(readValue(buffer)!);
      case 131: 
        return ApiAssetAccount.decode(readValue(buffer)!);
      case 132: 
        return ApiBalance.decode(readValue(buffer)!);
      case 133: 
        return ApiChanges.decode(readValue(buffer)!);
      case 134: 
        return ApiCurrencyAmount.decode(readValue(buffer)!);
      case 135: 
        return ApiCurrencyAmount.decode(readValue(buffer)!);
      case 136: 
        return ApiHistoryToken.decode(readValue(buffer)!);
      case 137: 
        return ApiLiabilityAccount.decode(readValue(buffer)!);
      case 138: 
        return ApiPredicate.decode(readValue(buffer)!);
      case 139: 
        return ApiQueryParams.decode(readValue(buffer)!);
      case 140: 
        return ApiSortDescriptor.decode(readValue(buffer)!);
      case 141: 
        return ApiTransaction.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class FinanceKitApi {
  /// Constructor for [FinanceKitApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  FinanceKitApi({BinaryMessenger? binaryMessenger})
      : __pigeon_binaryMessenger = binaryMessenger;
  final BinaryMessenger? __pigeon_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec = FinanceKitApiCodec();

  Future<bool> isDataAvailable(ApiDataType type) async {
    const String __pigeon_channelName = 'dev.flutter.pigeon.flutter_financekit.FinanceKitApi.isDataAvailable';
    final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[type.index]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else if (__pigeon_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (__pigeon_replyList[0] as bool?)!;
    }
  }

  Future<ApiAuthorizationStatus> authorizationStatus() async {
    const String __pigeon_channelName = 'dev.flutter.pigeon.flutter_financekit.FinanceKitApi.authorizationStatus';
    final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(null) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else if (__pigeon_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return ApiAuthorizationStatus.values[__pigeon_replyList[0]! as int];
    }
  }

  Future<ApiAuthorizationStatus> requestAuthorization() async {
    const String __pigeon_channelName = 'dev.flutter.pigeon.flutter_financekit.FinanceKitApi.requestAuthorization';
    final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(null) as List<Object?>?;
    print("$__pigeon_replyList");
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else if (__pigeon_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return ApiAuthorizationStatus.values[__pigeon_replyList[0]! as int];
    }
  }

  Future<List<ApiAccount?>> accounts(ApiQueryParams query) async {
    const String __pigeon_channelName = 'dev.flutter.pigeon.flutter_financekit.FinanceKitApi.accounts';
    final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[query]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else if (__pigeon_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (__pigeon_replyList[0] as List<Object?>?)!.cast<ApiAccount?>();
    }
  }

  Future<List<ApiAccountBalance?>> accountBalances(ApiQueryParams query) async {
    const String __pigeon_channelName = 'dev.flutter.pigeon.flutter_financekit.FinanceKitApi.accountBalances';
    final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[query]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else if (__pigeon_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (__pigeon_replyList[0] as List<Object?>?)!.cast<ApiAccountBalance?>();
    }
  }

  Future<List<ApiTransaction?>> transactions(ApiQueryParams query) async {
    const String __pigeon_channelName = 'dev.flutter.pigeon.flutter_financekit.FinanceKitApi.transactions';
    final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[query]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else if (__pigeon_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (__pigeon_replyList[0] as List<Object?>?)!.cast<ApiTransaction?>();
    }
  }

  Future<List<ApiChanges?>> test() async {
    const String __pigeon_channelName = 'dev.flutter.pigeon.flutter_financekit.FinanceKitApi.test';
    final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(null) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else if (__pigeon_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (__pigeon_replyList[0] as List<Object?>?)!.cast<ApiChanges?>();
    }
  }
}

import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_financekit/src/messages.g.dart';

NumberFormat numberFormat = NumberFormat();

typedef Account = ApiAccount;
typedef TransactionStatus = ApiTransactionStatus;
typedef TransactionType = ApiTransactionType;
typedef AuthorizationStatus = ApiAuthorizationStatus;
typedef DataType = ApiDataType;

typedef SortDescriptor<T> = bool Function(T a, T b);
typedef Predicate<T> = bool Function(T t);

typedef ID = UuidValue;

class QueryParams<T> {
  List<SortDescriptor<T>>? sortDescriptors;
  Predicate<T>? predicate;

  int? limit;
  int? offset;

  QueryParams({
    this.sortDescriptors,
    this.predicate,
    this.limit,
    this.offset,
  });
}

// todo
class History<T> {}

// todo
class HistoryToken {}

typedef MerchantCategoryCode = int;

/// A structure that represents a transaction relating to a specific financial account.
/// This can include transactions such as a deposit to or a withdrawn from bank account, a credit card transaction.
class Transaction {
  /// A unique internal ID.
  ID id;

  /// The account ID the transaction belongs to.
  ID accountID;

  /// An indicator that describes if the transaction is a credit or a debit.
  CreditDebitIndicator creditDebitIndicator;

  /// The total amount of the transaction, if it was carried out in a foreign currency.
  CurrencyAmount? foreignCurrencyAmount;

  /// The currency exchange rate, if the transaction was carried out in a foreign currency.
  Decimal? foreignCurrencyExchangeRate;

  /// The ISO 18245 category code for the transaction.
  MerchantCategoryCode? merchantCategoryCode;

  /// The name of the merchant, if present.
  String? merchantName;

  /// The unmodified description of the transaction.
  String originalTransactionDescription;

  /// The date and time that the transaction was posted to the account.
  DateTime? postedDate;

  /// The status of the transaction, if available.
  TransactionStatus status;

  /// The total amount of the transaction.
  CurrencyAmount transactionAmount;

  /// The time the transaction took place, if available.
  DateTime transactionDate;

  /// A description of the transaction.
  String transactionDescription;

  /// The type of the transaction.
  TransactionType transactionType;

  Transaction({
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
}

/// A structure that describes a monetary amount and its currency.
class CurrencyAmount {
  /// The numeric value of the amount.
  Decimal amount;

  /// The currency of the amount.
  String currencyCode;

  CurrencyAmount(this.amount, this.currencyCode);

  String get currencySymbol => numberFormat.simpleCurrencySymbol(currencyCode);
}

/// A structure that records changes to the finance store.
class Changes<T> {
  /// An array of model objects identifiers that the framework deleted from the finance store.
  List<ID> deleted;

  /// An array of model objects the framework inserted into the finance store.
  List<T> inserted;

  /// An updated history token.
  HistoryToken newToken;

  /// An array of model objects that the framework updated in the finance store.
  List<T> updated;

  Changes({
    required this.deleted,
    required this.inserted,
    required this.newToken,
    required this.updated,
  });
}

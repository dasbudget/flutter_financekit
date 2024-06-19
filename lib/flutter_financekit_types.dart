import 'package:decimal/decimal.dart';
import 'package:flutter_financekit/src/extensions.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_financekit/src/messages.g.dart';

NumberFormat numberFormat = NumberFormat();

typedef TransactionStatus = ApiTransactionStatus;
typedef TransactionType = ApiTransactionType;
typedef AuthorizationStatus = ApiAuthorizationStatus;
typedef DataType = ApiDataType;
typedef CreditDebitIndicator = ApiCreditDebitIndicator;
typedef AccountType = ApiAccountType;
typedef CurrentBalance = ApiCurrentBalance;

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

/// A structure that describes an account balance.
class Balance {
  /// The amount of the balance.
  CurrencyAmount amount;

  /// The date and time the system calculated the balance.
  DateTime asOfDate;

  /// A value that indicates whether the balance is a credit or a debit balance.
  CreditDebitIndicator creditDebitIndicator;

  Balance({
    required this.amount,
    required this.asOfDate,
    required this.creditDebitIndicator,
  });
}

/// A structure that describes the financial balance of an account at a specific point in time.
class AccountBalance {
  /// The account ID the balance belongs to.
  ID accountID;

  /// The available balance, if present.
  Balance? available;

  /// The booked balance, if present.
  Balance? booked;

  /// The balance currency.
  String currencyCode;

  /// The balance at a particular moment in time.
  CurrentBalance currentBalance;

  /// A unique account balance ID.
  ID id;

  AccountBalance({
    required this.accountID,
    this.available,
    this.booked,
    required this.currencyCode,
    required this.currentBalance,
    required this.id,
  });
}

/// A structure that describes the credit information associated with an account.
/// Credit information includes credit limits, payment dates, and minimum payment dates and amounts for current and upcoming payments.
class AccountCreditInformation {
  /// The credit limit of the account.
  CurrencyAmount? creditLimit;

  /// Minimum amount of the next non-overdue payment.
  CurrencyAmount? minimumNextPaymentAmount;

  /// Date of the next payment.
  DateTime? nextPaymentDueDate;

  /// The amount by which the account is overdue for the current period.
  CurrencyAmount? overduePaymentAmount;

  AccountCreditInformation({
    this.creditLimit,
    this.minimumNextPaymentAmount,
    this.nextPaymentDueDate,
    this.overduePaymentAmount,
  });
}

/// A structure that describes the characteristics of a liability account.
/// A liability account includes accounts such as credit cards.
class LiabilityAccount {
  /// A description of the account.
  String? accountDescription;

  /// Information regarding credits to the account.
  AccountCreditInformation creditInformation;

  /// An ISO 4217 currency code that identifies the currency in which the account is held.
  String currencyCode;

  /// The name for the account given by an individual.
  String displayName;

  /// A unique account ID.
  ID id;

  /// The name of the institution that holds the account.
  String institutionName;

  /// The date the account was opened, if known.
  DateTime? openingDate;

  LiabilityAccount({
    this.accountDescription,
    required this.creditInformation,
    required this.currencyCode,
    required this.displayName,
    required this.id,
    required this.institutionName,
    this.openingDate,
  });
}

/// A structure that describes the characteristics of an asset account.
/// An asset account includes accounts such as a bank account or a savings account.
class AssetAccount {
  /// The description of the account.
  String? accountDescription;

  /// ISO 4217 currency code that identifies the currency in which the account is held.
  String currencyCode;

  /// The name for the account given by a person.
  String displayName;

  /// A unique account identifier.
  ID id;

  /// The name of the institution that holds the account.
  String institutionName;

  /// The date the account was opened, if known.
  DateTime? openingDate;

  AssetAccount({
    this.accountDescription,
    required this.currencyCode,
    required this.displayName,
    required this.id,
    required this.institutionName,
    this.openingDate,
  });
}

/// A structure that describes a financial account.
/// Accounts can include a variety of financial account types such as a bank account, a credit card, or a college fund.
class Account {
  AccountType type;

  /// A person’s description of this account.
  String? accountDescription;

  /// The ISO 4217 currency code that identifies the currency that denominates the account.
  String currencyCode;

  /// The name for this account that a person provided.
  String displayName;

  /// The unique account ID for this account.
  ID id;

  /// The name of the institution that holds this account.
  String institutionName;

  /// The date the account was opened, if known.
  DateTime? openingDate;

  /// A liability account.
  LiabilityAccount? liabilityAccount;

  /// An asset account.
  AssetAccount? assetAccount;

  Account({
    this.accountDescription,
    required this.currencyCode,
    required this.displayName,
    required this.id,
    required this.institutionName,
    this.openingDate,
    required this.type,
    this.liabilityAccount,
    this.assetAccount,
  });
}

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

  String format() {
    return "$currencySymbol${amount.toStringAsFixed(2)}";
  }
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

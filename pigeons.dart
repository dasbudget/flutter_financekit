import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  dartOptions: DartOptions(),
  kotlinOut:
      'android/src/main/kotlin/com/dasbudget/flutter_financekit/Messages.g.kt',
  kotlinOptions: KotlinOptions(package: "com.dasbudget.flutter_financeKit"),
  swiftOut: 'ios/Classes/Messages.g.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'flutter_financekit',
))

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

class ApiPredicate {
  String? ids;
  int? minAmount;
  int? maxAmount;
  int? minTime;
  int? maxTime;

  ApiPredicate({
    this.ids,
    this.minAmount,
    this.maxAmount,
    this.minTime,
    this.maxTime,
  });
}

class ApiSortDescriptor {
  bool? id;
  bool? date;

  ApiSortDescriptor({
    this.id,
    this.date,
  });
}

class ApiQueryParams {
  // todo
  List<ApiSortDescriptor?>? sortDescriptors;
  ApiPredicate? predicate;

  int? limit;
  int? offset;

  ApiQueryParams({
    this.sortDescriptors,
    this.predicate,
    this.limit,
    this.offset,
  });
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

// typedef MerchantCategoryCode = int;

/// A structure that describes a monetary amount and its currency.
class ApiCurrencyAmount {
  /// The numeric value of the amount.
  String amount;

  /// The currency of the amount.
  String currencyCode;

  ApiCurrencyAmount(this.amount, this.currencyCode);
}

/// A structure that represents a transaction relating to a specific financial account.
/// This can include transactions such as a deposit to or a withdrawn from bank account, a credit card transaction.
class ApiTransaction {
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
}

enum ApiAccountType {
  /// An asset account.
  asset,

  /// A liability account.
  liability,
}

/// A structure that describes the credit information associated with an account.
/// Credit information includes credit limits, payment dates, and minimum payment dates and amounts for current and upcoming payments.
class ApiAccountCreditInformation {
  /// The credit limit of the account.
  ApiCurrencyAmount? creditLimit;

  /// Minimum amount of the next non-overdue payment.
  ApiCurrencyAmount? minimumNextPaymentAmount;

  /// Date of the next payment.
  int? nextPaymentDueDate;

  /// The amount by which the account is overdue for the current period.
  ApiCurrencyAmount? overduePaymentAmount;

  ApiAccountCreditInformation({
    this.creditLimit,
    this.minimumNextPaymentAmount,
    this.nextPaymentDueDate,
    this.overduePaymentAmount,
  });
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

/// A structure that describes an account balance.
class ApiBalance {
  /// The amount of the balance.
  ApiCurrencyAmount amount;

  /// The date and time the system calculated the balance.
  int asOfDate;

  /// A value that indicates whether the balance is a credit or a debit balance.
  ApiCreditDebitIndicator creditDebitIndicator;

  ApiBalance({
    required this.amount,
    required this.asOfDate,
    required this.creditDebitIndicator,
  });
}

/// A structure that describes the financial balance of an account at a specific point in time.
class ApiAccountBalance {
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

  ApiAccountBalance({
    required this.accountID,
    this.available,
    this.booked,
    required this.currencyCode,
    required this.currentBalance,
    required this.id,
  });
}

/// A structure that describes the characteristics of a liability account.
/// A liability account includes accounts such as credit cards.
class ApiLiabilityAccount {
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

  ApiLiabilityAccount({
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
class ApiAssetAccount {
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

  ApiAssetAccount({
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
class ApiAccount {
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

  ApiAccount({
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

// todo
class ApiHistoryToken {}

/// A structure that records changes to the finance store.
class ApiChanges {
  /// An array of model objects identifiers that the framework deleted from the finance store.
  List<String?> deleted;

  /// An array of model objects the framework inserted into the finance store.
  List<dynamic?> inserted;

  /// An updated history token.
  ApiHistoryToken newToken;

  /// An array of model objects that the framework updated in the finance store.
  List<dynamic?> updated;

  ApiChanges({
    required this.deleted,
    required this.inserted,
    required this.newToken,
    required this.updated,
  });
}


@HostApi()
abstract class FinanceKitApi {
  bool isDataAvailable(ApiDataType type);

  @async
  ApiAuthorizationStatus authorizationStatus();

  @async
  ApiAuthorizationStatus requestAuthorization();

  @async
  List<ApiAccount> accounts(ApiQueryParams query);

  @async
  List<ApiAccountBalance> accountBalances(ApiQueryParams query);

  @async
  List<ApiTransaction> transactions(ApiQueryParams query);


  List<ApiChanges> test();

// History<Account> accountHistory({
//   HistoryToken? since,
//   bool isMonitoring = true,
// });

// History<AccountBalance> accountBalanceHistory(
//   Uuid accountID, {
//   HistoryToken? since,
//   bool isMonitoring = true,
// });
//
// History<Transaction> transactionHistory(
//   Uuid accountID, {
//   HistoryToken? since,
//   bool isMonitoring = true,
// });
}

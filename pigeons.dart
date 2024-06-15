import 'package:pigeon/pigeon.dart';

/// Values that describe the kinds of data in the finance store.
enum DataType {
  /// The value that describes financial data, such as account information.
  financialData,

  /// The value that describes orders records, such as purchases.
  orders,
}

// NumberFormat numberFormat = NumberFormat();
//
// typedef SortDescriptor<T> = bool Function(T t);
// typedef Predicate<T> = bool Function(T t);
//
// class QueryParams<T> {
//   // todo
//   List<SortDescriptor<T>>? sortDescriptors;
//   Predicate<T>? predicate;
//
//   int? limit;
//   int? offset;
//
//   QueryParams({
//     this.sortDescriptors,
//     this.predicate,
//     this.limit,
//     this.offset,
//   });
// }
//
// // todo
// class History<T> {}
//
// // todo
// class HistoryToken {}

// /// Values that describe kinds of transactions.
// enum TransactionType {
//   /// A credit or debit adjustment transaction.
//   adjustment,
//
//   /// An ATM transaction.
//   atm,
//
//   /// A bill payment, usually carried out through an eBill or eCheck system.
//   billPayment,
//
//   /// A check payment.
//   check,
//
//   /// A deposit of money by a payer into a payee’s bank account.
//   deposit,
//
//   /// A payment to a third party on agreed dates, typically in order to pay bills.
//   directDebit,
//
//   /// A deposit of money by a payer directly into a payee’s bank account.
//   directDeposit,
//
//   /// A distribution of a company’s earnings to its shareholders.
//   dividend,
//
//   /// A fee or charge levied by the account provider.
//   fee,
//
//   /// A credit or debit due to interest earned or incurred.
//   interest,
//
//   /// A loan drawdown or repayment.
//   loan,
//
//   /// A Point of Sales transaction.
//   pointOfSale,
//
//   /// A refund.
//   refund,
//
//   /// A regular payment of a fixed amount that’s paid on a specified date.
//   standingOrder,
//
//   /// A transfer between accounts.
//   transfer,
//
//   /// The transaction’s category doesn’t map to a known value.
//   unknown,
//
//   /// An automatic or recurring withdrawal of funds by another party.
//   withdrawal,
// }
//
// /// Values that describe the status of a transaction.
// enum TransactionStatus {
//   /// The transaction is in an authorized state.
//   authorized,
//
//   /// The transaction is in a booked state.
//   booked,
//
//   /// A memo that provides information about the transaction.
//   memo,
//
//   /// The transaction is in a pending state.
//   pending,
//
//   /// The transaction is in a rejected state.
//   rejected,
// }
//
// /// Values that the framework uses to describe transactions as credits or debits.
// enum CreditDebitIndicator {
//   /// A value that indicates an amount which increases an asset or decreases a liability.
//   credit,
//
//   /// A value that indicates an amount which increases a liability or decreases an asset.
//   debit,
// }
//
// typedef MerchantCategoryCode = int;
//
// /// A structure that describes a monetary amount and its currency.
// class CurrencyAmount {
//   /// The numeric value of the amount.
//   Decimal amount;
//
//   /// The currency of the amount.
//   String currencyCode;
//
//   CurrencyAmount(this.amount, this.currencyCode);
//
//   String get currencySymbol => numberFormat.simpleCurrencySymbol(currencyCode);
// }
//
// /// A structure that represents a transaction relating to a specific financial account.
// /// This can include transactions such as a deposit to or a withdrawn from bank account, a credit card transaction.
// class Transaction {
//   /// A unique internal ID.
//   Uuid id;
//
//   /// The account ID the transaction belongs to.
//   Uuid accountID;
//
//   /// An indicator that describes if the transaction is a credit or a debit.
//   CreditDebitIndicator creditDebitIndicator;
//
//   /// The total amount of the transaction, if it was carried out in a foreign currency.
//   CurrencyAmount? foreignCurrencyAmount;
//
//   /// The currency exchange rate, if the transaction was carried out in a foreign currency.
//   Decimal? foreignCurrencyExchangeRate;
//
//   /// The ISO 18245 category code for the transaction.
//   MerchantCategoryCode? merchantCategoryCode;
//
//   /// The name of the merchant, if present.
//   String? merchantName;
//
//   /// The unmodified description of the transaction.
//   String originalTransactionDescription;
//
//   /// The date and time that the transaction was posted to the account.
//   DateTime? postedDate;
//
//   /// The status of the transaction, if available.
//   TransactionStatus status;
//
//   /// The total amount of the transaction.
//   CurrencyAmount transactionAmount;
//
//   /// The time the transaction took place, if available.
//   DateTime transactionDate;
//
//   /// A description of the transaction.
//   String transactionDescription;
//
//   /// The type of the transaction.
//   TransactionType transactionType;
//
//   Transaction({
//     required this.id,
//     required this.accountID,
//     required this.creditDebitIndicator,
//     this.foreignCurrencyAmount,
//     this.foreignCurrencyExchangeRate,
//     this.merchantCategoryCode,
//     this.merchantName,
//     required this.originalTransactionDescription,
//     this.postedDate,
//     required this.status,
//     required this.transactionAmount,
//     required this.transactionDate,
//     required this.transactionDescription,
//     required this.transactionType,
//   });
// }
//
// enum AccountType {
//   /// An asset account.
//   asset,
//
//   /// A liability account.
//   liability,
// }
//
// /// A structure that describes the credit information associated with an account.
// /// Credit information includes credit limits, payment dates, and minimum payment dates and amounts for current and upcoming payments.
// class AccountCreditInformation {
//   /// The credit limit of the account.
//   CurrencyAmount? creditLimit;
//
//   /// Minimum amount of the next non-overdue payment.
//   CurrencyAmount? minimumNextPaymentAmount;
//
//   /// Date of the next payment.
//   DateTime? nextPaymentDueDate;
//
//   /// The amount by which the account is overdue for the current period.
//   CurrencyAmount? overduePaymentAmount;
//
//   AccountCreditInformation({
//     this.creditLimit,
//     this.minimumNextPaymentAmount,
//     this.nextPaymentDueDate,
//     this.overduePaymentAmount,
//   });
// }
//
// /// Values that describe the state of an account’s credit balance.
// ///
// /// It can contain an indication of funds immediately available to the customer,
// /// fund with all booked transactions (this excludes pending transactions), or both.
// enum CurrentBalance {
//   /// Only the available balance is present.
//   available,
//
//   /// Both available and booked balances are present.
//   availableAndBooked,
//
//   /// Only the booked balance is present.
//   booked,
// }
//
// /// A structure that describes an account balance.
// class Balance {
//   /// The amount of the balance.
//   CurrencyAmount amount;
//
//   /// The date and time the system calculated the balance.
//   DateTime asOfDate;
//
//   /// A value that indicates whether the balance is a credit or a debit balance.
//   CreditDebitIndicator creditDebitIndicator;
//
//   Balance({
//     required this.amount,
//     required this.asOfDate,
//     required this.creditDebitIndicator,
//   });
// }
//
// /// A structure that describes the financial balance of an account at a specific point in time.
// class AccountBalance {
//   /// The account ID the balance belongs to.
//   Uuid accountID;
//
//   /// The available balance, if present.
//   Balance? available;
//
//   /// The booked balance, if present.
//   Balance? booked;
//
//   /// The balance currency.
//   String currencyCode;
//
//   /// The balance at a particular moment in time.
//   CurrentBalance currentBalance;
//
//   /// A unique account balance ID.
//   Uuid id;
//
//   AccountBalance({
//     required this.accountID,
//     this.available,
//     this.booked,
//     required this.currencyCode,
//     required this.currentBalance,
//     required this.id,
//   });
// }
//
// /// A structure that describes the characteristics of a liability account.
// /// A liability account includes accounts such as credit cards.
// class LiabilityAccount {
//   /// A description of the account.
//   String? accountDescription;
//
//   /// Information regarding credits to the account.
//   AccountCreditInformation creditInformation;
//
//   /// An ISO 4217 currency code that identifies the currency in which the account is held.
//   String currencyCode;
//
//   /// The name for the account given by an individual.
//   String displayName;
//
//   /// A unique account ID.
//   Uuid id;
//
//   /// The name of the institution that holds the account.
//   String institutionName;
//
//   /// The date the account was opened, if known.
//   DateTime? openingDate;
//
//   LiabilityAccount({
//     this.accountDescription,
//     required this.creditInformation,
//     required this.currencyCode,
//     required this.displayName,
//     required this.id,
//     required this.institutionName,
//     this.openingDate,
//   });
// }
//
// /// A structure that describes the characteristics of an asset account.
// /// An asset account includes accounts such as a bank account or a savings account.
// class AssetAccount {
//   /// The description of the account.
//   String? accountDescription;
//
//   /// ISO 4217 currency code that identifies the currency in which the account is held.
//   String currencyCode;
//
//   /// The name for the account given by a person.
//   String displayName;
//
//   /// A unique account identifier.
//   Uuid id;
//
//   /// The name of the institution that holds the account.
//   String institutionName;
//
//   /// The date the account was opened, if known.
//   DateTime? openingDate;
//
//   AssetAccount({
//     this.accountDescription,
//     required this.currencyCode,
//     required this.displayName,
//     required this.id,
//     required this.institutionName,
//     this.openingDate,
//   });
// }
//
// /// A structure that describes a financial account.
// /// Accounts can include a variety of financial account types such as a bank account, a credit card, or a college fund.
// class Account {
//   AccountType type;
//
//   /// A person’s description of this account.
//   String? accountDescription;
//
//   /// The ISO 4217 currency code that identifies the currency that denominates the account.
//   String currencyCode;
//
//   /// The name for this account that a person provided.
//   String displayName;
//
//   /// The unique account ID for this account.
//   Uuid id;
//
//   /// The name of the institution that holds this account.
//   String institutionName;
//
//   /// The date the account was opened, if known.
//   DateTime? openingDate;
//
//   /// A liability account.
//   LiabilityAccount? liabilityAccount;
//
//   /// An asset account.
//   AssetAccount? assetAccount;
//
//   Account({
//     this.accountDescription,
//     required this.currencyCode,
//     required this.displayName,
//     required this.id,
//     required this.institutionName,
//     this.openingDate,
//     required this.type,
//     this.liabilityAccount,
//     this.assetAccount,
//   });
// }

@HostApi()
abstract class FinanceKitApi {
  bool isDataAvailable(DataType type);

  String authorizationStatus();
  //
  // AuthorizationStatus requestAuthorization();
  //
  // List<Account> accounts(QueryParams<Account> query);
  //
  // History<Account> accountHistory({
  //   HistoryToken? since,
  //   bool isMonitoring = true,
  // });
  //
  // List<AccountBalance> accountBalances(QueryParams<AccountBalance> query);
  //
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
  //
  // List<Transaction> transactions(QueryParams<Transaction> query);
}



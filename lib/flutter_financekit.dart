import 'package:flutter_financekit/flutter_financekit_types.dart';
import 'flutter_financekit_platform_interface.dart';

export 'package:flutter_financekit/extensions.dart';

/// Access financial data and interact with Apple Card, Apple Cash, and orders in Wallet.
/// Use FinanceKit to access on-device financial data, Apple Cash, and interact with orders in Apple Wallet.
///
/// Using the FinanceKit framework, you can:
///
/// Access on-device financial data.
/// Add, update, store, and interact with orders in Wallet.
/// Interact with Apple Card and Apple Cash.
///
/// To access someone’s financial data, you must meet the criteria outlined in
/// Get started with FinanceKit, request the FinanceKit managed entitlement,
/// hold an organization-level Apple Developer account, be logged in as
/// Account Holder, and include the [NSFinancialDataDescription] string in your
/// Info.plist. Apple reviews each application using defined criteria.
///
/// If your request meets the criteria, Apple adds the entitlement to your
/// developer account by using managed capabilities. To request access, see
/// the FinanceKit managed entitlement request form. For more information
/// about managed entitlements, see Provisioning with capabilities.
class FinanceKit {
  ///
  /// Authorization
  ///

  /// Returns a Boolean value that indicates if data that represents the
  /// provided type is available in the finance store.
  static Future<bool> isDataAvailable(DataType type) {
    return FlutterFinanceKitPlatform.instance.isDataAvailable(type);
  }

  /// Checks the authorization status for the calling application.
  static Future<AuthorizationStatus> authorizationStatus() {
    return FlutterFinanceKitPlatform.instance.authorizationStatus();
  }

  /// Prompts a person to give FinanceKit authorization to access financial data.
  ///
  /// If there are no accounts are available to display, the framework presents
  /// a “No Accounts” screen and returns a status of AuthorizationStatus.authorized
  /// or AuthorizationStatus.denied depending on the state of a person’s consent.
  ///
  /// It’s safe to call this method multiple times; the framework prompts a
  /// person only if necessary.
  static Future<AuthorizationStatus> requestAuthorization() {
    return FlutterFinanceKitPlatform.instance.requestAuthorization();
  }

  ///
  /// Account
  ///

  /// Returns a list of accounts a person added to their Wallet that meet the
  /// criteria in the provided account query.
  static Future<List<Account>> accounts(QueryParams<Account> query) {
    return FlutterFinanceKitPlatform.instance.accounts(query);
  }

  /// Returns a list of accounts a person added since a time specified by the
  /// provided financial history token.
  ///
  /// Use this method to list and monitor accounts present in a person’s Wallet.
  /// If provided, the framework uses the since history token as a starting
  /// point to evaluate which accounts to return.
  ///
  /// [isMonitoring] - indicates if the framework should return a History that
  /// indicates the changes to the accounts over time. Defaults to true.
  static Future<Stream<Changes<Account>>> accountHistory({
    HistoryToken? since,
    bool isMonitoring = true,
  }) {
    return FlutterFinanceKitPlatform.instance.accountHistory(
      since: since,
      isMonitoring: isMonitoring,
    );
  }

  ///
  /// Balances
  ///

  /// Returns a list of balances that meet the criteria in the provided account query.
  static Future<List<AccountBalance>> accountBalances(
      QueryParams<AccountBalance> query) {
    return FlutterFinanceKitPlatform.instance.accountBalances(query);
  }

  /// Returns the account balance history since a time specified by the provided financial history token.
  static Future<Stream<Changes<AccountBalance>>> accountBalanceHistory(
    ID accountID, {
    HistoryToken? since,
    bool isMonitoring = true,
  }) {
    return FlutterFinanceKitPlatform.instance.accountBalanceHistory(
      accountID,
      since: since,
      isMonitoring: isMonitoring,
    );
  }

  ///
  /// Transactions
  ///

  /// Returns the transactions for the specified account ID, optional starting time,
  /// and monitoring indicator for long running transaction queries.
  ///
  /// Use this method to search the finance store for transactions in a
  /// specific account and receive updates as the framework enters new
  /// transactions into the finance store. You can, optionally, specify a
  /// starting date and time by providing a historyToken.
  static Future<Stream<Changes<Transaction>>> transactionHistory(
    ID accountID, {
    HistoryToken? since,
    bool isMonitoring = true,
  }) {
    return FlutterFinanceKitPlatform.instance.transactionHistory(
      accountID,
      since: since,
      isMonitoring: isMonitoring,
    );
  }

  /// Returns transactions that match the provided transaction query.
  static Future<List<Transaction>> transactions(
      QueryParams<Transaction> query) {
    return FlutterFinanceKitPlatform.instance.transactions(query);
  }
}

import 'package:decimal/decimal.dart';
import 'package:flutter_financekit/flutter_financekit_types.dart';
import 'package:flutter_financekit/src/messages.g.dart';
import 'package:uuid/uuid.dart';

extension AccountPredicates on Account {
  static Predicate<Account> byAccountIDs(List<String> accountIDs) {
    return (t) => accountIDs.contains(t.id);
  }

  static Predicate<Account> byTypes(List<AccountType> types) {
    return (t) => types.contains(t.type);
  }
}

extension StringExts on String {
  ID get toUuid => ID.fromString(this);

  static Predicate<Account> byTypes(List<AccountType> types) {
    return (t) => types.contains(t.type);
  }
}

extension TransactionPredicates on Transaction {
  static Predicate<Transaction> byID(List<ID> transactionIDs) {
    return (t) => transactionIDs.contains(t.id);
  }

  static Predicate<Transaction> byAccountID(List<ID> accountIDs) {
    return (t) => accountIDs.contains(t.accountID);
  }

  static Predicate<Transaction> byTransactionDate(
      {DateTime? start, DateTime? end}) {
    return (t) {
      if (start == null && end == null) return true;

      bool startMatches = true;
      if (start != null) {
        startMatches &=
            (t.transactionDate.isAfter(start) || t.transactionDate == start);
      }

      bool endMatches = true;
      if (end != null) {
        endMatches &=
            (t.transactionDate.isBefore(end) || t.transactionDate == end);
      }

      return startMatches && endMatches;
    };
  }
}

extension ApiCurrencyAmountExtensions on ApiCurrencyAmount {
  CurrencyAmount convert() {
    return CurrencyAmount(Decimal.parse(amount), currencyCode);
  }
}

extension ApiAccBal on ApiAccountBalance {
  AccountBalance convert() {
    return AccountBalance(
      accountID: accountID.toUuid,
      currencyCode: currencyCode,
      currentBalance: currentBalance,
      id: id.toUuid,
    );
  }
}

extension ApiAcc on ApiAccount {
  Account convert() {
    return Account(
      currencyCode: currencyCode,
      displayName: displayName,
      id: id.toUuid,
      institutionName: institutionName,
      type: type,
    );
  }
}

extension ApiTx on ApiTransaction {
  Transaction convert() {
    return Transaction(
      id: UuidValue.fromString(id),
      accountID: UuidValue.fromString(accountID),
      creditDebitIndicator: creditDebitIndicator,
      originalTransactionDescription: originalTransactionDescription,
      status: status,
      transactionAmount: transactionAmount.convert(),
      transactionDate: DateTime.fromMillisecondsSinceEpoch(transactionDate),
      transactionDescription: transactionDescription,
      transactionType: transactionType,
      foreignCurrencyAmount: foreignCurrencyAmount?.convert(),
      foreignCurrencyExchangeRate: (foreignCurrencyExchangeRate != null)
          ? Decimal.parse(foreignCurrencyExchangeRate!)
          : null,
      merchantCategoryCode: merchantCategoryCode,
      merchantName: merchantName,
      postedDate: (postedDate != null)
          ? DateTime.fromMillisecondsSinceEpoch(postedDate!)
          : null,
    );
  }
}

import 'package:decimal/decimal.dart';
import 'package:flutter_financekit/flutter_financekit_types.dart';
import 'package:flutter_financekit/src/messages.g.dart';

extension StringExts on String {
  ID get toUuid => ID.fromString(this);
}

extension DecimalExts on Decimal {
  Decimal get invert => this * Decimal.fromInt(-1);
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
      available: available?.convert(),
      booked: booked?.convert(),
    );
  }
}

extension ApiBalanceExt on ApiBalance {
  Balance convert() {
    return Balance(
      amount: amount.convert(),
      asOfDate: DateTime.fromMillisecondsSinceEpoch(asOfDate),
      creditDebitIndicator: creditDebitIndicator,
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

extension ApiHistoryTokenExt on ApiHistoryToken {
  HistoryToken convert() {
    return HistoryToken();
  }
}

extension ApiTx on ApiTransaction {
  Transaction convert() {
    return Transaction(
      id: id.toUuid,
      accountID: accountID.toUuid,
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

import 'package:flutter_financekit/flutter_financekit_types.dart';

extension AccountPredicates on Account {
  static Predicate<Account> byAccountIDs(List<ID> accountIDs) {
    return (t) => accountIDs.contains(t.id);
  }

  static Predicate<Account> byTypes(List<AccountType> types) {
    return (t) => types.contains(t.type);
  }
}


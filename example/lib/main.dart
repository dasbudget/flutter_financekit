import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_financekit/flutter_financekit.dart';
import 'package:flutter_financekit/flutter_financekit_types.dart';
import 'package:flutter_financekit/extensions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _authStatus = AuthorizationStatus.notDetermined.name;
  bool _dataAvail = false;
  List<Account> _accs = [];
  final Map<ID, List<Transaction>> _txs = {};
  final Map<ID, AccountBalance> _balances = {};

  @override
  void initState() {
    super.initState();
    get();
  }

  Future<void> get() async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildDataAvail(),
              buildAuth(),
              buildAccounts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDataAvail() {
    return Column(
      children: [
        Text(
          'FinanceKit Data Available\n$_dataAvail',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
            child: const Text("Check"),
            onPressed: () {
              FinanceKit.isDataAvailable(DataType.financialData).then(
                (value) => {
                  setState(() {
                    _dataAvail = value;
                  })
                },
              );
            })
      ],
    );
  }

  Widget buildAuth() {
    return Column(
      children: [
        Text('FinanceKit Auth Status\n$_authStatus',
            textAlign: TextAlign.center),
        ElevatedButton(
            child: const Text("Request"),
            onPressed: () {
              FinanceKit.requestAuthorization().then((status) => {
                    setState(() {
                      _authStatus = "req ${status.name}";
                    })
                  });
            })
      ],
    );
  }

  Widget buildAccounts() {
    String t = "Accounts:";
    for (var acc in _accs) {
      t += "\n${acc.displayName} | ${_balances[acc.id]?.formattedBalance}";
      List<Transaction> txs = _txs[acc.id] ?? [];
      for (var tx in txs) {
        t +=
            "\n\t${tx.formattedDate} | ${tx.formattedDescription} | ${tx.formattedAmount}";
      }
    }

    return Column(
      children: [
        Text(t, textAlign: TextAlign.center),
        ElevatedButton(
            child: const Text("Fetch"),
            onPressed: () {
              FinanceKit.accounts(QueryParams()).then((accs) {
                for (var acc in accs) {
                  print("listening on acc ${acc.displayName}");
                  FinanceKit.transactionHistory(acc.id, isMonitoring: true)
                      .then((value) {
                    value.listen((event) {
                      print("got something1 $event");
                      print("got something2 ${event.toString()}");
                      print("got something3 ${event.updated}");
                      print("got something4 ${event.deleted}");
                    });
                  }, onError: (err) {
                    print("got err $err");
                  });

                  FinanceKit.accountBalances(QueryParams(
                    predicate: AccountBalance.byAccountIDs([acc.id]),
                  )).then((bals) {
                    FinanceKit.transactions(QueryParams(
                      predicate: Transaction.byAccountIDs([acc.id]),
                    )).then((txs) {
                      setState(() {
                        _txs[acc.id] = txs;
                        _balances[acc.id] = bals[0];
                        _accs = accs;
                      });
                    });
                  });
                }
              });
            })
      ],
    );
  }
}

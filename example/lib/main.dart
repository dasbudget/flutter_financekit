import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_financekit/flutter_financekit.dart';
import 'package:flutter_financekit/flutter_financekit_types.dart';

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
  List<Transaction> _txs = [];

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
              buildTransactions(),
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
    for (var value in _accs) {
      t += "\n${value.displayName}";
    }

    return Column(
      children: [
        Text(t, textAlign: TextAlign.center),
        ElevatedButton(
            child: const Text("Fetch"),
            onPressed: () {
              FinanceKit.accounts(QueryParams(limit: 50)).then((accs) => {
                    setState(() {
                      _accs = accs;
                    })
                  });
            })
      ],
    );
  }

  Widget buildTransactions() {
    String t = "Transactions:";
    for (var value in _txs) {
      t +=
          "\n${value.transactionAmount.format()}${value.originalTransactionDescription}";
    }

    return Column(
      children: [
        Text(t, textAlign: TextAlign.center),
        ElevatedButton(
            child: const Text("Fetch"),
            onPressed: () {
              FinanceKit.transactions(QueryParams(limit: 100)).then((txs) => {
                    setState(() {
                      _txs = txs;
                    })
                  });
            })
      ],
    );
  }
}

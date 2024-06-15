import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
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
  String _authStatus = AuthorizationStatus.denied.name;

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    FinanceKit.authorizationStatus().then((status) => {
          setState(() {
            _authStatus = "init ${status.name}";
          })
        });
  }

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
              Text('FinanceKit Auth Status\n$_authStatus', textAlign: TextAlign.center),
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
          ),
        ),
      ),
    );
  }
}

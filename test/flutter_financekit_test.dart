import 'dart:async';

import 'package:flutter_financekit/flutter_financekit_method_channel.dart';
import 'package:flutter_financekit/flutter_financekit_platform_interface.dart';
import 'package:flutter_financekit/flutter_financekit_types.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';


void main() {
  final FlutterFinanceKitPlatform initialPlatform =
      FlutterFinanceKitPlatform.instance;

  test('$MethodChannelFlutterFinanceKit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterFinanceKit>());
  });

  test('currency', () async {
    expect(NumberFormat().simpleCurrencySymbol("USD"), '\$');
  });
}

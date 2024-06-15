import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_financekit/flutter_financekit_method_channel.dart';

void main() {
  MethodChannelFlutterFinanceKit platform = MethodChannelFlutterFinanceKit();
  const MethodChannel channel = MethodChannel('flutter_financekit');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}

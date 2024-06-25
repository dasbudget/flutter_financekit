OS := $(shell uname)

clean:
	fvm flutter clean
	fvm flutter pub get

pigeon:
	fvm flutter pub run pigeon --input pigeons.dart
	gsed -i 's/_FinanceKitApiCodec/FinanceKitApiCodec/g' lib/src/messages.g.dart

rebuild:
	cd example && fvm flutter build ios --no-codesign --config-only


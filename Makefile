OS := $(shell uname)

clean:
	fvm flutter clean
	fvm flutter pub get

pigeon:
	fvm flutter pub run pigeon --input pigeons.dart
	gsed -i 's/_FinanceKitApiCodec/FinanceKitApiCodec/g' lib/src/messages.g.dart
	gsed -i 's/private class FinanceKitApiCodecReaderWriter/public class FinanceKitApiCodecReaderWriter/g' ios/Classes/Messages.g.swift
	gsed -i 's/override func reader/public override func reader/g' ios/Classes/Messages.g.swift
	gsed -i 's/override func writer/public override func writer/g' ios/Classes/Messages.g.swift

rebuild:
	cd example && fvm flutter build ios --no-codesign --config-only


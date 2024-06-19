OS := $(shell uname)



pigeon:
	fvm flutter pub run pigeon --input pigeons.dart
	gsed -i 's/_FinanceKitApiCodec/FinanceKitApiCodec/g' lib/src/messages.g.dart





pigeon:
	fvm flutter pub run pigeon \
      --input pigeons.dart \
      --dart_out lib/pigeon.dart \
      --swift_out ios/Classes/Pigeon.swift \
      --kotlin_out android/src/main/kotlin/com/dasbudget/flutter_financekit/Pigeon.kt \
      --kotlin_package "com.dasbudget.flutter_financekit" \

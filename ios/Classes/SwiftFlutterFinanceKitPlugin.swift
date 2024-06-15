import Flutter
import UIKit
import FinanceKit

public class SwiftFlutterFinanceKitPlugin: NSObject, FlutterPlugin, FinanceKitApi {
    private let store = FinanceStore.shared

  public static func register(with registrar: FlutterPluginRegistrar) {
      let messenger : FlutterBinaryMessenger = registrar.messenger()
    let api : FinanceKitApi & NSObjectProtocol = SwiftFlutterFinanceKitPlugin.init()
    FinanceKitApiSetup(messenger, api);
  }
}

import Flutter
import UIKit
import FinanceKit


@available(iOS 17.4, *)
extension FinanceKit.AuthorizationStatus {
    var toApi: AuthorizationStatus {
        get throws {
            switch self {
            case .authorized:
                return .authorized
            case .denied:
                return .denied
            case .notDetermined:
                return .notDetermined
            @unknown default:
                fatalError()
            }

        }
    }
}

@available(iOS 17.4, *)
extension FinanceStore.DataType {
    static func fromApi(type: DataType) -> FinanceStore.DataType {
        switch type {
        case .financialData:
            return FinanceStore.DataType.financialData
        case .orders:
            return FinanceStore.DataType.orders
        }
    }
}


public class SwiftFlutterFinanceKitPlugin: NSObject, FlutterPlugin, FinanceKitApi {
    private let store = FinanceStore.shared

    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger: FlutterBinaryMessenger = registrar.messenger()
        let api: FinanceKitApi & NSObjectProtocol = SwiftFlutterFinanceKitPlugin.init()
        FinanceKitApiSetup.setUp(binaryMessenger: messenger, api: api);
    }

    func isDataAvailable(type: DataType) throws -> Bool {
        return FinanceStore.isDataAvailable(FinanceStore.DataType.fromApi(type: type))
    }

    func authorizationStatus(completion: @escaping (Result<AuthorizationStatus, any Error>) -> Void) {
        Task {
            do {
                let status = try await store.authorizationStatus()
                completion(.success(try status.toApi))
            } catch let error {
                fatalError()
            }
        }
    }

    func requestAuthorization(completion: @escaping (Result<AuthorizationStatus, any Error>) -> Void) {
        Task {
            do {
                let status = try await store.requestAuthorization()
                completion(.success(try status.toApi))
            } catch let error {
                fatalError()
            }
        }
    }

//    @available(iOS 17.4, *)
}

import Flutter
import UIKit
import FinanceKit


@available(iOS 17.4, *)
extension FinanceKit.AuthorizationStatus {
    var toApi: ApiAuthorizationStatus {
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
extension FinanceKit.Account {
    var toApi: ApiAccount {
        get {
            return ApiAccount(type: liabilityAccount != nil ? .liability : .asset, currencyCode:
            currencyCode, displayName: displayName, id: id.uuidString, institutionName: institutionName)
        }
    }
}


@available(iOS 17.4, *)
extension FinanceKit.AccountBalance {
    var toApi: AccountBalance {
        get {
            return AccountBalance(accountID: id.uuidString, currencyCode: currencyCode, currentBalance: currentBalance, id: id.uuidString)
        }
    }
}


@available(iOS 17.4, *)
extension FinanceKit.CurrentBalance {
    var toApi: CurrentBalance {
        get throws {
            switch self {
            case .available:
                return .available
            case .availableAndBooked:
                return .availableAndBooked
            case .booked:
                return .booked
            @unknown default:
                fatalError()
            }

        }
    }
}

@available(iOS 17.4, *)
extension FinanceStore.DataType {
    static func fromApi(type: ApiDataType) -> FinanceStore.DataType {
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

    func isDataAvailable(type: ApiDataType) throws -> Bool {
        return FinanceStore.isDataAvailable(FinanceStore.DataType.fromApi(type: type))
    }

    func authorizationStatus(completion: @escaping (Result<ApiAuthorizationStatus, any Error>) -> Void) {
        Task {
            do {
                let status = try await store.authorizationStatus()
                completion(.success(try status.toApi))
            } catch let error {
                fatalError()
            }
        }
    }

    func requestAuthorization(completion: @escaping (Result<ApiAuthorizationStatus, any Error>) -> Void) {
        Task {
            do {
                let status = try await store.requestAuthorization()
                completion(.success(try status.toApi))
            } catch let error {
                fatalError()
            }
        }
    }


    func accounts(query: ApiQueryParams, completion: @escaping (Result<[ApiAccount], any Error>) -> Void) {
        Task {
            do {
                let accounts = try await self.store.accounts(query: AccountQuery())
                completion(.success(accounts.map({ a in
                    a.toApi
                })))
            } catch let error {
                fatalError()
            }
        }
    }

    func accountBalances(query: ApiQueryParams, completion: @escaping (Result<[AccountBalance], any Error>) -> Void) {
        Task {
            do {
                let accounts = try await self.store.accountBalances(query: AccountBalanceQuery())
                completion(.success(accounts.map({ a in
                    a.toApi
                })))
            } catch let error {
                fatalError()
            }
        }
    }

    func transactions(query: ApiQueryParams, completion: @escaping (Result<[ApiTransaction], any Error>) -> Void) {
        <#code#>
    }


//    @available(iOS 17.4, *)
}

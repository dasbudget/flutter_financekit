import Flutter
import UIKit
import FinanceKit
import os.log


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
extension FinanceKit.CreditDebitIndicator {
    var toApi: ApiCreditDebitIndicator {
        get throws {
            switch self {
            case .credit:
                return .credit
            case .debit:
                return .debit
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
extension FinanceKit.CurrentBalance {
    var toApi: ApiCurrentBalance {
        get throws {
            switch self {
            case .available:
                return .available
            case .booked:
                return .booked
            case .availableAndBooked:
                return .availableAndBooked
            @unknown default:
                fatalError()
            }
        }
    }
}

@available(iOS 17.4, *)
extension FinanceKit.TransactionStatus {
    var toApi: ApiTransactionStatus {
        get throws {
            switch self {
            case .authorized:
                return .authorized
            case .booked:
                return .booked
            case .memo:
                return .memo
            case .pending:
                return .pending
            case .rejected:
                return .rejected
            @unknown default:
                fatalError()
            }
        }
    }
}

@available(iOS 17.4, *)
extension FinanceKit.TransactionType {
    var toApi: ApiTransactionType {
        get throws {
            switch self {
            case .adjustment:
                return .adjustment
            case .atm:
                return .atm
            case .billPayment:
                return .billPayment
            case .check:
                return .check
            case .deposit:
                return .deposit
            case .directDebit:
                return .directDebit
            case .directDeposit:
                return .directDeposit
            case .dividend:
                return .dividend
            case .fee:
                return .fee
            case .interest:
                return .interest
            case .loan:
                return .loan
            case .pointOfSale:
                return .pointOfSale
            case .refund:
                return .refund
            case .standingOrder:
                return .standingOrder
            case .transfer:
                return .transfer
            case .unknown:
                return .unknown
            case .withdrawal:
                return .withdrawal
            @unknown default:
                fatalError()
            }
        }
    }
}


@available(iOS 17.4, *)
extension FinanceKit.AccountBalance {
    var toApi: ApiAccountBalance {
        get throws {
            return try ApiAccountBalance(
                accountID: accountID.uuidString,
                available: available?.toApi,
                booked: booked?.toApi,
                currencyCode: currencyCode,
                currentBalance: currentBalance.toApi,
                id: id.uuidString
            )
        }
    }
}
@available(iOS 17.4, *)
extension FinanceKit.Balance {
    var toApi: ApiBalance {
        get throws {
            return try ApiBalance(
                amount: amount.toApi,
                asOfDate: Int64(asOfDate.timeIntervalSince1970 * 1000),
                creditDebitIndicator: creditDebitIndicator.toApi
            )
        }
    }
}


@available(iOS 17.4, *)
extension FinanceKit.CurrencyAmount {
    var toApi: ApiCurrencyAmount {
        get {
            return ApiCurrencyAmount(amount: NSDecimalNumber(decimal: amount).stringValue, currencyCode: currencyCode)
        }
    }
}


@available(iOS 17.4, *)
extension FinanceKit.Transaction {
    var toApi: ApiTransaction {
        get throws {
            return try ApiTransaction(
                id: id.uuidString,
                accountID: accountID.uuidString,
                creditDebitIndicator: creditDebitIndicator.toApi,
                foreignCurrencyAmount: foreignCurrencyAmount?.toApi,
                //                foreignCurrencyExchangeRate: foreignCurrencyExchangeRate,
                merchantCategoryCode:  (merchantCategoryCode != nil) ? Int64(merchantCategoryCode!.rawValue) : nil,
                merchantName: merchantName,
                originalTransactionDescription: originalTransactionDescription,
                postedDate: (postedDate != nil ) ? Int64(postedDate!.timeIntervalSince1970 * 1000) : nil,
                status: status.toApi,
                transactionAmount: transactionAmount.toApi,
                transactionDate: Int64(transactionDate.timeIntervalSince1970 * 1000),
                transactionDescription: transactionDescription,
                transactionType: transactionType.toApi)
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
    
    func test() throws -> [ApiChanges] {
        return []
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
                os_log("Error: %@", log: .default, type: .error, String(describing: error))
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
    
    func accountBalances(query: ApiQueryParams, completion: @escaping (Result<[ApiAccountBalance], any Error>) -> Void) {
        Task {
            do {
                let accounts = try await self.store.accountBalances(query: AccountBalanceQuery())
                try completion(.success(accounts.map({ a in
                    try a.toApi
                })))
            } catch let error {
                fatalError()
            }
        }
    }
    
    func transactions(query: ApiQueryParams, completion: @escaping (Result<[ApiTransaction], any Error>) -> Void) {
        Task {
            do {
                let transactions = try await self.store.transactions(query: TransactionQuery())
                try completion(.success(transactions.map({ t in
                    try t.toApi
                })))
            } catch let error {
                fatalError()
            }
        }
    }
}

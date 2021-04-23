//
//  APIRouter.swift
//  PatientHistory
//
//  Created by Abdul Rahman Alansari on 11/11/20.
//  Copyright © 2020 Eslam Sebaie. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    // The endpoint name
    // MARK:- Registration
    case vendorRegister(_ storeName: String,_ emailNumber: String, _ landLine: String, _ storeLocation: String, _ storeFile: String, _ password: String)
    case vendorLogin(_ emailNumber: String,_ password: String)
    case getOrders(_ emailNumber: String)
    case updateStatus(_ id: Int, _ orderStatus: Int)
    case saveProduct(_ emailNumber:String, _ image: String, _ title: String, _ description: String, _ itemNo: String, _ brandName: String, _ price: String, _ wholeSale: String, _ quantity: String,  _ barCode: String, _ design: String, _ isActive: Bool, _ productColor: [String], _ productSize: [String], _ productDate: String, _ categoryId: Int)
    case getProduct(_ emailNumber: String)
    case getCategories
    case changeActive(_ id: Int, _ isActive: Bool)
    case editProduct(_ id:Int, _ image: String, _ title: String, _ description: String, _ itemNo: String, _ brandName: String, _ price: String, _ wholeSale: String, _ quantity: String,  _ barCode: String, _ design: String, _ isActive: Bool, _ productColor: [String], _ productSize: [String], _ productDate: String, _ categoryId: Int)
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case.vendorRegister, .vendorLogin, .updateStatus, .saveProduct:
            return .post
        case .getOrders, .getProduct, .getCategories:
            return .get
        case .changeActive, .editProduct:
            return .put
        default:
            return .delete
        }
        
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        // MARK: - registerParameters
        case .vendorRegister(let storeName, let emailNumber, let landLine, let storeLocation, let storeFile, let password):
            return [ParameterKeys.storeName: storeName, ParameterKeys.emailNumber: emailNumber, ParameterKeys.landLine: landLine, ParameterKeys.storeLocation: storeLocation, ParameterKeys.storeFile: storeFile, ParameterKeys.password: password]
        case .vendorLogin(let emailNumber, let password):
            return [ParameterKeys.emailNumber: emailNumber, ParameterKeys.password: password]
        case .getOrders(let emailNumber):
            return [ParameterKeys.emailNumber: emailNumber]
        case .updateStatus(let id, let orderStatus):
            return ["id": id, "orderStatus": orderStatus]
        case .saveProduct(let emailNumber, let image, let title, let description, let itemNo, let brandName, let price, let wholeSale, let quantity, let barCode, let design, let isActive, let productColor, let productSize, let productDate, let categoryId ):
            return [ParameterKeys.emailNumber: emailNumber, "image": image, "name": title, "description": description, "itemNo": itemNo, "brandName": brandName, "price": price, "wholeSale": wholeSale, "quantity": quantity,  "barCode": barCode, "design": design, "isActive": isActive, "productColor": productColor,"size":productSize, "date": productDate, "categoryId": categoryId]
        case .getProduct(let emailNumber):
            return [ParameterKeys.emailNumber: emailNumber]
        case .changeActive(let id, let isActive):
            return ["id": id, "isActive": isActive]
        case .editProduct(let id, let image, let title, let description, let itemNo, let brandName, let price, let wholeSale, let quantity, let barCode, let design, let isActive, let productColor, let productSize, let productDate, let categoryId ):
            return ["id": id, "image": image, "name": title, "description": description, "itemNo": itemNo, "brandName": brandName, "price": price, "wholeSale": wholeSale, "quantity": quantity,  "barCode": barCode, "design": design, "isActive": isActive, "productColor": productColor,"size":productSize, "date": productDate, "categoryId": categoryId]
        default:
            return nil
        }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        // MARK: - PathRegister
        case .vendorRegister:
            return URLs.vendorSignUp
        case .vendorLogin:
            return URLs.login
        case .getOrders:
            return URLs.order
        case .updateStatus:
            return URLs.updateStatusOrder
        case .saveProduct:
            return URLs.product
        case .getProduct:
            return URLs.product
        case .getCategories:
            return URLs.createCategory
        case .changeActive:
            return URLs.product
        case .editProduct:
            return URLs.product
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try URLs.base.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        //httpMethod
        urlRequest.httpMethod = method.rawValue
        print(urlRequest)
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            default:
                return nil
            }
        }()
        
        
        // Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .delete:
                return URLEncoding.default
                
            default:
                return JSONEncoding.default
            }
        }()
        
        print(try encoding.encode(urlRequest, with: parameters))
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}

extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print("666")
            print(jsonString)
            return jsonData
        } catch {
            print("#$#")
            print(error)
            return nil
        }
    }
}

// type-erasing wrapper
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}

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
//    case vendorRegister(_ image: String,_ firstName: String, _ middleName: String)
    
  
    
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
//        case.vendorRegister:
//            return .post
//
//        default:
//            return .delete
        }
        
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        // MARK: - registerParameters
//        case .vendorRegister(let firstName, let image , let middleName):
//            return [ParameterKeys.firstName: firstName, ParameterKeys.image: image ,ParameterKeys.middleName: middleName]
//
//        default:
//            return nil
        }
    }
    // MARK: - Path
    private var path: String {
        switch self {
            
        // MARK: - PathRegister
//        case .patientRegister:
//            return URLs.patientRegister
       
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

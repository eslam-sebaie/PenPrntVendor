//
//  APIManager.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/26/21.
//

import Foundation
import Alamofire
class APIManager {

    class func VendorRegister(storeName: String, emailNumber: String, landLine: String, storeLocation: String, storeFile: String, password: String, completion: @escaping(Result<SignUpResponse, Error>) -> Void) {
        request(APIRouter.vendorRegister(storeName, emailNumber, landLine, storeLocation, storeFile, password)) { (response) in
            completion(response)
        }
    }
    
    class func VendorLogin( emailNumber: String, password: String, completion: @escaping(Result<SignUpResponse, Error>) -> Void) {
        request(APIRouter.vendorLogin(emailNumber, password)) { (response) in
            completion(response)
        }
    }
    class func getOrder(emailNumber: String, completion: @escaping(Result<OrderResponse, Error>) -> Void ) {
        request(APIRouter.getOrders(emailNumber)) { (response) in
            completion(response)
        }
    }
    
}

extension APIManager{
    
    private static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
        
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        .responseJSON { response in
            print(response)
        }
    }
}

//
//  APIManager.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 3/26/21.
//

import Foundation
import Alamofire
import SwiftyJSON
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
    class func OrderStatus(id: Int, orderStatus: Int, completion: @escaping(Result<OrderStart, Error>) -> Void ) {
        request(APIRouter.updateStatus(id, orderStatus)) { (response) in
            completion(response)
        }
    }
    
    class func uploadPhoto(image: UIImage, completion: @escaping (_ error: Error?, _ upImage: uploadImage?)-> Void){
        
        AF.upload(multipartFormData: { (form: MultipartFormData) in
            
            if let data = image.jpegData(compressionQuality: 0.75) {
                form.append(data, withName: "storeFile", fileName: "storeFile.jpeg", mimeType: "storeFile/jpeg")
            }
        }, to: URLs.uploadPhoto, usingThreshold: MultipartFormData.encodingMemoryThreshold, method: .post, headers: nil).response {
            response in
            guard response.error == nil else {
                print(response.error!)
                
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            
            do {
                print("indata")
                print(JSON(data))
                let decoder = JSONDecoder()
                let img = try decoder.decode(uploadImage.self, from: data)
                
                completion(nil, img)
            } catch let error {
                completion(response.error, nil)
            }
        }
    }
    
    class func uploadDocument(file: Data,fileName : String, completion: @escaping (_ error: Error?, _ upDoc: uploadImage?) -> Void) {
        
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(file, withName: "fileName" , fileName: fileName, mimeType: "fileName/pdf")
        },
            to: "\(URLs.base)\(URLs.uploadPhoto)", method: .post , headers: nil)
            .response { response in
                guard response.error == nil else {
                    print(response.error!)
                    
                    return
                }
                
                guard let data = response.data else {
                    print("didn't get any data from API")
                    return
                }
                
                do {
                    print("indata")
                    print(JSON(data))
                    let decoder = JSONDecoder()
                    let img = try decoder.decode(uploadImage.self, from: data)
                    
                    completion(nil, img)
                } catch let error {
                    completion(response.error, nil)
                }
                
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

//
//  OrderModal.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/6/21.
//

import Foundation
//struct OrderResponse: Codable {
//    let data: [OrderInfo]?
//    let message: String
//}
//
//// MARK: - Datum
//struct OrderInfo: Codable {
//    let id: Int
//    let orderNumber: String?
//    let orderDate, orderStatus, totalPrice: String?
//    let orderDetails: [OrderDetail]?
//}
//
//// MARK: - OrderDetail
//struct OrderDetail: Codable {
//    let orderName, orderQuantity, orderColor, orderSize: String?
//    let orderImage, orderPrice: String?
//}

struct OrderResponse: Codable {
    let data: [OrderInfo]
    let message: String
}

// MARK: - Datum
struct OrderInfo: Codable, Equatable {
    static func == (lhs: OrderInfo, rhs: OrderInfo) -> Bool {
        return lhs.orderID == rhs.orderID
    }
    
    let id: Int
    let productID, orderID, price, quantity: String
    let color, size, name, image: String
    let order: OrderDetail

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case orderID = "order_id"
        case price, quantity
        case color = "Color"
        case size, name, image, order
    }
}

// MARK: - Order
struct OrderDetail: Codable {
    let id: Int
    let orderNumber, orderDate, orderStatus, totalPrice: String
    let userID: String

    enum CodingKeys: String, CodingKey {
        case id, orderNumber, orderDate, orderStatus, totalPrice
        case userID = "userId"
    }
}




struct OrderStart: Codable {
    let data: Int
    let message: String
}
struct uploadImage: Decodable {
    var data: String
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

//
//  OrderModal.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/6/21.
//

import Foundation
struct OrderResponse: Codable {
    let data: [OrderInfo]?
    let message: String
}

// MARK: - Datum
struct OrderInfo: Codable {
    let id: Int
    let orderNumber: String?
    let orderDate, orderStatus, totalPrice: String?
    let orderDetails: [OrderDetail]?
}

// MARK: - OrderDetail
struct OrderDetail: Codable {
    let orderName, orderQuantity, orderColor, orderSize: String?
    let orderImage, orderPrice: String?
}

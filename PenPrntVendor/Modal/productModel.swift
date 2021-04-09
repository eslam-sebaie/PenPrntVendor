//
//  productModel.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/9/21.
//

import Foundation
struct productRespnse: Codable {
    let data: productInfo
    let message: String
}

// MARK: - DataClass
struct productInfo: Codable {
    let userID: Int?
    let image, title, dataDescription, itemNo: String?
    let brandName, price, wholeSale, quantity: String?
    let unit, barCode, stock: String?
    let design: [String]?
    let isActive: Bool?
    let id: Int

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case image, title
        case dataDescription = "description"
        case itemNo, brandName, price, wholeSale, quantity, unit, barCode, stock, design, isActive, id
    }
}

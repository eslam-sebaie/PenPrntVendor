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


// MARK: - Welcome
struct getProductRespnse: Codable {
    let data: [getProductInfo]?
    let message: String
}

// MARK: - Datum
struct getProductInfo: Codable {
    let id: Int?
    let image: String?
    let name, description, itemNo, brandName: String?
    let price: String?
    let wholeSale: String?
    let quantity, unit, barCode: String?
    let stock: String?
    let design: String?
    let isActive: Bool?
    let vendorID: String?
    let productColor, size: [String]?
    let date: String?
    let categoryId: String?
    let subcategoryId: String?
    enum CodingKeys: String, CodingKey {
        case id, image, name
        case description
        case itemNo, brandName, price, wholeSale, quantity, unit, barCode, stock, design, productColor, isActive, size, date, categoryId, subcategoryId
        case vendorID = "vendorId"
    }
}
struct CategoryResponse: Codable {
    let data: [CategoryInfo]?
    let message: String
}

// MARK: - Datum
struct CategoryInfo: Codable {
    let id: Int?
    let name: String?
}
struct ChangeActiveResponse: Codable {
    let data: Int
    let message: String
}

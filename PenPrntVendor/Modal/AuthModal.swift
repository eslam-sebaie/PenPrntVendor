//
//  AuthModal.swift
//  PenPrntVendor
//
//  Created by Eslam Sebaie on 4/5/21.
//

import Foundation

struct SignupError: Codable, Error {
    let error: ErrorInfo
    enum CodingKeys: String, CodingKey {
        case error
    }
}

// MARK: - Error
struct ErrorInfo: Codable, Error {
    let emailNumber: [String]
}

struct SignUpResponse: Codable {
    let data: SignUpInfo
    let message, token: String
}

// MARK: - DataClass
struct SignUpInfo: Codable {
    let storeName, emailNumber, landLine, storeLocation: String
    let storeFile, updatedAt, createdAt: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case storeName, emailNumber, landLine, storeLocation, storeFile
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}


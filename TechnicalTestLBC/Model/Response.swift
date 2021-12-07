//
//  Annoucement.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/7.
//

import Foundation

// MARK: - AnnoncementElement
struct Response: Codable {
    let id, categoryID: Int
    let title, annoncementDescription: String
    let price: Double
    let imagesURL: ImagesURL
    let creationDate: String
    let isUrgent: Bool
    let siret: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title
        case annoncementDescription = "description"
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
}

// MARK: - ImagesURL
struct ImagesURL: Codable {
    let small, thumb: String?
}

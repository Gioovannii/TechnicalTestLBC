//
//  CategoriesDescription.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/9.
//

import Foundation

extension AnnouncementsListVC {
    static var categorySearchBar = ["🔄", "🚗", "👗", "🪛", "🏚", "🎳", "🚪", "📀",
                                    "💻", "🎖", "🦮", "👶"]
    
    static func getCategoryImage(id: Int) -> String {
        switch id {
        case 1:
            return "🚗"
        case 2:
            return "👗"
        case 3:
            return "🪛"
        case 4:
            return "🏚"
        case 5:
            return "🎳"
        case 6:
            return "🚪"
        case 7:
            return "📀"
        case 8:
            return "💻"
        case 9:
            return "🎖"
        case 10:
            return "🦮"
        case 11:
            return "👶"
        default:
            return "Catégorie introuvable"
        }
    }
}

//
//  CategoriesDescription.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffรฉ on 2021/12/9.
//

import Foundation

extension AnnouncementsListVC {
    static var categorySearchBar = ["๐", "๐", "๐", "๐ช", "๐", "๐ณ", "๐ช", "๐",
                                    "๐ป", "๐", "๐ฆฎ", "๐ถ"]
    
    static func getCategoryImage(id: Int) -> String {
        switch id {
        case 1:
            return "๐"
        case 2:
            return "๐"
        case 3:
            return "๐ช"
        case 4:
            return "๐"
        case 5:
            return "๐ณ"
        case 6:
            return "๐ช"
        case 7:
            return "๐"
        case 8:
            return "๐ป"
        case 9:
            return "๐"
        case 10:
            return "๐ฆฎ"
        case 11:
            return "๐ถ"
        default:
            return "Catรฉgorie introuvable"
        }
    }
}

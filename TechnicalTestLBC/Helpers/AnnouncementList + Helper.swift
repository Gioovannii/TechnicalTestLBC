//
//  CategoriesDescription.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/9.
//

import Foundation

extension AnnouncementsListVC {
    static var categorySearchBar = ["Tout", "Vehicule", "Mode", "Bricolage", "Maison", "Loisirs", "Immobilier", "Livres/CD/DVD",
                                    "Multimédia", "Service", "Animaux", "Enfants"]
    
    static func getCategoryDescription(id: Int) -> String {
        switch id {
        case 1:
            return "Vehicule"
        case 2:
            return "Mode"
        case 3:
            return "Bricolage"
        case 4:
            return "Maison"
        case 5:
            return "Loisirs"
        case 6:
            return "Immobilier"
        case 7:
            return "Livres/CD/DVD"
        case 8:
            return "Multimédia"
        case 9:
            return "Service"
        case 10:
            return "Animaux"
        case 11:
            return "Enfants"
        default:
            return "Catégorie introuvable"
        }
    }
}

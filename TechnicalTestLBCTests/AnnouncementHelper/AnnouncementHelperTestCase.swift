//
//  AnnouncementHelperTestCase.swift
//  TechnicalTestLBCTests
//
//  Created by Giovanni Gaffé on 2021/12/15.
//

@testable import TechnicalTestLBC
import XCTest

class AnnouncementHelperTestCase: XCTestCase {
    
    // MARK: - Vehicule

    func testGetCategoryImage_WhenWePassedAnId_ShouldReturnNumber1Icone() {
        let categoryName = AnnouncementsListVC.getCategoryImage(id: 1)
        XCTAssert(categoryName == "🚗")
    }
    
    // MARK: - Mode

    func testGetCategoryImage_WhenWePassedAnId_ShouldReturnNumber2Icone() {
        let categoryName = AnnouncementsListVC.getCategoryImage(id: 2)
        XCTAssert(categoryName == "👗")
    }
    
    // MARK: - Bricolage

    func testGetCategoryImage_WhenWePassedAnId_ShouldReturnNumber3Icone() {
        let categoryName = AnnouncementsListVC.getCategoryImage(id: 3)
        XCTAssert(categoryName == "🪛")
    }
    
    // MARK: - Maison

    func testGetCategoryImage_WhenWePassedAnId_ShouldReturnNumber4Icone() {
        let categoryName = AnnouncementsListVC.getCategoryImage(id: 4)
        XCTAssert(categoryName == "🏚")
    }
    
    // MARK: - Loisirs

    func testGetCategoryImage_WhenWePassedAnId_ShouldReturnNumber5Icone() {
        let categoryName = AnnouncementsListVC.getCategoryImage(id: 5)
        XCTAssert(categoryName == "🎳")
    }
    
    // MARK: - Immobilier

    func testGetCategoryImage_WhenWePassedAnId_ShouldReturnNumber6Icone() {
        let categoryName = AnnouncementsListVC.getCategoryImage(id: 6)
        XCTAssert(categoryName == "🚪")
    }
    
    // MARK: - Livres/CD/DVD

    func testGetCategoryImage_WhenWePassedAnId_ShouldReturnNumber7Icone() {
        let categoryName = AnnouncementsListVC.getCategoryImage(id: 7)
        XCTAssert(categoryName == "📀")
    }
    
    // MARK: - Multimedia

    func testGetCategoryImage_WhenWePassedAnId_ShouldReturnNumber8Icone() {
        let categoryName = AnnouncementsListVC.getCategoryImage(id: 8)
        XCTAssert(categoryName == "💻")
    }
    
    // MARK: - Service

    func testGetCategoryImage_WhenWePassedAnId_ShouldReturnNumber9Icone() {
        let categoryName = AnnouncementsListVC.getCategoryImage(id: 9)
        XCTAssert(categoryName == "🎖")
    }
    
    // MARK: - Animaux

    func testGetCategoryImage_WhenWePassedAnId_ShouldReturnNumber10Icone() {
        let categoryName = AnnouncementsListVC.getCategoryImage(id: 10)
        XCTAssert(categoryName == "🦮")
    }
    
    // MARK: - Enfants

    func testGetCategoryImage_WhenWePassedAnId_ShouldReturnNumber11Icone() {
        let categoryName = AnnouncementsListVC.getCategoryImage(id: 11)
        XCTAssert(categoryName == "👶")
    }
}

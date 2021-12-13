//
//  DateFormattertestCase.swift
//  TechnicalTestLBCTests
//
//  Created by Giovanni Gaffé on 2021/12/13.
//

@testable import TechnicalTestLBC
import XCTest

class DateFormatterTestCase: XCTestCase {
    
    let dateString = "2019-11-05T15:56:59+0000"
    let expectedDate = "5 novembre 2019 à 23:56"

    func testGetDateToString() {
        let dateConverted = DateFormatter.getDateFromString(date: dateString)

        XCTAssert(dateConverted == DateFormatter.getDateFromString(date: dateString))
        
    }
    
    func testGetStringfromDate() {
        
        let date = DateFormatter.getDateFromString(date: dateString)
        
        let dateConverted = DateFormatter.getDateToString(from: date)
        XCTAssert(dateConverted == expectedDate)
    }
}

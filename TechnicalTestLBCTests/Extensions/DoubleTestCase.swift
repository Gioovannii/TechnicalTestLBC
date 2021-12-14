//
//  DoubleTestCase.swift
//  TechnicalTestLBCTests
//
//  Created by Giovanni Gaffé on 2021/12/13.
//

@testable import TechnicalTestLBC
import XCTest

class DoubleTestCase: XCTestCase {
    let double = 50.0
    
    func teststringWithoutZeroFraction() {
        let cleanDouble = double.stringWithoutZeroFraction
        
        XCTAssert(cleanDouble == "50")
    }

}

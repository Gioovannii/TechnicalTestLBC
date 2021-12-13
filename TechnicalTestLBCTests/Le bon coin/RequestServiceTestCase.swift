//
//  RequestServiceTestCase.swift
//  TechnicalTestLBCTests
//
//  Created by Giovanni Gaffé on 2021/12/12.
//

@testable import TechnicalTestLBC
import XCTest

final class RequestServiceTestCase: XCTestCase {

    // MARK: - Fetch Data Success
    func testFetchData_ShouldPostCallbackSuccessWhenAlldCorrectData() {
        let result = RequestService(session: URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        result.fetchData { response in
            XCTAssertEqual(response[0].title, "Statue homme noir assis en plâtre polychrome")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    
    // MARK: - fetch Request Failed

    func testGetData_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
        let result = RequestService(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")

        result.fetchData { response in
            guard let result = response.first?.title else {
                XCTFail("NoResponseShouldBeFound")
                return
            }
        
        XCTAssertNotEqual(result, "Statue homme noir assis en plâtre polychrome")
            print(result)
        expectation.fulfill()
        }
    }
}

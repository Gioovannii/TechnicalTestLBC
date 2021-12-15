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
       
        
        let result = RequestService(session: URLSessionFake(fakeResponse: FakeResponse(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: nil)))

        let expectation = XCTestExpectation(description: "Wait for queue change")

        result.fetchData { (response: Result<[Response], NetworkError>) in
            guard case .success(let data) = response else {
                XCTFail("testFetchData_ShouldPostSuccessCompletion_IfNoErrorResponseOKAndCorrectData")
                return
            }

            XCTAssertEqual(data[0].title, "Statue homme noir assis en plâtre polychrome")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
//
    }
    
    
    // MARK: - fetch Request Failed
    
//     Data incorrect and error
    func testGetData_WhenIncorrectDataIsPassed_ThenShouldReturnFailedCallback() {
        let result = RequestService(session: URLSessionFake(fakeResponse: FakeResponse(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: FakeResponseData.networkError)))

        let expectation = XCTestExpectation(description: "Wait for queue change")

        result.fetchData { (response: Result<[Response], NetworkError>) in

            guard case .failure(let error) = response else {
                XCTFail("testFetchData_ShouldPostFailureCompletion_IfNoErrorResponseKOAndIncorrectData")
                return
            }

            XCTAssertNotNil(error)
            XCTAssert(error.description == "Data is undecodable")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    //No Data
    func testGetData_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
        let result = RequestService(session: URLSessionFake(fakeResponse: FakeResponse(data: nil, response: FakeResponseData.responseOK, error: FakeResponseData.networkError)))

        let expectation = XCTestExpectation(description: "Wait for queue change")

        result.fetchData { (response: Result<[Response], NetworkError>) in

            guard case .failure(let error) = response else {
                XCTFail("testFetchData_ShouldPostFailureCompletion_IfNoErrorResponseKOAndIncorrectData")
                return
            }

            XCTAssertNotNil(error)
            XCTAssert(error.description == "There is no data")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Response KO
    func testGetData_WhenIncorrectDataIsPassedAndResponseOK_ThenShouldReturnFailedCallback() {
        let result = RequestService(session: URLSessionFake(fakeResponse: FakeResponse(data: FakeResponseData.correctData, response: FakeResponseData.responseKO, error: FakeResponseData.networkError)))

        let expectation = XCTestExpectation(description: "Wait for queue change")

        result.fetchData { (response: Result<[Response], NetworkError>) in

            guard case .failure(let error) = response else {
                XCTFail("testFetchData_ShouldPostFailureCompletion_IfNoErrorResponseKOAndIncorrectData")
                return
            }

            XCTAssertNotNil(error)
            XCTAssert(error.description == "There is no response")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)

    }
}

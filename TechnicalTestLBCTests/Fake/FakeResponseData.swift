//
//  FakeResponseData.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/12.
//

import Foundation

final class FakeResponseData {
    // MARK: - Response

    static let responseOK = HTTPURLResponse(url: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: - Error

    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    // MARK: - Data

    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Response", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectData = "erreur".data(using: .utf8)!
}

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
    // Test passed But for some reason cannot found file json
    
    static var correctData: Data? {
        guard let filePathString = Bundle.main.path(forResource: "LeBonCoin", ofType: "json") else {
            fatalError("Cannot load json for some reasons")
        }
        guard let jsonFileURL = URL(string: filePathString) else { return Data() }
        guard let string = try? String(contentsOfFile: jsonFileURL.absoluteString) else { return Data() }
        guard let data = string.data(using: .utf8) else {
            return Data()
        }
        
        return data
    }

    static let incorrectData = "erreur".data(using: .utf8)!
}



//
//  RequestService.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/10.
//

import Foundation

final class RequestService {
    
    var categories = [Category]()
    
    private let session: URLSession
    private var task: URLSessionDataTask?
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    /// Fetch data with result type which use Network error to get different description errors
    func fetchData(onCompletion: @escaping (Result<[Response], NetworkError>) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else {
            print("Invalid URL")
            return
        }
        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                onCompletion(.failure(.noData))
                print("Data was nil")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                onCompletion(.failure(.incorrectResponse))
                print("No response")
                return
            }
            
            guard let decodedResponse = try? JSONDecoder().decode([Response].self, from: data) else {
                onCompletion(.failure(.undecodableData))
                print("Couldn't decode json")
                return
            }
            
            onCompletion(.success(decodedResponse))
        }
        task?.resume()
    }
    
    /// Load categories at Launch with decodable struct from json file
    func getCategories() -> [Category] {
        let bundle = Bundle(for: RequestService.self)
        guard let url = bundle.url(forResource: "Categories", withExtension: "json") else {
            print("Cannot locate url from bundle")
            return []
        }
        
        guard let data = try? Data(contentsOf: url) else { return [] }
        
        guard let decodedData = try? JSONDecoder().decode([Category].self, from: data) else {
            print("Cannot decode data")
            return []
        }
        
        return decodedData
    }
}

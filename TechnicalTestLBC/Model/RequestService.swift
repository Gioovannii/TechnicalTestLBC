//
//  RequestService.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/10.
//

import Foundation

protocol RequestTestService {
    func fetchData(onCompletion: @escaping (Result<[Response], NetworkError>) -> Void)
}

final class RequestService: RequestTestService {
    
    private let session: URLSession
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func fetchData(onCompletion: @escaping (Result<[Response], NetworkError>) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else {
            print("Invalid URL")
            return
        }
        session.dataTask(with: url) { (data, response, error) in
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
        .resume()
    }
}

//
//  RequestService.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/10.
//

import Foundation

class RequestService {
    func fetchData(onCompletion: @escaping ([Response]) -> ()) {
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Data was nil")
                return
            }
                        
            guard let decodedResponse = try? JSONDecoder().decode([Response].self, from: data) else {
                print("Couldn't decode json")
                return
            }
            
            onCompletion(decodedResponse)
        }
        task.resume()
    }
}

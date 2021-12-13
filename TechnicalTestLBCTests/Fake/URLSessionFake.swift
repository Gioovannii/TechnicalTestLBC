//
//  URLSessionFake.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/12.
//

import Foundation

struct FakeResponse {
    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?
}

final class URLSessionFake: URLSession {
    
 //MARK: - Properties.
    
    private var data: Data?
    private var response: URLResponse?
    private var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    //MARK: - Override methods
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake(data: data, urlResponse: response, responseError: error, completionHandler: completionHandler)
        return task
    }
}

// MARK: - DataTasks
final class URLSessionDataTaskFake: URLSessionDataTask {
    private var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    private var data: Data?
    private var urlResponse: URLResponse?
    private var responseError: Error?
    
    init(data: Data?, urlResponse: URLResponse?, responseError: Error?, completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) {
        self.data = data
        self.urlResponse = urlResponse
        self.responseError = responseError
        self.completionHandler = completionHandler
    }
    
    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }
    
    override func cancel() {}
}

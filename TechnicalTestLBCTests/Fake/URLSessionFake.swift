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
    
    private let fakeResponse: FakeResponse
    
    init(configuration: URLSessionConfiguration = .default , fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
        super.init(configuration: configuration)
    }
    
    //MARK: - Override methods
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        let task = URLSessionDataTaskFake(data: fakeResponse.data, urlResponse: fakeResponse.response, responseError: fakeResponse.error, completionHandler: completionHandler)
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

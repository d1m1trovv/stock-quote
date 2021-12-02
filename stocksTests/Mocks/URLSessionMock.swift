//
//  URLSessionMock.swift
//  stocksTests
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
@testable import stocks

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}

class URLSessionMock: URLSessionProtocol {
    var result: (Data?, URLResponse?, Error?)! = nil
    
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let result = self.result!
        return URLSessionDataTaskMock {
            completionHandler(result.0, result.1, result.2)
        }
    }
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let result = self.result!
        return URLSessionDataTaskMock {
            completionHandler(result.0, result.1, result.2)
        }
    }
}

//
//  MockData.swift
//  ArticlesTests
//
//  Created by Tauqeer Ahmed Khan on 26/11/21.
//

/** A Mock Data Class to crate mock objects to test Network Layers*/

import Foundation
@testable import Articles

class DataTaskMock: URLSessionDataTask {

    var completionHandler: (Data?, URLResponse?, Error?) -> Void
    var resumeWasCalled = false

    // stash away the completion handler so we can call it later
    @available(iOS, deprecated: 13.0)
    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.completionHandler = completionHandler
    }
    override func resume() {
        // resume was called, so flip our boolean and call the completion
        resumeWasCalled = true
        completionHandler(nil, nil, nil)
    }
}

class URLSessionMock: URLSessionProtocol {
    
    var dataTask: DataTaskMock?

    @available(iOS, deprecated: 13.0)
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        let newDataTask = DataTaskMock(completionHandler: completionHandler)
        dataTask = newDataTask
        return newDataTask
    }
    
}


class URLSessionMockUrl: URLSessionProtocol {
    @available(iOS, deprecated: 13.0)
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        defer { completionHandler(nil, nil, nil) }
        lastURL = request.url
        return DataTaskMockUrl()
    }
    
    var lastURL: URL?
}

class DataTaskMockUrl: URLSessionDataTask {
    override func resume() { }
}



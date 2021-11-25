//
//  URLSessionProtocol.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 25/11/21.
//

import Foundation

/* A Protocol, when confromed by a class to make network calls. This protocol will help to write mocks to test the network layer.*/

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> ()
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}

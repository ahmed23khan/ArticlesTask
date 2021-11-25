//
//  ProviderProtocol.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 25/11/21.
//

import Foundation

/** A provider Protocol to send requests*/

protocol ProviderProtocol {
    func request<T>(type: T.Type, service: RequestProviding, completion: @escaping (NetworkResponse<T>) -> ()) where T : Decodable
}

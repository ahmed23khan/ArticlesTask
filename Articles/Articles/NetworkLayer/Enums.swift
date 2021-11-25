//
//  Enums.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 26/11/21.
//

import Foundation

enum Period : String  {
    case one = "1"
    case seven = "7"
    case thirty = "30"
}

enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError {
    case noJSONData
    case unknown
}

//
//  RequestEndPoint.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 25/11/21.
//

import Foundation

/**
 An Endpoint is created using the base URL, API Key and the period selected/
 */
protocol RequestProviding {
  var urlRequest: URLRequest { get }
}

extension Period: RequestProviding {
    
    var baseURL : String {
        return "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/"
    }
    
    var apiKey : String {
        return "ownB7L0w3Ak4ttSurYawrl7ccDuN52Tx"
    }
    
    var urlRequest: URLRequest {
        switch self {
        case .one:
            guard let url = URL(string: baseURL+"\(self.rawValue)"+".json?"+"api-key="+apiKey) else {
                preconditionFailure("Invalid URL used to create URL instance")
            }
            return URLRequest(url: url)
            
        case .seven:
            guard let url = URL(string: baseURL+"\(self.rawValue)"+".json?"+"api-key="+apiKey) else {
                preconditionFailure("Invalid URL used to create URL instance")
            }
            return URLRequest(url: url)
            
        case .thirty:
            guard let url = URL(string: baseURL+"\(self.rawValue)"+".json?"+"api-key="+apiKey) else {
                preconditionFailure("Invalid URL used to create URL instance")
            }
            return URLRequest(url: url)
        }
    }
}




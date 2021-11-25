//
//  URLSessionProvider.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 25/11/21.
//

import Foundation

/**
 URLSessionProvider conforms to ProviderProtocol. This approach is necessary to test network layer. It’s essential because in easy way you can switch session with mock file and simulate responses from API without internet connection.
 */


class URLSessionProvider : ProviderProtocol {
    
    private var session : URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session;
    }
    
    /// This method calls the 'dataTask' method of the NSUrlSession to make network call.
    func request<T>(type: T.Type, service: RequestProviding, completion: @escaping (NetworkResponse<T>) -> ()) where T : Decodable {
        let request = service.urlRequest
        
        let task = session.dataTask(request: request) { data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self.handleDataReponse(data: data, response: httpResponse, error: error, completiomHandler: completion)
        }
        task.resume()
    }
    
    /// Method to handle the response from the server.
    func handleDataReponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completiomHandler: (NetworkResponse<T>) -> ()) {
        guard error == nil else { return completiomHandler(.failure(.unknown))}
        guard let response = response else { return completiomHandler(.failure(.noJSONData))}

        switch response.statusCode {
        case 200...299:
            guard let data = data, let model = try? JSONDecoder().decode(T.self, from: data) else {
                return completiomHandler(.failure(.unknown))
            }
            completiomHandler(.success(model))
        default:
            completiomHandler(.failure(.unknown))
        }
    }
}

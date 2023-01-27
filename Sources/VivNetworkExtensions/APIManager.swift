//
//  APIManager.swift
//  
//
//  Created by Vivian Phung on 1/27/23.
//

import Foundation
import UIKit

// Note: This is my go to code for quick projects since high school (5 yrs ago)... needs to be refactored and tested

class APIManager {
    static let shared = APIManager()

    // force using shared instance
    private init() {}
    
    func networkRequest(baseURL: String, endpoint: Endpoint, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> URLRequest {
        var components = URLComponents(string: baseURL + endpoint.path)!
        guard let parameters = parameters else {
            return requestBuilder(url: components.url!, endpoint: endpoint, headers: headers)
        }
        components.queryItems = parameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }

        return requestBuilder(url: components.url!, endpoint: endpoint, headers: headers)
    }

    func requestBuilder(url: URL, endpoint: Endpoint, headers: [String: String]? = nil) -> URLRequest {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        headers?.forEach {
            request.addValue($1, forHTTPHeaderField: $0)
        }
        return request as URLRequest
    }

    func networkTask<T: Codable>(request: URLRequest, endpoint: Endpoint, completionHandler: @escaping (T?, Error?) -> Void) {
        let session: URLSession = URLSession.shared

        let task = session.dataTask(with: request) { data, _, error in
            guard let responseData = data, error == nil else {
                completionHandler(nil, error)
                return
            }

  
                let decoder = JSONDecoder()
                do {
                    let jsonData: T = try decoder.decode(T.self, from: responseData)
                    completionHandler(jsonData, nil)
                } catch let error { // catches decoding error from the try
                    completionHandler(nil, error)
                }
            

        }
        task.resume()
    }
}

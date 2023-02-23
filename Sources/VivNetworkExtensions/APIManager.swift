//
//  APIManager.swift
//  
//
//  Created by Vivian Phung on 1/27/23.
//

import Foundation
import UIKit

public protocol APIManager {
    func networkRequest(baseURL: String, endpoint: Endpoint, parameters: [String: Any]?, headers: [String: String]?) -> URLRequest
    func networkRequestBuilder(url: URL, endpoint: Endpoint, headers: [String: String]?) -> URLRequest
    func networkTask<T: Codable>(request: URLRequest, completionHandler: @escaping (Result<T, Error>) -> Void)
}

public class APIManagerImpl: APIManager {
    public lazy var session: URLSession = URLSession.shared

    public func networkRequest(baseURL: String, endpoint: Endpoint, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> URLRequest {
        var components = URLComponents(string: baseURL + endpoint.path)!
        guard let parameters = parameters else {
            return networkRequestBuilder(url: components.url!, endpoint: endpoint, headers: headers)
        }
        components.queryItems = parameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }

        return networkRequestBuilder(url: components.url!, endpoint: endpoint, headers: headers)
    }

    public func networkRequestBuilder(url: URL, endpoint: Endpoint, headers: [String: String]? = nil) -> URLRequest {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        headers?.forEach {
            request.addValue($1, forHTTPHeaderField: $0)
        }

        return request as URLRequest
    }

    public func networkTask<T: Codable>(request: URLRequest, completionHandler: @escaping (Result<T, Error>) -> Void) {
        let task = session.dataTask(with: request) { data, _, error in
            guard let responseData = data, error == nil else {
                completionHandler(.failure(error!))
                return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970

            do {
                let jsonData: T = try decoder.decode(T.self, from: responseData)
                completionHandler(.success(jsonData))
            } catch let error { // catches decoding error from the try
                completionHandler(.failure(error))
            }

        }
        task.resume()
    }
}

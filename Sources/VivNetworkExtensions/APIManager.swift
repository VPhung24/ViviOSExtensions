//
//  APIManager.swift
//  
//
//  Created by Vivian Phung on 1/27/23.
//

import Foundation
import UIKit

// Note: This is my go to code for quick projects since high school (5 yrs ago)... needs to be refactored and tested

public class APIManager {
    static public let shared = APIManager()
    
    // force using shared instance
    private init() {}

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
    
    public func networkTask<T: Codable>(request: URLRequest, completionHandler: @escaping (T?, Error?) -> Void) {
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
    
    public func networkResponseAsString(parameters: [String: Any], header: [String: String], url: String, endpoint: Endpoint, completionHandler: @escaping (String?, Error?) -> Void) {
        let urlRequest = networkRequest(baseURL: url, endpoint: endpoint, parameters: parameters, headers: header)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let responseData = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            if let returnData = String(data: responseData, encoding: .utf8) {
                completionHandler(returnData, nil)
            } else {
                completionHandler(nil, NetworkError.decodingDataToString)
            }
        }.resume()
    }
}

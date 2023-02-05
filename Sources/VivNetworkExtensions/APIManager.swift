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
    
    public func webSocketConnect(baseURL: String, endpoint: Endpoint, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> URLSessionWebSocketTask? {
        let session: URLSession = URLSession.shared
        let networkRequest = networkRequest(baseURL: baseURL, endpoint: endpoint, parameters: parameters, headers: headers)
        return session.webSocketTask(with: networkRequest)
    }
    
    public func decodeData<T: Codable>(_ data: Data, completionHandler: @escaping (T?, Error?) -> Void) {
        let decoder = JSONDecoder()
        
        if T.self == String.self, let returnData = String(data: data, encoding: .utf8), let responseData = returnData as? T {
            completionHandler(responseData, nil)
        } else if T.self == Data.self, let _ = UIImage(data: data), let responseData = data as? T {
            completionHandler(responseData, nil)
        }
        
        do {
            let jsonData: T = try decoder.decode(T.self, from: data)
            completionHandler(jsonData, nil)
        } catch let error { // catches decoding error from the try
            completionHandler(nil, error)
        }
    }
    
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
        
        let task = session.dataTask(with: request) { [weak self] data, _, error in
            guard let responseData = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            self?.decodeData(responseData) { (response: T?, error: Error?) in
                completionHandler(response, error)
            }
            
        }
        task.resume()
    }
    
}

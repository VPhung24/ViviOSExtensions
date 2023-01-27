//
//  PublishingNetworkManager.swift
//  
//
//  Created by Vivian Phung on 1/27/23.
//

import Foundation
import Combine

public struct ResultModel<InnerModel: Codable>: Identifiable, Codable {
    public let items: [InnerModel]
    public let id: UUID
}

public struct Network {

    func getInnerModelFromResult<InnerModel: Codable>(parameters: [String: Any], header: [String: String], url: String, endpoint: Endpoint) -> AnyPublisher<[InnerModel], Never> {
        
        let urlRequest: URLRequest = networkRequest(baseURL: url, endpoint: endpoint, parameters: parameters, headers: header)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: ResultModel<InnerModel>.self, decoder: JSONDecoder())
            .map(\.items)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    // MARK: - Networking
    public func networkRequest(baseURL: String, endpoint: Endpoint, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> URLRequest {
        var components = URLComponents(string: baseURL + endpoint.path)!
        guard let parameters = parameters else {
            return requestBuilder(url: components.url!, endpoint: endpoint, headers: headers)
        }
        components.queryItems = parameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
        
        return requestBuilder(url: components.url!, endpoint: endpoint, headers: headers)
    }
    
    public func requestBuilder(url: URL, endpoint: Endpoint, headers: [String: String]? = nil) -> URLRequest {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        headers?.forEach {
            request.addValue($1, forHTTPHeaderField: $0)
        }
        return request as URLRequest
    }
}

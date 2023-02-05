//
//  EndpointManager.swift
//  
//
//  Created by Vivian Phung on 1/27/23.
//

import Foundation

public enum Method: String {
    case GET
    case POST
}

public enum ContentType: String, CustomStringConvertible {
    case json = "application/json; charset=utf-8"
    case urlencoded = "application/x-www-form-urlencoded"
    
    public var description: String {
        get {
            return self.rawValue
        }
    }
    
    public var key: String {
        get {
            return "Content-Type"
        }
    }
    
    public init?(type: ContentType) {
        self.init(rawValue: type.rawValue)
        
        return nil
    }
}

public enum Accept: String, CustomStringConvertible {    
    case json = "application/json; charset=utf-8"

    public var description: String {
        get {
            return self.rawValue
        }
    }
    
    public var key: String {
        get {
            return "Accept"
        }
    }

    public init?(type: Accept) {
        self.init(rawValue: type.rawValue)
        return nil
    }
}

public protocol Header {
    var contentType: ContentType { get set }
    var accept: Accept { get set }
    
    init(contentType: ContentType, accept: Accept);
}

public protocol Endpoint {
    var path: String { get }
    var method: Method { get }
}


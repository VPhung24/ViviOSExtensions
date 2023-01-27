//
//  File.swift
//  
//
//  Created by Vivian Phung on 1/27/23.
//

import Foundation

public enum Method: String {
    case GET
    case POST
}

public protocol Endpoint {
    var path: String { get }
    var method: Method { get }
}


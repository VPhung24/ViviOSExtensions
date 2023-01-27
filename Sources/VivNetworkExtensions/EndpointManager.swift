//
//  File.swift
//  
//
//  Created by Vivian Phung on 1/27/23.
//

import Foundation

enum Method: String {
    case GET
    case POST
}

protocol Endpoint {
    var path: String { get }
    var method: Method { get }
}


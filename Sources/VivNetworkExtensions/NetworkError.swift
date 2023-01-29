//
//  NetworkError.swift
//  
//
//  Created by Vivian Phung on 1/27/23.
//

import Foundation

public enum NetworkError: Error {
    case imageError
    case bearerToken
    case decodingDataToString
}

//
//  AsyncDataFetcher.swift
//  
//
//  Created by Vivian Phung on 1/27/23.
//

import Foundation

public class AsyncDataFetcher: AsyncIteratorProtocol {
    public typealias Element = Data

    let chunkSize: Int
    let fileHandle: FileHandle

    init(url: URL, chunkSize: Int) throws {
        self.chunkSize = chunkSize
        fileHandle = try FileHandle(forReadingFrom: url)
    }

    deinit {
        fileHandle.closeFile()
    }

    public func next() async -> Data? {
        let data = fileHandle.readData(ofLength: chunkSize)
        return data.isEmpty ? nil : data
    }
}

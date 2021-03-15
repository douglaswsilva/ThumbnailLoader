//
//  ThumbnailLoaderProtocol.swift
//  ThumbnailLoaderExample
//
//  Created by Douglas on 15/03/21.
//

import Foundation

public protocol ThumbnailLoaderProtocol {
    typealias LoadResult = Swift.Result<Data, Error>
    typealias LoadCompletion = (LoadResult) -> Void
    
    func loadThumbnail(with url: URL, completion: @escaping LoadCompletion)
}

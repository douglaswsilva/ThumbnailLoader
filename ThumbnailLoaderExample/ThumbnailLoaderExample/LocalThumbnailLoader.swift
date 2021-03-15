//
//  LocalThumbnailLoader.swift
//  ThumbnailLoaderExample
//
//  Created by Douglas on 15/03/21.
//

import Foundation

public class LocalThumbnailLoader: ThumbnailLoaderProtocol {
    public init() { }
    
    public func loadThumbnail(with url: URL, completion: @escaping LoadCompletion) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard self != nil else { return }
            
            do {
                let data = try Data(contentsOf: url)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

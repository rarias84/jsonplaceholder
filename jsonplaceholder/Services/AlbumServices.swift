//
//  AlbumServices.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation
import Combine

enum AlbumServices {
    fileprivate static let manager = Manager()
    fileprivate static let base = URL(string: APISetup.basePath)!
    
    enum Paths {
        case albums
        case photos
        
        var path: String {
            switch self {
            case .albums:   return "albums"
            case .photos:   return "photos"
            }
        }
    }
}

extension AlbumServices {
    fileprivate static func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return manager.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }

    static func getAlbums() -> AnyPublisher<Albums, Error> {
        var request = URLRequest(url: base.appendingPathComponent(Paths.albums.path))
        request.allHTTPHeaderFields = APISetup.headers()
        return run(request)
    }
    
    static func getPhotos() -> AnyPublisher<Photos, Error> {
        var request = URLRequest(url: base.appendingPathComponent(Paths.photos.path))
        request.allHTTPHeaderFields = APISetup.headers()
        return run(request)
    }
}

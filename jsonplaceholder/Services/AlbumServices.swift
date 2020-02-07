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
    
    enum Paths {
        case albums(userId: String)
        case photos(id: String)
        
        var path: String {
            switch self {
            case .albums(let userId):   return "albums?userId=\(userId)"
            case .photos(let id):       return "photos?id=\(id)"
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

    static func getAlbums(with userId: String) -> AnyPublisher<Albums, Error> {
        var request = URLRequest(url: URL(string: APISetup.basePath + Paths.albums(userId: userId).path.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!)
        request.allHTTPHeaderFields = APISetup.headers()
        print(request)
        return run(request)
    }
    
    static func getPhotos(with id: String) -> AnyPublisher<Photos, Error> {
        var request = URLRequest(url: URL(string: APISetup.basePath + Paths.photos(id: id).path.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!)
        request.allHTTPHeaderFields = APISetup.headers()
        print(request)
        return run(request)
    }
}

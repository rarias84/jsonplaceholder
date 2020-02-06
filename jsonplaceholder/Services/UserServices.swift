//
//  UserServices.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation
import Combine

enum UserServices {
    fileprivate static let manager = Manager()
    fileprivate static let base = URL(string: APISetup.basePath)!
    
    enum Paths {
        case list
        
        var path: String {
            switch self {
            case .list:    return "users"
            }
        }
    }
}

extension UserServices {
    fileprivate static func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return manager.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }

    static func getUsers() -> AnyPublisher<Users, Error> {
        var request = URLRequest(url: base.appendingPathComponent(Paths.list.path))
        request.allHTTPHeaderFields = APISetup.headers()
        return run(request)
    }
    
    static func getUsersFav() -> AnyPublisher<Users, Error> {
        var request = URLRequest(url: base.appendingPathComponent(Paths.list.path))
        request.allHTTPHeaderFields = APISetup.headers()
        return run(request)
    }
}

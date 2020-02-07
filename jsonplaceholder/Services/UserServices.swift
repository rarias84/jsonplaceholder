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
    
    enum Paths {
        case list
        case user(id: String)
        
        var path: String {
            switch self {
            case .list:         return "users"
            case .user(let id): return "users?id=\(id)"
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
        var request = URLRequest(url: URL(string: APISetup.basePath + Paths.list.path.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!)
        request.allHTTPHeaderFields = APISetup.headers()
        return run(request)
    }
}

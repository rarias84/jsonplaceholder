//
//  APISetup.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation

struct APISetup {
    public static var basePath = "https://jsonplaceholder.typicode.com/"
    // MARK: - Headers
    static func headers() -> [String: String] {
        let headers = ["Content-Type": "application/json"]
        return headers
    }
}

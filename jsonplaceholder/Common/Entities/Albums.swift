//
//  Albums.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 04-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation

// MARK: - Album
struct Album: Codable {
    let userID, id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}

typealias Albums = [Album]

//
//  Photos.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 04-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
    let albumID, id: Int?
    let title: String?
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}

typealias Photos = [Photo]

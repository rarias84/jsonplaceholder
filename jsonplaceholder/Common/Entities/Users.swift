//
//  Users.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 04-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation

// MARK: - User
struct User: Codable {
    let id: Int?
    let name, username, email: String?
    let address: Address?
    let phone, website: String?
    let company: Company?
    var isFavorite: Bool? = false
    
//    init(id: Int, name: String, username: String, email: String, address: Address, phone: String, website: String, company: Company, isFavorite: Bool) {
//        self.id = id
//        self.name = name
//        self.username = username
//        self.email = email
//        self.address = address
//        self.phone = phone
//        self.website = website
//        self.company = company
//        self.isFavorite = isFavorite
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        username = try values.decodeIfPresent(String.self, forKey: .username)
//        email = try values.decodeIfPresent(String.self, forKey: .email)
//        address = try values.decodeIfPresent(Address.self, forKey: .address)
//        phone = try values.decodeIfPresent(String.self, forKey: .phone)
//        website = try values.decodeIfPresent(String.self, forKey: .website)
//        company = try values.decodeIfPresent(Company.self, forKey: .company)
//        isFavorite = try values.decodeIfPresent(Bool.self, forKey: .isFavorite)
//    }
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String?
    let geo: Geo?
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String?
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String?
}

typealias Users = [User]

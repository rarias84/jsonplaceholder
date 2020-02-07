//
//  AnyEncodable.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 07-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation

struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void

    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }

    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}

struct EmptyData: Decodable {}

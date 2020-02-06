//
//  Array+Extension.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation

extension Array {
    mutating func append(newElements: [Element]?) {
        for e in newElements ?? [] {
            self.append(e)
        }
    }
}

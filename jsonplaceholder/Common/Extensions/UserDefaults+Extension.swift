//
//  UserDefaults+Extension.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation

extension UserDefaults {
    func save<T: Encodable>(customObject object: T, inKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            self.set(encoded, forKey: key)
            print("-> did set model for key: \(key)")
        }
    }

    func retrieve<T: Decodable>(object type: T.Type, fromKey key: String) -> T? {
        if let data = self.data(forKey: key) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) {
                print("-> did retrieve model for key: \(key)")
                return object
            } else {
                print("-> Couldnt decode object for key: \(key)")
                return nil
            }
        } else {
            print("-> Couldnt find key: \(key)")
            return nil
        }
    }

    func removeStorage() {
        DispatchQueue.main.async(execute: {
            for key in UserDefaultsKeys.allCases {
                print(key)
                self.removeObject(forKey: key.rawValue)
            }
        })
    }
}

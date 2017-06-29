//
//  UsersInMemoryRepo.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

class UsersInMemoryDatasource {

    static let sharedInstance = UsersInMemoryDatasource()

    private var dataset: [String: User] = [:]

    func user(byId id: String) -> User? {
        return dataset[id]
    }

    func save(user: User) -> Bool {
        dataset[user.userId] = user
        return true
    }

    func saveAll(users: [User]) -> Bool {
        for user in users {
            dataset[user.userId] = user
        }
        return true
    }

    func delete(byId id: String) -> Bool {
        dataset[id] = nil
        return true
    }

    func all() -> [User] {
        return dataset.values.filter({ _ in true })
    }

}

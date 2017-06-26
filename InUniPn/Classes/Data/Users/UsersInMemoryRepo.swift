//
//  UsersInMemoryRepo.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

class UsersInMemoryRepo: UsersRepository {

    private var dataset: [String: User] = [:]

    func user(byId id: String) -> User? {
        return dataset[id]
    }

    func save(user: User) -> Bool {
        dataset[user.userId] = user
        return true
    }

    func delete(byId id: String) -> Bool {
        dataset[id] = nil
        return true
    }

}

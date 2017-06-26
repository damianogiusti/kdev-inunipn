//
//  UsersRepository.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

protocol UsersRepository: class {

    func user(byId id: String) -> User?

    func save(user: User) -> Bool

    func saveAll(users: [User]) -> Bool

    func delete(byId id: String) -> Bool

    func all() -> [User]
}

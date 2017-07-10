//
//  UsersRepoImpl.swift
//  InUniPn
//
//  Created by Damiano Giusti on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

class UsersRepoImpl: UsersRepository {

    private let storageDatasource = UsersRealmDatasource()

    func user(byId id: String) -> User? {
        return storageDatasource.obj(byId: id)
    }

    func all() -> [User] {
        return storageDatasource.all()
    }

    func save(user: User) -> Bool {
        return storageDatasource.save(obj: user)
    }

    func saveAll(users: [User]) -> Bool {
        return storageDatasource.saveAll(objects: users)
    }

    func delete(byId id: String) -> Bool {
        return storageDatasource.delete(byId: id)
    }
}

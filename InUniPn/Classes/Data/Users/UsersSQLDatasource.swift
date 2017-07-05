//
//  UsersSQLDatasource.swift
//  InUniPn
//
//  Created by Damiano Giusti on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

class UsersSQLDatasource {

    private let userIdPropertyName = "userId"

    private func findById(id: String) -> CDUser? {
        return CDUser.find(byId: id, named: userIdPropertyName)
    }

    func user(byId id: String) -> User? {
        return mapToUser(cdUser: findById(id: id))
    }

    func save(user: User) -> Bool {
        if let cdUser = mapToCDUser(user: user) {
            return cdUser.insert(andCommit: true)
        }
        return false
    }

    func saveAll(users: [User]) -> Bool {
        let result = users
            .flatMap({ user in findById(id: user.userId) })
            .reduce(true) { (previousResult, cdUser) in
                if !previousResult {
                    return false
                }
                return previousResult && cdUser.insert(andCommit: true)
        }

        return result
    }

    func delete(byId id: String) -> Bool {
        if let user = findById(id: id) {
            return user.remove(andCommit: true)
        }
        return false
    }

    func all() -> [User] {
        return CDUser.findAll().flatMap({ (user: CDUser) in mapToUser(cdUser: user) })
    }

    private func mapToUser(cdUser: CDUser?) -> User? {
        if let cdUser = cdUser {
            return UserFactory.user(withId: cdUser.userId ?? "",
                                    name: cdUser.displayName ?? "",
                                    email: cdUser.email ?? "",
                                    imageUrl: cdUser.imageUrl ?? "",
                                    universityCode: cdUser.university,
                                    andToken: cdUser.accessToken ?? "")
        }
        return nil
    }

    private func mapToCDUser(user: User?) -> CDUser? {
        if let user = user {
            let cdUser: CDUser = CDUser.createNew()
            cdUser.userId = user.userId
            cdUser.displayName = user.displayName
            cdUser.email = user.email
            cdUser.accessToken = user.accessToken
            cdUser.imageUrl = user.imageUrl
            cdUser.university = user.university
            return cdUser
        }
        return nil
    }
}

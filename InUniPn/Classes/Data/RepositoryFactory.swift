//
//  RepositoryFactory.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

class RepositoryFactory {

    static let usersRepository: UsersRepository = UsersInMemoryRepo()

    static let newsepositoruy: NewsRepository = NewsInMemoryRepo()

    static func universitiesRepository() -> UniversitiesRepository {
        return UniversitiesRepoImpl()
    }

    static func lessonsRepository(withToken token: String) -> LessonsRepository {
        return LessonsRepoImpl(withToken: token)
    }

}

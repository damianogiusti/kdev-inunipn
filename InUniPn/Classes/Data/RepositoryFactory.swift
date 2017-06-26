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

}

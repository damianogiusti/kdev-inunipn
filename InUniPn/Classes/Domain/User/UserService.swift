//
//  UserService.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

enum UserErrors: Error {
    case
    userNotPresent
}

class UserService {

    private let userRepository = RepositoryFactory.usersRepository

    /// Gets the current user of the application.
    /// If a success handler is specified, the operation will be asynchronous and return nil.
    /// The result will be delivered in the handler.
    @discardableResult
    func currentUser(onSuccess: SuccessBlock<User>? = nil, onError: ErrorBlock? = nil) -> User? {
        if let successBlock = onSuccess {
            runInBackground { [weak self] in
                if let user = self?.userRepository.all().first {
                    runOnUiThread {
                        successBlock(user)
                    }
                } else {
                    runOnUiThread {
                        onError?(UserErrors.userNotPresent)
                    }
                }
            }
            return nil
        } else {
            return userRepository.all().first
        }
    }


    /// Saves an user of the application.
    /// If a success handler is specified, the operation will be asynchronous and return nil.
    /// The result will be delivered in the handler.
    @discardableResult
    func save(user: User, onSuccess: SuccessBlock<User>? = nil, onError: ErrorBlock? = nil) -> User? {
        if let successBlock = onSuccess {
            runInBackground { [weak self] in
                if let success = self?.userRepository.save(user: user), success {
                    runOnUiThread {
                        successBlock(user)
                    }
                } else {
                    runOnUiThread {
                        onError?(UserErrors.userNotPresent)
                    }
                }
            }
            return nil
        } else {
            if userRepository.save(user: user) {
                return user
            } else {
                return nil
            }
        }
    }


    /// Deletes an user of the application.
    /// If a success handler is specified, the operation will be asynchronous and return nil.
    /// The result will be delivered in the handler.
    @discardableResult
    func delete(user: User, onSuccess: SuccessBlock<User>? = nil, onError: ErrorBlock? = nil) -> User? {
        if let successBlock = onSuccess {
            runInBackground { [weak self] in
                if let success = self?.userRepository.delete(byId: user.userId), success {
                    runOnUiThread {
                        successBlock(user)
                    }
                } else {
                    runOnUiThread {
                        onError?(UserErrors.userNotPresent)
                    }
                }
            }
            return nil
        } else {
            if userRepository.delete(byId: user.userId) {
                return user
            } else {
                return nil
            }
        }
    }
}

//
//  UsersRealmDatasource.swift
//  InUniPn
//
//  Created by Damiano Giusti on 05/07/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class UsersRealmDatasource: BaseRealmDatasource {

    typealias DM = DMUser
    typealias M = User

    func mapToDataModel(model: User?) -> DMUser? {
        if let user = model {
            let realmUser: DMUser = DMUser(withId: user.userId)
            realmUser.displayName = user.displayName
            realmUser.email = user.email
            realmUser.accessToken = user.accessToken
            realmUser.imageUrl = user.imageUrl
            realmUser.university = user.university
            return realmUser
        }
        return nil
    }

    func mapToModel(dataModel: DMUser?) -> User? {
        if let realmUser = dataModel {
            return UserFactory.user(withId: realmUser.userId,
                                    name: realmUser.displayName ?? "",
                                    email: realmUser.email ?? "",
                                    imageUrl: realmUser.imageUrl ?? "",
                                    universityCode: realmUser.university,
                                    andToken: realmUser.accessToken ?? "")
        }
        return nil
    }

}

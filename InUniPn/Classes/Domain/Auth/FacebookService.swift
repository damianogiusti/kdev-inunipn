//
//  FacebookService.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import SwiftyJSON

class FacebookService: BaseService, RestCapable {

    private let loginManager = FBSDKLoginManager()
    private static let facebookLoginOptions: [Any] = ["public_profile", "email"]

    func loginUser(withToken token: String, onSuccess: @escaping SuccessBlock<User>, onError: @escaping ErrorBlock) {

        let parameters = buildParameters(fromDictionary: [
            "access_token": token
        ])

        postRestCall(toUrl: AuthPaths.socialLogin.rawValue, withParams: parameters, onSuccess: { [weak self] json in
            self?.onUserLoggedIn(json: json, onSuccess: onSuccess, onError: onError)
        }, onError: onError)

    }


    func registerUser(withName name: String, andPassword password: String,
                      onSuccess: @escaping SuccessBlock<Any>, onError: @escaping ErrorBlock) {
        
    }

    private func onUserLoggedIn(json: JSON, onSuccess: @escaping SuccessBlock<User>, onError: @escaping ErrorBlock) {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"])
            .start { (connection, result, error) in
                
                debugPrint(result ?? "")
                if let error = error {
                    debugPrint(error.localizedDescription)
                } else if let result = result {
                    let user = UserFactory.user(fromJson: JSON.init(object: result), withToken: "")
                    debugPrint(user)
                    onSuccess(user)
                }
                // create user
        }
    }

}

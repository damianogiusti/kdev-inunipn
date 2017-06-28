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

        postRestCall(toUrl: Addresses.authFacebook.url(), withParams: parameters, onSuccess: { [weak self] json in
            self?.onUserLoggedIn(json: json, token: token, onSuccess: onSuccess, onError: onError)
        }, onError: onError)

    }


    func registerUser(withName name: String, andPassword password: String,
                      onSuccess: @escaping SuccessBlock<Any>, onError: @escaping ErrorBlock) {
        
    }

    private func onUserLoggedIn(json: JSON, token: String, onSuccess: @escaping SuccessBlock<User>, onError: @escaping ErrorBlock) {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"])
            .start { (connection, result, error) in
                
                debugPrint(result ?? "")
                if let error = error {
                    debugPrint(error.localizedDescription)
                } else if let result = result {
                    let fbJson = JSON.init(object: result)
                    let user = UserFactory.user(withId: json["id"].stringValue,
                                                name: fbJson[User.k_json_id].stringValue,
                                                email: fbJson[User.k_json_email].stringValue,
                                                imageUrl: fbJson[User.k_json_picture][User.k_json_picture_data][User.k_json_picture_url].stringValue,
                                                andToken: json["access_token"].stringValue)
                    //let user = UserFactory.user(fromJson: JSON.init(object: result), withToken: json[""].stringValue)
                    debugPrint(user)
                    
                    onSuccess(user)
                }
                // create user
        }
    }

}

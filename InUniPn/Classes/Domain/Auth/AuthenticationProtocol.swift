//
//  AuthenticationProtocol.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

protocol AuthenticationProtocol: class {

    func loginUser(withName name: String, andPassword password: String,
                   onSuccess: @escaping SuccessBlock<User>, onError: @escaping ErrorBlock)

    func socialLogin(withToken token: String, onSuccess: @escaping SuccessBlock<User>, onError: @escaping ErrorBlock)

    func registerUser(withName name: String, andPassword password: String,
                   onSuccess: @escaping SuccessBlock<Any>, onError: @escaping ErrorBlock)
}

//
//  RemotePaths.swift
//  InUniPn
//
//  Created by Damiano Giusti on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

enum Addresses: String {

    case
    authLogin = "/user/login",
    authRegistration = "/user/signup",
    authFacebook = "/user/facebook/login",

    lessons = "/timetable",
    news = "/posts",
    newsForPage = "/posts/%i",

    configUniversities = "/config"

    func url() -> String {
        switch self {
        case .configUniversities: return ApiConfig.defaultProtocol + ApiConfig.configApiUrl + self.rawValue

        default: return ApiConfig.defaultProtocol + ApiConfig.baseApiUrl + self.rawValue

        }
    }
}

fileprivate struct ApiConfig {

    static let defaultProtocol = "http://"
    static let baseApiUrl = "apiunipn.parol.in/V1"
    static let transportsApiUrl = "pn-transports.herokuapp.com/api/v1"
    static let configApiUrl = "damianogiusti.altervista.org/kdev"

}

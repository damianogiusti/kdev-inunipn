//
//  University.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

class University {

    let universityId: Int
    var code: String?
    var description: String?

    init(withId id: Int) {
        self.universityId = id
    }
}

class UniversityFactory {

    static func university(withId id: Int, code: String, andDescription desc: String) -> University {
        let uni = University(withId: id)
        uni.code = code
        uni.description = desc
        return uni
    }
}

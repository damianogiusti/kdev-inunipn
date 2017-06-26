//
//  LessonsRestDatasource.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Alamofire
import SwiftyJSON

class LessonsRestDatasource {

    private let token: String

    init(withToken token: String) {
        self.token = token
    }

    func all() -> [Lesson] {
        return []
    }

}

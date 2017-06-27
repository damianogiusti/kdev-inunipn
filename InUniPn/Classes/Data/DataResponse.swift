//
//  DataResponse.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

struct DataResponse<T> {
    var data: T?
    var error: Error?

    init(withData data: T) {
        self.data = data
    }

    init(withError error: Error) {
        self.error = error
    }
}

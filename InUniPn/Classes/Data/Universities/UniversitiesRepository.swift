//
//  UniversitiesRepository.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

protocol UniversitiesRepository: class {

    func all() -> DataResponse<[University]>

}

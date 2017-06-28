//
//  UniversitiesServices.swift
//  InUniPn
//
//  Created by Damiano Giusti on 27/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation
import SwiftyJSON

class UniversitiesServices: BaseService {

    private let universitiesRepository = RepositoryFactory.universitiesRepository()

    func all(onSuccess: @escaping SuccessBlock<[University]>, onError: @escaping ErrorBlock) {
        runInBackground { [weak self] in
            let response = self?.universitiesRepository.all()
            if let error = response?.error {
                runOnUiThread {
                    onError(error)
                }
            } else if let data = response?.data {
                runOnUiThread {
                    onSuccess(data)
                }
            }
        }
    }
}

//
//  UniversityInMemoryRepo.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation
import SwiftyJSON

enum UniversitiesPaths: String {
    case all = "http://damianogiusti.altervista.org/kdev/config/"
}

enum UniversitiesError: Error {
    case invalidResponse
}

class UniversitiesRepoImpl: UniversitiesRepository, RestCapable {

    func all() -> DataResponse<[University]> {

        let response = getRestCall(toUrl: UniversitiesPaths.all.rawValue, withParams: nil)
        if let json = response.data {
            return DataResponse(withData: mapToUniversity(json: json))
        } else if let error = response.error {
            // error
            return DataResponse(withError: error)
        }
        return DataResponse(withError: UniversitiesError.invalidResponse)
    }

    private func mapToUniversity(json: JSON) -> [University] {
        var unis: [University] = []
        if let array = json["universities"].array {
            for obj in array {
                let id = obj["id"].intValue
                let code = obj["code"].stringValue
                let desc = obj["description"].stringValue
                unis.append(UniversityFactory.university(withId: id, code: code, andDescription: desc))
            }

        }
        return unis
    }

}

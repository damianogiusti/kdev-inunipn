//
//  UniversityInMemoryRepo.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation
import SwiftyJSON

enum UniversitiesError: Error {
    case invalidResponse
}

class UniversitiesRepoImpl: UniversitiesRepository, RestCapable {

    private let kUniversities = "universities"
    private let prefs = UserDefaults.standard

    func all() -> DataResponse<[University]> {

        if let jsonString = prefs.string(forKey: kUniversities) {
            let json = JSON(parseJSON: jsonString)
            return DataResponse(withData: mapToUniversity(json: json))
        } else {
            let response = getRestCall(toUrl: Addresses.configUniversities.url(), withParams: nil)
            if let json = response.data {
                prefs.setValue(json.rawString(), forKey: kUniversities)
                return DataResponse(withData: mapToUniversity(json: json))
            } else if let error = response.error {
                // error
                return DataResponse(withError: error)
            }
            return DataResponse(withError: UniversitiesError.invalidResponse)
        }


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

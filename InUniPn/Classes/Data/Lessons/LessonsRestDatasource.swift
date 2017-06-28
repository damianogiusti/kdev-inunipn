//
//  LessonsRestDatasource.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Alamofire
import SwiftyJSON

class LessonsRestDatasource: RestCapable {

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "it_IT")
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ"
        return dateFormatter
    }()

    private let token: String

    init(withToken token: String) {
        self.token = token
    }

    func all() -> DataResponse<[Lesson]> {

        let response = getRestCall(toUrl: Addresses.lessons.url(), withParams: nil, token: token)
        if let json = response.data {
            let lessons = self.parseLessons(from: json)
            return DataResponse(withData: lessons)
        } else if let error = response.error {
            return DataResponse(withError: error)
        }
        return DataResponse(withError: RestError.apiError)
    }

    private func parseLessons(from json: JSON) -> [Lesson] {
        var lessons: [Lesson] = []
        let days = json["month"].arrayValue
        for day in days {
            let classes = day["classes"].arrayValue
            for c in classes {
                let lesson = Lesson(withId: "\(c["class_id"].intValue)")
                lesson.name = c["name"].stringValue
                lesson.teacher = c["prof"].stringValue
                lesson.classroom = c["class"].stringValue
                lesson.date = dateFormatter.date(from: c["date"].stringValue)
                lesson.timeStart = dateFormatter.date(from: c["time_start"].stringValue)
                lesson.timeEnd = dateFormatter.date(from: c["time_end"].stringValue)
                lesson.course = c["course"].stringValue
                lesson.area = c["area"].intValue
                lessons.append(lesson)
            }
        }
        return lessons
    }

    /*
 "month": [
     {
         "day": "2017-06-28T00:00:00.000Z",
         "classes": [
             {
                 "class_id": 183043,
                 "name": "tsam - project work",
                 "prof": "Damiano Buscemi",
                 "class": "Lab. ITS (L3)",
                 "date": "2017-06-28T00:00:00.000Z",
                 "time_start": "2017-06-28T09:00:00.000Z",
                 "time_end": "2017-06-28T13:00:00.000Z",
                 "course": "I.T.S.",
                 "area": 5
             }
         ]
    }
 */

}

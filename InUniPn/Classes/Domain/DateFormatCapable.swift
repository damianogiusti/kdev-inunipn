//
//  DateFormatCapable.swift
//  InUniPn
//
//  Created by Damiano Giusti on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

protocol DateFormatCapable: class {

    func dateFromString(isoTimestamp timestamp: String) -> Date?

}

extension DateFormatCapable {

    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "it_IT")
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ"
        return dateFormatter
    }

    func dateFromString(isoTimestamp timestamp: String) -> Date? {
        // normalize date required due to a bad API
        if !timestamp.contains(".") {
            return dateFormatter.date(from: timestamp.appending(".000Z"))
        }
        return dateFormatter.date(from: timestamp)
    }
}

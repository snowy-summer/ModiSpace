//
//  DateManager.swift
//  ModiSpace
//
//  Created by 최승범 on 11/2/24.
//

import Foundation

final class DateManager {
    
   private let dateFormatter = DateFormatter()
    
    func date(from isoString: String) -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime,
                                      .withFractionalSeconds]
        return isoFormatter.date(from: isoString)
    }
    
    func string(from date: Date,
                format: String = "hh:mm a") -> String {
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    
    func convertToFormattedString(isoString: String,
                                  format: String = "hh:mm a") -> String? {
        guard let date = date(from: isoString) else { return nil }
        return string(from: date, format: format)
    }
}

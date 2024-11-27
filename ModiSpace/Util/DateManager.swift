//
//  DateManager.swift
//  ModiSpace
//
//  Created by 최승범 on 11/2/24.
//

import Foundation

final class DateManager {
    
    private let inputDateFormatter: DateFormatter
    private let shortDateFormatter: DateFormatter
    private let yearDateFormatter: DateFormatter
    private let shortTimeFormatter: DateFormatter
    
    init() {
        self.inputDateFormatter = DateFormatter()
        self.inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        self.inputDateFormatter.timeZone = TimeZone.current
        
        self.shortDateFormatter = DateFormatter()
        self.shortDateFormatter.dateFormat = "MM월 dd일"
        self.shortDateFormatter.locale = Locale(identifier: "ko_KR")
        
        self.yearDateFormatter = DateFormatter()
        self.yearDateFormatter.dateFormat = "yyyy.MM.dd"
        self.yearDateFormatter.locale = Locale(identifier: "ko_KR")
        
        self.shortTimeFormatter = DateFormatter()
        self.shortTimeFormatter.dateFormat = "a hh:mm"
        self.shortTimeFormatter.locale = Locale(identifier: "ko_KR")
        self.shortTimeFormatter.timeZone = TimeZone.current
    }
    
    func date(from isoString: String) -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime,
                                      .withFractionalSeconds]
        return isoFormatter.date(from: isoString)
    }
    
    func string(from date: Date,
                format: String = "hh:mm a") -> String {
        inputDateFormatter.dateFormat = format
        inputDateFormatter.timeZone = TimeZone.current
        return inputDateFormatter.string(from: date)
    }
    
    func convertToFormattedString(isoString: String,
                                  format: String = "hh:mm a") -> String? {
        guard let date = date(from: isoString) else { return nil }
        return string(from: date, format: format)
    }
    
    func formattedTime(from dateString: String) -> String {
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = inputDateFormatter.date(from: dateString) {
            return shortTimeFormatter.string(from: date)
        } else {
            return dateString
        }
    }

    func formattedDate(from dateString: String) -> String {
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = inputDateFormatter.date(from: dateString) {
            return shortDateFormatter.string(from: date)
        } else {
            return dateString
        }
    }
    
    func relativeFormattedTime(from dateString: String) -> String {
        guard let date = date(from: dateString) else { return dateString }
        
        let now = Date()
        let interval = now.timeIntervalSince(date)
        
        if interval < 60 {
            return "방금 전"
        } else if interval < 3600 {
            let minutes = Int(interval / 60)
            return "\(minutes)분 전"
        } else if interval < 86400 {
            let hours = Int(interval / 3600)
            return "\(hours)시간 전"
        } else if interval < 172800 {
            return "하루 전"
        } else if interval < 31536000 {
            return shortDateFormatter.string(from: date)
        } else {
            return yearDateFormatter.string(from: date)
        }
    }
    
}

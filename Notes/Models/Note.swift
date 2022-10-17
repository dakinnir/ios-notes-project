//
//  Note.swift
//  Notes
//
//  Created by Daniel Akinniranye on 10/14/22.
//

import Foundation

struct Note {
    var notes: String
    // var dateCreated: Date?
    var lastModified: Date? = Date()
    
    /// Return the hour and minute if the current date is the same day as the last modifed day value, day of the week if the date is within the same week otherwise return the full date & year
    var dateDescription: String {
        if let dateModified = lastModified {
            let dateFormatter = DateFormatter()
            if Calendar.current.isDateInToday(dateModified) {
                dateFormatter.dateFormat = "h:mm a" /// 11:50 PM
            } else if (Calendar.current.isDateInThisWeek(dateModified)) {
                dateFormatter.dateFormat = "EEEE" /// Friday
            } else {
                dateFormatter.dateFormat = "EEEE, MMM d, yyyy" /// Friday, Oct 6, 2022
            }
            return dateFormatter.string(from: dateModified)
        }
        return ""
    }
    
    var title: String {
        return notes.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? "" // returns the first line of the text
    }
        
    var desc: String {
        var lines = notes.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        print(lines)
        lines.removeFirst()
        return "\(lines.first ?? "")" // return second line
    }
}

extension Calendar {
    
    private var currentDate: Date { return Date() }

    func isDateInThisWeek(_ date: Date) -> Bool {
        return isDate(date, equalTo: currentDate, toGranularity: .weekOfYear)
      }
}

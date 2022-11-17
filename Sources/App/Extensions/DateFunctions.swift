//
//  File.swift
//  
//
//  Created by Michael Welch on 11/16/22.
//

import Foundation

// let dateExample = Date()+3600.0*8
// print("dateExample: \(dateExample)")
// let string = dateExample.toString(format: "MM/dd/yyyy hh:mm:ss Z")
// print("string: \(string)")
// let date = string.toDate(format: "MM/dd/yyyy hh:mm:ss Z")
// print("date: \(date)")

extension Date {

    /// Convert  a date (UTC) to a string (local zone)
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension String {

    /// Convert a string (local zone) to a date (UTC)
    func toDate(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)!
    }
}

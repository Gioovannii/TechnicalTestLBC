//
//  Date formatter + String.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/8.
//

import Foundation
 
extension DateFormatter {
    
    static func getDateToString(from: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd', 'HH:mm:ss ZZZZZ "
        
        return dateFormatter.string(from: from)
    }
    
    
    static func getDateFromString(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Format of json
        guard let date = dateFormatter.date(from: date) else { fatalError(#function, file: #file, line: #line) }

        return date
    }
}


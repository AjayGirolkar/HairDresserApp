//
//  Extensions.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 11/03/23.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Double {
    
    func convertToString(decimal: Int = 2) -> String {
        let string = String(format: "%.2f", self)
        return string
    }
    
}

extension String {
    func convertToTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        guard let date = dateFormatter.date(from: self) else { return Date() }
        return date
    }
}

extension Date {
    
    func toString() -> String {
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date/Time Style
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none //.short =  4:42 PM

        // Convert Date to String
        let dateString = dateFormatter.string(from: self) // April 19, 2023
        return dateString
    }
    
    func convertToTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        let time = dateFormatter.string(from: self)
        return time
    }
    
    func dateAfterDay(count: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: count, to: self)
    }
    
    //[.day, .month, .year]
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    
    func getMonth(wide: Bool = false) -> String {
        if wide {
            return self.formatted(.dateTime.month(.wide)) // Output: August
        } else {
            return self.formatted(.dateTime.month()) // Output: Aug
        }
    }
    
    func getDayName(fullname: Bool = false) -> String{
        if fullname {
            return self.formatted(.dateTime.weekday(.wide))  // Output: Friday
        } else {
            return self.formatted(.dateTime.weekday())  // Output: Fri
        }
    }
    
    func getMonthAndDate() -> String {
        return self.formatted(.dateTime.day().month()) // Output: Aug 20
    }
    
    func getMonthDateAndYear() -> String {
        return self.formatted(.dateTime.day().month().year()) // Output: Aug 20, 2021
    }
    
    func getDateNumber() -> String {
        return  self.formatted(.dateTime.day())
    }
    
    //5,6,7
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    // Wednesday
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
    
    //April
    func nameOfMonth() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self).capitalized
    }
}

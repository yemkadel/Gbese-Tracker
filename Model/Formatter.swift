//
//  Formatter.swift
//  Gbese Tracker
//
//  Created by Osifeso Adeyemi on 23/02/2021.
//

import Foundation

struct Formatter {
    static let formatter = DateFormatter()
    static let nFormatter = NumberFormatter()
    
    init() {
        Formatter.formatter.locale = .current
        Formatter.formatter.timeZone = .current
        Formatter.nFormatter.locale = Locale.current
        Formatter.nFormatter.numberStyle = .currency
    }
    
    static func longDateToString(from date: Date) ->String{
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: date)
    }
    
    static func shortDateToString(from date: Date) ->String{
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
    
    static func formatAmountToString(from amount: Float, withCurrency symbol: Bool) -> String{
        if symbol {
            nFormatter.numberStyle = .currency
        } else {
            nFormatter.numberStyle = .decimal
        }
        return nFormatter.string(for: amount as Float)!
    }
    
    static func formatAmountForTextField(amt: Int = 0) -> String?{
        
        let number = Double(amt/100) + Double(amt%100)/100
        return nFormatter.string(from: NSNumber(value: number))
    }
    
    static func formatToFloat(from str: String, withCurrency symbol: Bool) -> Float?{
        if symbol {
            nFormatter.numberStyle = .currency
        } else {
            nFormatter.numberStyle = .decimal
        }
        let number = nFormatter.number(from: str)
        return number!.floatValue
    }
    
    static func formatToInteger(from str: String, withCurrency symbol: Bool) -> Int?{
        if symbol {
            nFormatter.locale = Locale.current
            nFormatter.numberStyle = .currency
        } else {
            nFormatter.numberStyle = .decimal
        }
        let number = nFormatter.number(from: str)
        return number!.intValue
    }
    
    static func numberOfDaysLeftFor(gbese: Debt) -> Int {
        let calendar = NSCalendar.current

        // Replace the hour (time) of both dates with 00:00
        let lendDate = calendar.startOfDay(for: gbese.dateCreated)
        let returnDate = calendar.startOfDay(for: gbese.returnDate)

        let components = calendar.dateComponents([.day], from: lendDate, to: returnDate)
        return components.day!
    }
}

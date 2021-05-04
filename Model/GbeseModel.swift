//
//  GbeseModel.swift
//  Gbese Tracker
//
//  Created by Osifeso Adeyemi on 21/02/2021.
//

import Foundation
import CoreData
import UserNotifications
import UIKit

struct GbeseModel  {
   private static let center = UNUserNotificationCenter.current()
    
    static func setReminder(for gbese: Debt){
        let borrower = gbese.person
        let amount = Formatter.formatAmountToString(from: gbese.amount, withCurrency: true)
        let returnDate = gbese.returnDate
        center.requestAuthorization(options: [.alert,.badge,.sound]) { (success, error) in
            if success {
                let content = UNMutableNotificationContent()
                content.title = "Gbese Reminder"
                content.body = "\(borrower) is suppose to pay you \(amount) today...Ring the Motherfucker "
                content.sound = .default
                
                let triggerDate = returnDate
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: triggerDate), repeats: false)
                let request = UNNotificationRequest(identifier: "reminder-\(borrower)-\(gbese.dateCreated)", content: content, trigger: trigger)
                center.add(request) { (error) in
                    guard error == nil else { return }
                }
            }
        }
        
    }
    
    static func deleteReminder(for gbese: Debt){
        let borrower = gbese.person
        let date = gbese.dateCreated
        let identifier = "reminder-\(borrower)-\(date)"
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    struct RoundView {
        var object: AnyObject
        
        init(object: AnyObject) {
            self.object = object
            self.object.layer.cornerRadius = 0.5 * self.object.bounds.size.width
        }
        
        func returnbutton() -> AnyObject{
            return object
        }
    }
    
    struct curveAllEdges {
        var object: AnyObject
        
        init(object: AnyObject) {
            self.object = object
            self.object.layer?.cornerRadius = 5.0
        }
    }
    
    struct curveTwoEdges {
        var object: AnyObject
        
        init(object: AnyObject, edges: CACornerMask,cornerRadius: CGFloat) {
            self.object = object
            object.layer!.cornerRadius = cornerRadius
            object.layer!.maskedCorners = edges
        }
    }
}

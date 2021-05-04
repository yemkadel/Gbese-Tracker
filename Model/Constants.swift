//
//  Constants.swift
//  Gbese Tracker
//
//  Created by Osifeso Adeyemi on 06/03/2021.
//

import Foundation

struct Constants {
    
    struct K {
        static let gbese = "Gbese"
        static let gbeseList = "Gbese List"
        static let loginFailed = "Login Failed"
        static let tabView = "TabView"
        static let history = "History"
        static let lend = "lend"
        static let borrow = "borrow"
        static let borrower = "Borrower"
        static let lender = "Lender"
        static let edit = "Edit"
        static let save = "Save"
        static let comma = ","
        static let emptyString = ""
        static let space = " "
        static let paid = "Paid"
        static let ok = "Ok"
        static let action1 = "action1"
        static let Warning = "Warning !!!"
        static let action2 = "action2"
        static let action3 = "action3"
        static let lendMoney = "Lend Money"
        static let borrowMoney = "Borrow Money"
        static let cancel = "Cancel"
        static let Select = "Select"
        static let greenUpArrow = "greenUpArrow"
        static let redUpArrow = "redUpArrow"
        static let greenDownArrow = "greenDownArrow"
        static let redDownArrow = "redDownArrow"
        static let delete = "delete"
        static let trash = "trash"
        static let addGbeseViewController = "AddGbeseViewController"
        static let detailsViewController = "DetailsViewController"
        static let addAlertMessage = "Select either of the two options"
        static let deleteAlertMessage = "Are you sure you want to delete this Gbese?"
        static let gbeseViewCell = "GbeseViewCell"
        static let gbeseCell = "gbeseCell"
        static let gbeseTrackerController = "GbeseTrackerController"
        static let historyViewCell = "HistoryViewCell"
        static let historyCell = "historyCell"
        static let gbeseDetails = "Gbese Details"
        static let lendDate = "lendDate"
        static let dateCreated = "dateCreated"
        static let deleteAlertMessage2 = "You are about to delete an important gbese!!!"
        static let historyHeader = "Date           Borrower                          Amount       Status"
        static let ten = 10
        static let one = 1
        static let zero = 0
        static let zeroInDecimal = 0.00
        static let hundred = 100
        
    }
    
    struct PostGbese {
        static let amount = "amount"
        static let lendDate = "lendDate"
        static let person = "person"
        static let reason = "reason"
        static let type = "type"
        static let returnDate = "returnDate"
        static let paid = "paid"
        static let autoID = "autoID"
    }
    
    struct PostHistory {
        static let amount = "amount"
        static let dateCreated = "dateCreated"
        static let person = "person"
        static let type = "type"
        static let paid = "paid"
        static let autoID = "autoID"
    }
}

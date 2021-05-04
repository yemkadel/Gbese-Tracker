//
//  Debt.swift
//  Gbese Tracker
//
//  Created by Osifeso Adeyemi on 08/04/2021.
//

import Foundation
import RealmSwift

class Debt: Object {
    @objc dynamic var amount: Float = 0.0
    @objc dynamic var autoID: Int = 0
    @objc dynamic var dateCreated: Date = Date()
    @objc dynamic var paid: Bool = false
    @objc dynamic var person: String = ""
    @objc dynamic var returnDate: Date = Date()
    @objc dynamic var type: String = ""
    
}

//
//  GbeseViewCell.swift
//  Gbese Tracker
//
//  Created by Osifeso Adeyemi on 21/02/2021.
//

import UIKit

class GbeseViewCell: UITableViewCell {

    @IBOutlet weak var gbeseType: UIImageView!
    @IBOutlet weak var dateCreatedlabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var daysLeftView: GbeseViewCell!
    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var daysleftTextLabel: UILabel!
    @IBOutlet weak var paidLabel: UILabel!
    @IBOutlet weak var paidImage: UIImageView!
    
    var gbese: Debt!
    var dataController: DataController!
    
}

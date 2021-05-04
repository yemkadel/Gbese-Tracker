//
//  SelectGbeseViewController.swift
//  Gbese Tracker
//
//  Created by Osifeso Adeyemi on 02/04/2021.
//

import UIKit
import RealmSwift

class SelectGbeseViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var lendView: UIView!
    @IBOutlet weak var borrowView: UIView!
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = GbeseModel.curveAllEdges(object: lendView)
        _ = GbeseModel.curveAllEdges(object: borrowView)
        
        let lendTapGesture = UITapGestureRecognizer(target: self, action: #selector(lendViewClicked(_:)))
        let borrowTapGesture = UITapGestureRecognizer(target: self, action: #selector(borrowViewClicked(_:)))
        
        lendTapGesture.delegate = self
        borrowTapGesture.delegate = self
        lendView.addGestureRecognizer(lendTapGesture)
        borrowView.addGestureRecognizer(borrowTapGesture)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        let gbeseListVC = storyboard?.instantiateViewController(identifier: "GbeseListViewController") as! GbeseListViewController
        gbeseListVC.realm = realm
        navigationController?.pushViewController(gbeseListVC, animated: true)
//        dismiss(animated: true, completion: nil)
    }
    
    @objc func lendViewClicked(_ sender: UIView) {
        moveToAddGbese(isGbeseType: true)
    }
    
    @objc func borrowViewClicked(_ sender: UIView) {
        moveToAddGbese(isGbeseType: false)
    }
    
    func moveToAddGbese(isGbeseType status: Bool){
        let addGbeseVC = storyboard?.instantiateViewController(identifier: "AddGbeseViewController") as! AddGbeseViewController
        addGbeseVC.realm = realm
        addGbeseVC.gbeseTypeIsLend = status
        navigationController?.pushViewController(addGbeseVC, animated: true)
    }

}

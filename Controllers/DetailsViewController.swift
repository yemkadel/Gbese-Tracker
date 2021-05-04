//
//  DetailsViewController.swift
//  Gbese Tracker
//
//  Created by Osifeso Adeyemi on 23/02/2021.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var borrowerName: UILabel!
    @IBOutlet weak var amountText: UILabel!
    @IBOutlet weak var borrowDate: UILabel!
    @IBOutlet weak var returnDate: UILabel!
   // @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var AmountDetailsView: UIView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var paidButton: UIButton!
    @IBOutlet weak var borrowLendText: UILabel!
    @IBOutlet weak var paymentStatusView: UIView!
   // @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var paymentStatusLabel: UILabel!
    //@IBOutlet weak var emptyView: UIView!
    
    var realm: Realm!
    var gbese: Debt!
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = Constants.K.gbeseList
        borrowerName.text = gbese.person
        if gbese.type == "lend" {
            borrowLendText.text = "Date lent"
        }
        isGbesePaid(gbese.paid)
        amountText.text = Formatter.formatAmountToString(from: gbese.amount, withCurrency: true)
        borrowDate.text = Formatter.shortDateToString(from: gbese.dateCreated)
        returnDate.text = Formatter.shortDateToString(from: gbese.returnDate)
        
        _ = GbeseModel.curveAllEdges(object: editButton)
        _ = GbeseModel.curveAllEdges(object: paidButton)
        _ = GbeseModel.curveTwoEdges(object: AmountDetailsView, edges: [.layerMinXMinYCorner,.layerMaxXMinYCorner], cornerRadius: 10)
        //_ = GbeseModel.curveTwoEdges(object: detailsView, edges: [.layerMinXMinYCorner,.layerMaxXMinYCorner], cornerRadius: 10)
        _ = GbeseModel.curveTwoEdges(object: paymentStatusView, edges: [.layerMinXMaxYCorner,.layerMaxXMaxYCorner], cornerRadius: 10)
        _ = GbeseModel.curveTwoEdges(object: view, edges: [.layerMinXMaxYCorner,.layerMaxXMaxYCorner], cornerRadius: 10)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }

    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }

        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)

        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    func isGbesePaid(_ status: Bool) {
        editButton.isHidden = status
        paidButton.isHidden = status
        if status {
            paymentStatusLabel.text = "Paid"
            paymentStatusLabel.textColor = .systemGreen
        }
    }
    
    //MARK:- Buttons
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: Constants.K.Warning, message: Constants.K.deleteAlertMessage2, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Constants.K.cancel, style: .default, handler: nil))
                                      alert.addAction(UIAlertAction(title: Constants.K.ok, style: .destructive, handler: { (action) in
        self.realm.delete(self.gbese)
        let gbeseListVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.K.gbeseTrackerController) as! GbeseListViewController
        gbeseListVC.realm = self.realm
        self.navigationController?.pushViewController(gbeseListVC, animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func editButtonIsPressed(_ sender: Any) {
        let editGbeseVC = storyboard?.instantiateViewController(withIdentifier: Constants.K.addGbeseViewController) as! AddGbeseViewController
        editGbeseVC.gbese = gbese
        editGbeseVC.realm = realm
        editGbeseVC.isEditState = true
        navigationController?.pushViewController(editGbeseVC, animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        //dismiss(animated: true, completion: nil)
        view.removeFromSuperview()
    }
    
    func goToList(){
        print("i am here")
        let gbeseListVC = storyboard?.instantiateViewController(identifier: "GbeseListViewController") as! GbeseListViewController
        gbeseListVC.realm = realm
        present(gbeseListVC, animated: true, completion: nil)
        //navigationController?.pushViewController(gbeseListVC, animated: true)
    }
    
    @IBAction func paidButtonPressed(_ sender: Any) {
        let amount = Formatter.formatAmountToString(from: gbese.amount, withCurrency: true)
        Alert.confirmationAlert(on: self, action1: Constants.K.cancel, action2: Constants.K.ok, alertTitle: Constants.K.Warning, alertMessage: "Are you sure \(gbese.person) has paid you a sum of \(amount)?") { (action) in
            if action == Constants.K.action2 {
                GbeseModel.deleteReminder(for: self.gbese)
                let debts = self.realm.objects(Debt.self)
                do {
                    try self.realm.write {
                        for debt in debts {
                            debt.autoID = debt.autoID + 1
                        }
                        self.gbese.autoID = 1
                        self.gbese.paid = true
                        self.goToList()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
}

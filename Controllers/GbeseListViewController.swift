//
//  GbeseListViewController.swift
//  Gbese Tracker
//
//  Created by Osifeso Adeyemi on 21/02/2021.
//

import UIKit
import RealmSwift

class GbeseListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addDebt: UIButton!
    var debts: Results<Debt>!
    var realm: Realm!
   
    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        debts = realm.objects(Debt.self).sorted(byKeyPath: "autoID", ascending: false)
        setUpTableView()
        _ = GbeseModel.RoundView(object: addDebt)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("LIST appeard")
        debts = realm.objects(Debt.self).sorted(byKeyPath: "autoID", ascending: false)
        tableView.reloadData()
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.K.gbeseViewCell, bundle: nil), forCellReuseIdentifier: Constants.K.gbeseCell)
        tableView.reloadData()
    }
    
    //MARK:- Buttons
    @IBAction func addGbeseButtonPressed(_ sender: UIButton) {
        let selectVC = storyboard?.instantiateViewController(identifier: "SelectGbeseViewController") as! SelectGbeseViewController
        selectVC.realm = realm
        navigationController?.pushViewController(selectVC, animated: true)
    }
}

//MARK:- Tableview DataSource
extension GbeseListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return debts.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let verticalPadding: CGFloat = 8
//
//            let maskLayer = CALayer()
//            maskLayer.backgroundColor = UIColor.black.cgColor
//            maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
//            cell.layer.mask = maskLayer
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.K.gbeseCell, for: indexPath) as! GbeseViewCell
        let gbese = debts[indexPath.section]
        cell.gbese = gbese
        cell.nameLabel.text = gbese.person
        let dateCreated = Formatter.shortDateToString(from: gbese.dateCreated)
        let amount = gbese.amount
        cell.amountLabel.text = Formatter.formatAmountToString(from: amount, withCurrency: true)
        cell.dateCreatedlabel.text = "Created on \(dateCreated)"
        cell.daysLeftLabel.text = "\(Formatter.numberOfDaysLeftFor(gbese: gbese))"
        print("the autoID: \(gbese.autoID)")
        if gbese.type == Constants.K.lend {
            cell.gbeseType.image = UIImage(named: "lendIcon")
            cell.amountLabel.textColor = #colorLiteral(red: 0.999968946, green: 0.7103325129, blue: 0.2453288138, alpha: 1)
        } else {
            cell.gbeseType.image = UIImage(named: "borrowIcon")
            cell.amountLabel.textColor = #colorLiteral(red: 1, green: 0.4140899181, blue: 0.4655743837, alpha: 1)
        }
        isGbesePaid(gbese.paid, for: cell)
        _ = GbeseModel.curveTwoEdges(object: cell.infoView, edges: [.layerMinXMinYCorner], cornerRadius: 30)
        _ = GbeseModel.curveTwoEdges(object: cell.daysLeftView, edges: [.layerMaxXMaxYCorner], cornerRadius: 30)
        cell.infoView.layer.cornerRadius = 30
        return cell
    }
    
    func isGbesePaid(_ status: Bool,for cell: GbeseViewCell) {
        cell.daysLeftLabel.isHidden = status
        cell.daysleftTextLabel.isHidden = status
        cell.paidLabel.isHidden = !status
        cell.paidImage.isHidden = !status
    }
}

//MARK:- Tableview Delegates
extension GbeseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gbese = debts[indexPath.section]
        let gbeseDetailsVC = DetailsView()
        gbeseDetailsVC.gbese = gbese
        gbeseDetailsVC.realm = realm
        gbeseDetailsVC.transitioningDelegate = self
        gbeseDetailsVC.modalPresentationStyle = .custom
        self.present(gbeseDetailsVC, animated: true, completion: nil)
//        addChild(gbeseDetailsVC)
//        gbeseDetailsVC.view.frame = self.view.frame
//        view.addSubview(gbeseDetailsVC.view)
//        gbeseDetailsVC.didMove(toParent: self)

    }
    
    //MARK:- Pay Action
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let gbese = self.debts[indexPath.row]
        let paid = UIContextualAction(style: .normal, title: Constants.K.paid) { (action, view, completion) in
            let amount = Formatter.formatAmountToString(from: gbese.amount, withCurrency: true)
            Alert.confirmationAlert(on: self, action1: Constants.K.cancel, action2: Constants.K.ok, alertTitle: Constants.K.Warning, alertMessage: "Are you sure \(gbese.person) has paid you a sum of \(amount)?") { (action) in
                if action == Constants.K.action2 {
                    //self.db.collection(Constants.K.gbese).document(gbese.lendDate!.description).delete()
                    GbeseModel.deleteReminder(for: gbese)
                    let debts = self.realm.objects(Debt.self)
                    do {
                        try self.realm.write {
                            for debt in debts {
                                debt.autoID = debt.autoID + 1
                            }
                            gbese.paid = true
                            gbese.autoID = 1
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                tableView.reloadData()
            }
        }
        paid.backgroundColor = .white
        paid.image = UIImage(named: Constants.K.paid)
        if gbese.paid {
            return nil
        } else {
            return UISwipeActionsConfiguration(actions: [paid])
        }
        
    }
    
    //MARK:- Delete Action
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: Constants.K.delete) { (action, view, completion) in
            let gbese = self.debts[indexPath.row]
            Alert.confirmationAlert(on: self,action1: Constants.K.cancel, action2: Constants.K.ok, alertTitle: Constants.K.Warning, alertMessage: Constants.K.deleteAlertMessage) { (action) in
                if action == Constants.K.action2 {
                    do {
                        try self.realm.write {
                            self.realm.delete(gbese)
                        }
                    }catch {
                        print(error.localizedDescription)
                    }
                }
                tableView.reloadData()
            }
        }
        delete.backgroundColor = .red
        delete.image = UIImage(systemName: Constants.K.trash)
        return UISwipeActionsConfiguration(actions: [delete])
    }

}

extension GbeseListViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
}




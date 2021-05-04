//
//  AddGbeseViewController.swift
//  Gbese Tracker
//
//  Created by Osifeso Adeyemi on 21/02/2021.
//

import UIKit
import UserNotifications
import RealmSwift

class AddGbeseViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    var realm: Realm!
    var gbese: Debt?
    var isEditState: Bool = false
    var gbeseTypeIsLend: Bool!
    var amt = Constants.K.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextDelegate()
        setupDisplay()
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        guard let person = nameTextField.text else { return }
        guard let amount = amountTextField.text else { return }
        if person == Constants.K.emptyString || amount == Constants.K.emptyString {
            Alert.incompleteFormAlert(on: self)
        }else {
            print("i ENTERED AMOUNT guard side")
            guard let amountInDecimal = Formatter.formatToFloat(from: amount, withCurrency: true) else {
                Alert.invalidAmount(on: self,textField: amountTextField)
                return
            }
            let returnDate = datePicker.date
            let currentDate = Date()
            if returnDate < currentDate {
                Alert.invalidDate(on: self)
            } else {
                print("i entered new gbese block")
                //Block for Creating a new Gbese Object
                let newGbese = Debt()
                newGbese.person = person
                newGbese.amount = amountInDecimal
                newGbese.dateCreated = currentDate
                newGbese.returnDate = returnDate
                newGbese.paid = false
                if gbeseTypeIsLend {
                    newGbese.type = Constants.K.lend
                }else {
                    newGbese.type = Constants.K.borrow
                }
                let count = realm.objects(Debt.self).count
                newGbese.autoID = count + 1
                do {
                    try realm.write {
                        realm.add(newGbese)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                let gbeseListVC = storyboard?.instantiateViewController(identifier: "GbeseListViewController") as! GbeseListViewController
                gbeseListVC.realm = realm
                navigationController?.pushViewController(gbeseListVC, animated: true)
            }
           
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        let gbeseListVC = storyboard?.instantiateViewController(identifier: "GbeseListViewController") as! GbeseListViewController
        gbeseListVC.realm = realm
        navigationController?.pushViewController(gbeseListVC, animated: true)
    }
    
    func setUpTextDelegate() {
        amountTextField.delegate = self
        nameTextField.delegate = self
    }
    
    func setupDisplay(){
        _ = GbeseModel.curveAllEdges(object: saveButton)
//        view.addSubview(amountContainerView)
//        amountContainerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
//        amountContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        amountContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
//        amountContainerView.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        amountContainerView.add
        amountTextField.setLineSeparator()
        nameTextField.setLineSeparator()
        
        if gbeseTypeIsLend {
            nameLabel.text = "Enter name of the borrower"
            descriptionLabel.text = "How much are you lending?"
        } else {
            nameLabel.text = "Enter name of the lender"
            descriptionLabel.text = "How much are you borrowing?"
        }
        
        if isEditState {
            guard let gbese = gbese else { return }
            nameTextField.text = gbese.person
            amountTextField.text = Formatter.formatAmountToString(from: gbese.amount, withCurrency: true)
            nameTextField.isEnabled = false
        }else {
            amountTextField.text = Formatter.formatAmountToString(from: Float(Constants.K.zeroInDecimal), withCurrency: true)
        }
    }
    
    //MARK: - Helper Methods
//    func getGbeseDetails(gbese: Debt) -> [String : Any]{
//        let GbeseData: [String : Any] = [Constants.PostGbese.amount:gbese.amount!,Constants.PostGbese.lendDate:gbese.dateCreated!,Constants.PostGbese.person:gbese.person!,Constants.PostGbese.returnDate:gbese.returnDate!,Constants.PostGbese.type:gbese.type!,Constants.PostGbese.paid:false]
//        return GbeseData
//    }
//    
//    func editDetails(for gbese: Debt) -> [String : Any] {
//        return [Constants.PostGbese.amount:gbese.amount!,Constants.PostGbese.returnDate:gbese.returnDate!]
//    }
//    
//    func historyDetail(from gbese: Debt) -> [String : Any] {
//        return [Constants.PostGbese.amount:gbese.amount!]
//    }
    
//    let amountContainerView = UIView()
//    let nameContainerView = UIView()
//
//    lazy var nameTextField: UITextField =  {
//        let textField = BaseTextField(placeHolder: "Recipients Name")
//        textField.delegate = self
//        textField.backgroundColor = .clear
//        return textField
//    }()
//
//    lazy var amountTextField: UITextField =  {
//        let textField = BaseTextField(placeHolder: "0.00")
//        textField.delegate = self
//        textField.backgroundColor = .clear
//        return textField
//    }()
    
    
}

//MARK:- TextField Delegates
extension AddGbeseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == amountTextField {
            if let digit = Int(string) {
                amt = amt * Constants.K.ten + digit
                amountTextField.text = Formatter.formatAmountForTextField(amt: amt)
            }
            
            if string == Constants.K.emptyString {
                amt = amt/Constants.K.ten
                amountTextField.text = Formatter.formatAmountForTextField(amt : amt)
            }
            return false
        } else {
            return true
        }
    }
}

extension UITextField {
    func setLineSeparator(){
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
 
}

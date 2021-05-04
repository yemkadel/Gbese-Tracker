//
//  Alert.swift
//  Gbese Tracker
//
//  Created by Osifeso Adeyemi on 23/02/2021.
//


import Foundation
import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc: UIViewController, with title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    private static func showBasicAlertWithOptions(on vc: UIViewController, with title: String, message: String,action1: String, action2: String,action3: String? = nil,completionHandler: @escaping (String) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: action1, style: .default) { (cancelAction) in
            completionHandler("action1")
        }
        let action2 = UIAlertAction(title: action2, style: .default) { (okAction) in
            completionHandler("action2")
        }
        alert.addAction(action1)
        alert.addAction(action2)
        if action3 != nil {
            let action3 = UIAlertAction(title: action3, style: .default) { (okAction) in
                completionHandler("action3")
            }
            alert.addAction(action3)
        }
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func incompleteFormAlert(on vc: UIViewController){
        showBasicAlert(on: vc, with: "Incomplete Form", message: "Please ensure all fields are filled")
    }
    
    static func loginErrorAlert(on vc: UIViewController, errorMessage: String){
        showBasicAlert(on: vc, with: "Login Error", message: errorMessage)
    }
    
    static func invalidDate(on vc: UIViewController){
        showBasicAlert(on: vc, with: "Invalid Date", message: "Please ensure you select a futuristic date")
    }
    
    static func invalidAmount(on vc: UIViewController, textField: UITextField){
        showBasicAlert(on: vc, with: "Invalid Amount", message: "Please ensure you input a valid amount in the Amount text field")
        textField.text = ""
    }
    
    static func confirmationAlert(on vc: UIViewController, action1: String,action2: String, alertTitle: String, alertMessage: String, completion: @escaping (String) -> Void){
        showBasicAlertWithOptions(on: vc, with: alertTitle, message: alertMessage, action1: action1, action2: action2) { (actionSelected) in
            if actionSelected == "action1" {
                completion("action1")
            } else {
                completion("action2")
            }
        }
    }
    
    static func showAlertForGbeseOptions(vc: UIViewController,action1: String,action2: String,action3: String, alertTitle: String, alertMessage: String, dataController: DataController, completionHandler: @escaping (String) -> Void){
        showBasicAlertWithOptions(on: vc, with: alertTitle, message: alertMessage,action1: action1, action2: action2, action3: action3) { (actionSelected) in
            if actionSelected == "action1" {
                completionHandler("action1")
            } else if actionSelected == "action2" {
                completionHandler("action2")
            } else {
                completionHandler("action3")
            }
        }
    }
}

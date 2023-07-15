//
//  AddToListViewController.swift
//  Milestone4-6
//
//  Created by Orhan Pojskic on 10.07.2023..
//

import UIKit

class AddToListViewController: UIViewController {
    @IBOutlet var textPolje: UITextField!
    @IBOutlet var dugme: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Item"
        navigationItem.largeTitleDisplayMode = .never
        textPolje.returnKeyType = .done
        textPolje.placeholder = "Add your item to shopping list..."
        textPolje.autocapitalizationType = .words
        textPolje.autocorrectionType = .no
        textPolje.becomeFirstResponder()
        textPolje.delegate = self
    }
    
    @IBAction func dugmeTapped(_ sender: UIButton) {
        textPolje.resignFirstResponder()
        guard let item = textPolje.text else { return }
        if item.count > 0{
            NotificationCenter.default.post(name: Notification.Name("text"), object: item)
            self.navigationController?.popToRootViewController(animated: true)
        }else{
            self.navigationController?.popToRootViewController(animated: true)}
        }
    }

    extension AddToListViewController: UITextFieldDelegate{
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textPolje.resignFirstResponder()
            return true
        }
    }


//
//  ViewController.swift
//  Milestone4-6
//
//  Created by Orhan Pojskic on 09.07.2023..
//

import UIKit

class ViewController: UITableViewController {
    var shoppingNiz = [String]()
    var shoppingNizNumbered = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetTapped))
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.rightBarButtonItems = [addButton, shareButton]
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("text"), object: nil)
    }
    
    @objc func didGetNotification(_ notification: Notification){
        let text = notification.object as! String?
        guard let text = text else{return}
        let orderedItem = "\(shoppingNizNumbered.count+1). \(text)"
        shoppingNizNumbered.append(orderedItem.capitalized)
        shoppingNiz.append(text)
        let indexPath = IndexPath(row: shoppingNizNumbered.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
}

extension ViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingNizNumbered.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celija", for: indexPath)
        cell.textLabel?.text = shoppingNizNumbered[indexPath.row]
        return cell
    }
    
    @objc func addTapped() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddToListVC") as? AddToListViewController {
            navigationController?.pushViewController(vc, animated: true)
            }
    }
    
    
    
    @objc func resetTapped(){
        if shoppingNiz.count > 0 || shoppingNizNumbered.count > 0{
            shoppingNiz.removeAll()
            shoppingNizNumbered.removeAll()
            tableView.reloadData()
        }else{
            let vc = UIAlertController(title: "ERROR", message: "Shopping list is already empty!", preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(vc, animated: true)
        }
    }
    
    
    @objc func shareTapped() {
        if shoppingNiz.count > 0{
            let lista = shoppingNiz.joined(separator: "\n")
            let vc = UIActivityViewController(activityItems: [lista], applicationActivities: [])
            present(vc, animated: true)
        }else{
            let vc = UIAlertController(title: "ERROR", message: "Shopping list is empty, nothing to share!", preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(vc, animated: true)
        }
    }
}


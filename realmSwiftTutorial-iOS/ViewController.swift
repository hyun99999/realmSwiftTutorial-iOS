//
//  ViewController.swift
//  realmSwiftTutorial-iOS
//
//  Created by kimhyungyu on 2021/02/28.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    var items: Results<ShoppingList>?
    var realm: Realm?
    var notificationToken: NotificationToken?
    
    @IBOutlet weak var stuffTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        realm = try? Realm()
        
        // shoppingList 데이터들을 가져옴
        items = realm?.objects(ShoppingList.self)
        notificationToken = items?.observe({ (change) in
            print("change:",change)
            self.tableView.reloadData()
        })
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        notificationToken?.invalidate()
    }
    deinit {
        notificationToken?.invalidate()
    }
    
    func inputData(database: ShoppingList) -> ShoppingList {
        if let name = stuffTextField.text {
            database.name = name
        }
        if let price = priceTextField.text {
            database.price = price
        }
        return database
    }
//MARK: - IBAction
    @IBAction func addAction(_ sender: UIButton) {
        try! realm?.write{
            realm?.add(inputData(database: ShoppingList()))
        }
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        do {
            try realm?.write {
                realm?.delete(items!)
            }
        } catch {
            print("error")
        }
    }
    
    @IBAction func readAction(_ sender: UIButton) {
        print(realm?.objects(ShoppingList.self))
    }
    
    @IBAction func updateAction(_ sender: UIButton) {
        try! realm?.write {
            guard let items = items else { return }
            items.forEach({ (list) in
                if let name = stuffTextField.text, let price = priceTextField.text {
                    if list.name == name {
                        list.name = name
                        list.price = price
                    }
                }
            })
        }
    }
}


//
//  ViewController.swift
//  realmSwiftTutorial-iOS
//
//  Created by kimhyungyu on 2021/02/28.
//

import UIKit
import RealmSwift

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items: Results<ShoppingList>?
    var realm: Realm?
    var notificationToken: NotificationToken?
    
    @IBOutlet weak var stuffTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
    func emptyTextField() {
        stuffTextField.text = ""
        priceTextField.text = ""
    }
//MARK: - IBAction
    @IBAction func addAction(_ sender: UIButton) {
        try! realm?.write{
            realm?.add(inputData(database: ShoppingList()))
        }
        emptyTextField()
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        do {
            try realm?.write {
                realm?.delete(items!)
            }
        } catch {
            print("error")
        }
        emptyTextField()
    }
    
    @IBAction func readAction(_ sender: UIButton) {
        print(realm?.objects(ShoppingList.self))
        emptyTextField()
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
        emptyTextField()
    }
    //MARK: - delegate & datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // deqeueResuableCell 의 반환값이 optional 이기 때문에 안전하게 처리하기 위해서 guard 문 작성.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") else { fatalError("error") }

        cell.textLabel?.text = self.items?[indexPath.row].name
        cell.detailTextLabel?.text = self.items?[indexPath.row].price
        
        return cell
    }
}

//
//  ShoppingList.swift
//  realmSwiftTutorial-iOS
//
//  Created by kimhyungyu on 2021/02/28.
//

import Foundation
import RealmSwift

class ShoppingList: Object {
    @objc dynamic var name = ""
    @objc dynamic var price = ""
}

//
//  TodoItem.swift
//  Todoey
//
//  Created by 홍진석 on 2021/01/25.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class TodoItemRealm : Object{
    @objc dynamic var title : String = ""
    @objc dynamic var check : Bool = false
    @objc dynamic var dataCreated : Date?
    var parentCategory = LinkingObjects(fromType: CategoryRealm.self, property: "TodoItems")
}

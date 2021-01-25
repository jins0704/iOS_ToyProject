//
//  Category.swift
//  Todoey
//
//  Created by 홍진석 on 2021/01/25.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryRealm : Object{
    @objc dynamic var name : String = ""
    
    let TodoItems = List<TodoItemRealm>()
}

//
//  ategory.swift
//  Todoey
//
//  Created by William Keiter on 10/2/18.
//  Copyright © 2018 William Keiter. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}

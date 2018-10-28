//
//  Color.swift
//  Todoey
//
//  Created by William Keiter on 10/24/18.
//  Copyright © 2018 William Keiter. All rights reserved.
//

import Foundation
import RealmSwift

class Color: Object {
    @objc dynamic var color: String = ""
    var parentCategory = LinkingObjects(fromType: Category.self, property: "colors")

}

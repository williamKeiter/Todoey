//
//  Data.swift
//  Todoey
//
//  Created by William Keiter on 10/1/18.
//  Copyright © 2018 William Keiter. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @ objc dynamic var name: String = ""
    @ objc dynamic var age: Int = 0
}

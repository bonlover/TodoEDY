//
//  Item.swift
//  TodoEDY
//
//  Created by Yungdrung Gyaltsen on 11/23/18.
//  Copyright © 2018 Yungdrung Gyaltsen. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var createdAt : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

//
//  Category.swift
//  TodoEDY
//
//  Created by Yungdrung Gyaltsen on 11/23/18.
//  Copyright © 2018 Yungdrung Gyaltsen. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
    
}

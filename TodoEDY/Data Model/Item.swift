//
//  Item.swift
//  TodoEDY
//
//  Created by Yungdrung Gyaltsen on 11/20/18.
//  Copyright © 2018 Yungdrung Gyaltsen. All rights reserved.
//

import Foundation

//Instead of writing Encodable, Decodable just write Codable
class Item : Codable {
    var title : String = ""
    var done : Bool = false 
}

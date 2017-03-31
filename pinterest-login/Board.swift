//
//  Board.swift
//  pinterest-login
//
//  Created by Shea Furey-King on 3/28/17.
//  Copyright © 2017 sfk. All rights reserved.
//

import UIKit
import SwiftyJSON

class Board {

    var description: String? = ""
    var name: String? = ""
    var id: String? = ""
    var pins: Int? = 0
    
    init(name: String){
        self.name = name
    }
    
    convenience init?(json: JSON) {
        if let name = json["name"].string {
            self.init(name: name)
            self.description = json["description"].string
            self.name = json["name"].string
            self.id = json["id"].string
            self.pins = json["pins"].int
            
            return
        }
        return nil
    }
    
}

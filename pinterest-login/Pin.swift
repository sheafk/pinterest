//
//  Pin.swift
//  pinterest-login
//
//  Created by Shea Furey-King on 3/28/17.
//  Copyright © 2017 sfk. All rights reserved.
//

import UIKit
import SwiftyJSON

class Pin {
    
    var image: String? = ""
    var note: String? = ""
    
    init(note: String){
        self.note = note
    }
    
    convenience init?(json: JSON) {
        if let note = json["note"].string {
            self.init(note: note)
            self.image = json["image"]["original"]["url"].stringValue
            
            return
        }
        return nil
    }

}

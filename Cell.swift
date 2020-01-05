//
//  Cell.swift
//  Challenge4
//
//  Created by Gabriel Lops on 1/5/20.
//  Copyright © 2020 Gabriel Lops. All rights reserved.
//

import UIKit

class Cell: NSObject, Codable {
    var caption: String
    var image: String
    
    init(caption: String, image: String){
    self.caption = caption
    self.image = image
    }
}



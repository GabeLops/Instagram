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
    var fileName: String
    
    init(caption: String, fileName: String){
    self.caption = caption
    self.fileName = fileName
    }
}



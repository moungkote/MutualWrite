//
//  Category.swift
//  Mutualwrite
//
//  Created by MSlagger on 19/1/2561 BE.
//  Copyright © 2561 Chitsanucha. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Category {
  
  var name: String
  var imageURL : String
  
  init(snap:DataSnapshot) {
    let data = snap.value as! [String : AnyObject]
    self.name = data["title"] as! String
    self.imageURL = data["imageURL"] as! String
  }
  
}

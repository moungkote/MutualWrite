//
//  Comment.swift
//  Mutualwrite
//
//  Created by Sritongsuk on 20/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Comment {
  
  var id: String?
  var userID: String?
  var comment: String?
  var hightLightRange: NSRange?
  
  init(withDataSnapshot snapshot: DataSnapshot) {
    let attribute = snapshot.value as! [String: Any]
    id = attribute["id"] as? String
    userID = attribute["userId"] as? String
    comment = attribute["comment"] as? String
    let location = attribute["location"] as! Int
    let length = attribute["length"] as! Int
    hightLightRange = NSRange.init(location: location, length: length)
  }
  
  static func commentArray(snapshots: [DataSnapshot]) -> [Comment] {
    return snapshots.map({ Comment(withDataSnapshot: $0) })
  }
  
}
